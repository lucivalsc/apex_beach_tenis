/**
 * Handler para operações POST
 * @param {Object} req - Objeto de requisição
 * @param {Object} res - Objeto de resposta
 * @param {Object} sequelize - Instância do Sequelize
 * @param {Object} Sequelize - Classe Sequelize para tipos de queries
 */
const cache = require('../../utils/cache');
const { DataTypes } = require('sequelize');
const { ApiError, ErrorCodes } = require('../../utils/errorHandler');
const logger = require('../../utils/logger');

// Criar um logger específico para operações POST
const postLogger = logger.getSubLogger('postHandler');
const postHandler = async (req, res, sequelize, Sequelize) => {
    const { entity, data } = req.body;

    let insertedData = [];

    // Verifica se data é um array ou objeto
    const dataArray = Array.isArray(data) ? data : [data];
    
    // Se data for um array vazio, retorna sucesso sem inserir nada
    if (dataArray.length === 0) {
        return res.status(200).json({
            success: true,
            message: 'Nenhum dado para inserir.',
            data: [],
            failure: false
        });
    }

    try {
        // Obter o modelo correspondente à entidade
        const model = Object.values(sequelize.models).find(
            m => m.tableName.toLowerCase() === entity.toLowerCase()
        );

        if (!model) {
            return res.status(400).json({
                success: false,
                message: `Entidade '${entity}' não encontrada`,
                failure: true
            });
        }

        // Processa cada item do array
        for (const item of dataArray) {
            // Verifica se o item tem propriedades
            if (Object.keys(item).length === 0) {
                continue; // Pula objetos vazios
            }

            try {
                // Obter os atributos do modelo para identificar campos de data
                const modelAttributes = model.rawAttributes;
                const dateFields = Object.keys(modelAttributes).filter(attr => 
                    modelAttributes[attr].type instanceof DataTypes.DATE || 
                    modelAttributes[attr].type instanceof DataTypes.DATEONLY
                );
                
                // Criar uma cópia do item para não modificar o original
                const itemToCreate = { ...item };
                
                // Preservar os campos de data enviados no body
                // Se o campo de data não foi fornecido, deixar o Sequelize usar o valor padrão
                for (const dateField of dateFields) {
                    if (itemToCreate[dateField] === undefined || itemToCreate[dateField] === null) {
                        // Se o campo não foi fornecido, não fazemos nada e deixamos o Sequelize usar o padrão
                        continue;
                    }
                    
                    // Se o campo foi fornecido, garantimos que seja usado exatamente como está
                    // Sem nenhuma conversão automática de timezone pelo Sequelize
                    if (typeof itemToCreate[dateField] === 'string') {
                        // Já é uma string de data, mantemos como está
                        postLogger.debug(`Preservando data original para campo ${dateField}:`, {
                            value: itemToCreate[dateField]
                        });
                        continue;
                    } else if (itemToCreate[dateField] instanceof Date) {
                        // Convertemos para string ISO para evitar conversões automáticas
                        itemToCreate[dateField] = itemToCreate[dateField].toISOString();
                        postLogger.debug(`Convertendo objeto Date para string ISO para campo ${dateField}:`, {
                            value: itemToCreate[dateField]
                        });
                    }
                }
                
                // Em vez de usar model.create, vamos usar uma query SQL raw para preservar exatamente as datas originais
                // Preparar os campos e valores para a query INSERT
                const fields = Object.keys(itemToCreate);
                const placeholders = fields.map(() => '?').join(', ');
                const values = fields.map(field => itemToCreate[field]);
                
                // Construir a query SQL INSERT
                const insertQuery = `INSERT INTO ${model.tableName} (${fields.join(', ')}) VALUES (${placeholders})`;
                
                postLogger.debug('Executando query de inserção', {
                    query: insertQuery,
                    entity,
                    fields
                });
                
                // Executar a query com typeCast para preservar o formato original das datas
                const [result] = await sequelize.query(insertQuery, {
                    replacements: values,
                    type: Sequelize.QueryTypes.INSERT,
                    // Função typeCast para preservar o formato original das datas
                    typeCast: function (field, next) {
                        // Para campos de data/hora, retornar a string original
                        if (field.type === 'DATETIME' || field.type === 'TIMESTAMP' || field.type === 'DATE') {
                            return field.string();
                        }
                        return next();
                    }
                });
                
                // Após a inserção, buscar o registro inserido para retornar ao cliente
                // Mas usar o objeto original para garantir que as datas estejam corretas
                const insertedItem = { ...itemToCreate };
                
                // Adicionar ao array de resultados
                insertedData.push(insertedItem);
            } catch (error) {
                console.error(`Erro ao inserir registro: ${error.message}`);
                return res.status(500).json({
                    success: false,
                    message: `Erro ao inserir dados: ${error.message}`,
                    failure: true
                });
            }
        }

        // Invalidar o cache para esta entidade após inserção
        cache.del(entity);

        // Retornando a resposta de sucesso com os dados
        return res.status(200).json({
            success: true,
            message: `${insertedData.length} registro(s) inserido(s) com sucesso.`,
            data: Array.isArray(data) ? insertedData : insertedData[0] || null,
            failure: false
        });
    } catch (error) {
        console.error(`Erro ao processar requisição: ${error.message}`);
        return res.status(500).json({
            success: false,
            message: `Erro ao processar requisição: ${error.message}`,
            failure: true
        });
    }
};

module.exports = postHandler;