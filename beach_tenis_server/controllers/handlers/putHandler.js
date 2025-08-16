/**
 * Handler para operações PUT/PATCH
 * @param {Object} req - Objeto de requisição
 * @param {Object} res - Objeto de resposta
 * @param {Object} sequelize - Instância do Sequelize
 * @param {Object} Sequelize - Classe Sequelize para tipos de queries
 * @param {Function} buildWhereClause - Função para construir cláusulas WHERE
 */
const cache = require('../../utils/cache');
const { DataTypes } = require('sequelize');
const { ApiError, ErrorCodes } = require('../../utils/errorHandler');
const logger = require('../../utils/logger');

// Criar um logger específico para operações PUT
const putLogger = logger.getSubLogger('putHandler');
const putHandler = async (req, res, sequelize, Sequelize, buildWhereClause) => {
    const { entity, data, filter } = req.body;

    if (!filter || filter.length === 0) {
        return res.status(400).json({ success: false, message: 'Filter is required for updates.', failure: true });
    }

    const tableName = `\`${entity}\``;
    let query = '';
    let replacements = {};
    
    // Obter o modelo correspondente à entidade para identificar campos de data
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
    
    // Criar uma cópia dos dados para não modificar o original
    const dataToUpdate = { ...data };
    
    // Identificar campos de data no modelo
    const modelAttributes = model.rawAttributes;
    const dateFields = Object.keys(modelAttributes).filter(attr => 
        modelAttributes[attr].type instanceof DataTypes.DATE || 
        modelAttributes[attr].type instanceof DataTypes.DATEONLY
    );
    
    // Preservar os campos de data enviados no body
    for (const dateField of dateFields) {
        if (dataToUpdate[dateField] === undefined || dataToUpdate[dateField] === null) {
            // Se o campo não foi fornecido, não fazemos nada
            continue;
        }
        
        // Se o campo foi fornecido, garantimos que seja usado exatamente como está
        // Sem nenhuma conversão automática de timezone
        if (typeof dataToUpdate[dateField] === 'string') {
            // Já é uma string de data, mantemos como está
            putLogger.debug(`Preservando data original para campo ${dateField}:`, {
                value: dataToUpdate[dateField]
            });
            continue;
        } else if (dataToUpdate[dateField] instanceof Date) {
            // Convertemos para string ISO para evitar conversões automáticas
            dataToUpdate[dateField] = dataToUpdate[dateField].toISOString();
            putLogger.debug(`Convertendo objeto Date para string ISO para campo ${dateField}:`, {
                value: dataToUpdate[dateField]
            });
        }
    }

    const updates = Object.keys(dataToUpdate).map((key, index) => `\`${key}\` = :update${index}`).join(', ');
    replacements = {
        ...Object.fromEntries(Object.entries(dataToUpdate).map(([key, value], index) => [`update${index}`, value]))
    };

    let whereClausePart = '';
    const { clause: whereClause, replacements: whereReplacements } = buildWhereClause(filter);
    if (whereClause) {
        whereClausePart = ` WHERE ${whereClause}`;
        replacements = { ...replacements, ...whereReplacements };
    }

    query = `UPDATE ${tableName} SET ${updates} ${whereClausePart}`;

    // Executando a query de atualização
    putLogger.debug('Executando query de atualização', {
        query,
        entity,
        updates
    });
    
    // Executar a query com typeCast para preservar o formato original das datas
    await sequelize.query(query, {
        type: Sequelize.QueryTypes.UPDATE,
        replacements,
        // Função typeCast para preservar o formato original das datas
        typeCast: function (field, next) {
            // Para campos de data/hora, retornar a string original
            if (field.type === 'DATETIME' || field.type === 'TIMESTAMP' || field.type === 'DATE') {
                return field.string();
            }
            return next();
        }
    });

    // Buscando os registros atualizados para retornar
    putLogger.debug('Buscando registros atualizados', {
        query: `SELECT * FROM ${tableName} ${whereClausePart}`,
        entity
    });
    
    // Usar typeCast para preservar o formato original das datas na consulta de seleção
    const [updatedData] = await sequelize.query(
        `SELECT * FROM ${tableName} ${whereClausePart}`,
        {
            replacements: whereReplacements,
            type: Sequelize.QueryTypes.SELECT,
            // Função typeCast para preservar o formato original das datas
            typeCast: function (field, next) {
                // Para campos de data/hora, retornar a string original
                if (field.type === 'DATETIME' || field.type === 'TIMESTAMP' || field.type === 'DATE') {
                    return field.string();
                }
                return next();
            }
        }
    );
    
    // Restaurar os campos de data originais do body para o resultado
    // Se os dados retornados forem um array
    if (Array.isArray(updatedData)) {
        updatedData.forEach(record => {
            for (const dateField of dateFields) {
                if (data[dateField] !== undefined && data[dateField] !== null) {
                    // Usar a data original do body em vez da data convertida
                    record[dateField] = data[dateField];
                }
            }
        });
    } 
    // Se os dados retornados forem um único objeto
    else if (updatedData) {
        for (const dateField of dateFields) {
            if (data[dateField] !== undefined && data[dateField] !== null) {
                // Usar a data original do body em vez da data convertida
                updatedData[dateField] = data[dateField];
            }
        }
    }

    // Invalidar o cache para esta entidade após atualização
    cache.del(entity);

    // Retornando a resposta de sucesso com os dados
    return res.status(200).json({
        success: true,
        message: 'Dados atualizados com sucesso.',
        data: updatedData,
        failure: false
    });
};

module.exports = putHandler;