/**
 * Handler para operações GET
 * @param {Object} req - Objeto de requisição
 * @param {Object} res - Objeto de resposta
 * @param {Object} sequelize - Instância do Sequelize
 * @param {Function} buildWhereClause - Função para construir cláusulas WHERE
 */
const { ApiError, ErrorCodes } = require('../../utils/errorHandler');
const { 
    sanitizeTableName, 
    sanitizeColumnNames, 
    sanitizeOrderBy,
    sanitizeJoins
} = require('../../utils/sqlSanitizer');
const cache = require('../../utils/cache');
const logger = require('../../utils/logger');
const { Sequelize } = require('sequelize');

// Criar um logger específico para operações GET
const getLogger = logger.getSubLogger('getHandler');

/**
 * Função para mapear operadores para SQL
 * @param {string} operator - Operador a ser mapeado
 * @returns {string} - Operador SQL correspondente
 */
function mapOperatorToSQL(operator) {
    switch (operator) {
        case 'eq': return '=';
        case 'ne': return '<>';
        case 'gt': return '>';
        case 'gte': return '>=';
        case 'lt': return '<';
        case 'lte': return '<=';
        case 'cont': return 'LIKE';
        case 'in': return 'IN';
        case 'notin': return 'NOT IN';
        case 'isnull': return 'IS NULL';
        case 'notnull': return 'IS NOT NULL';
        case 'starts': return 'LIKE';
        case 'ends': return 'LIKE';
        case 'between': return 'BETWEEN';
        default: throw new Error(`Operador não suportado: ${operator}`);
    }
}

/**
 * Função para gerar a cláusula WHERE e os substitutos para dbmGet
 * @param {Array} filters - Array de filtros
 * @returns {Object} - Objeto com cláusula WHERE e substituições
 */
function buildWhereClauseForDbmGet(filters) {
    if (!filters || filters.length === 0) {
        return { clause: '', replacements: {} };
    }

    const clause = filters
        .map((f, idx) => {
            const operator = mapOperatorToSQL(f.operator);
            const column = f.column.includes('.') ? `\`${f.column.replace('.', '\`.\`')}\`` : `\`${f.column}\``;

            if (f.operator === 'between') {
                return `${column} ${operator} :${f.column.replace('.', '_')}Start AND :${f.column.replace('.', '_')}End`;
            } else if (f.operator === 'in') {
                return `${column} ${operator} (:${f.column.replace('.', '_')}${idx})`;
            } else if (f.operator === 'isnull' || f.operator === 'notnull') {
                // Para operadores IS NULL e IS NOT NULL, não precisamos de placeholder
                return `${column} ${operator}`;
            } else {
                return `${column} ${operator} :${f.column.replace('.', '_')}${idx}`;
            }
        })
        .join(' AND ');

    const replacements = {};
    filters.forEach((f, idx) => {
        if (f.operator === 'between') {
            replacements[`${f.column.replace('.', '_')}Start`] = f.value[0];
            replacements[`${f.column.replace('.', '_')}End`] = f.value[1];
        } else if (f.operator === 'in') {
            replacements[`${f.column.replace('.', '_')}${idx}`] = f.value;
        } else if (f.operator !== 'isnull' && f.operator !== 'notnull') {
            // Não adicionar valores para operadores IS NULL e IS NOT NULL
            replacements[`${f.column.replace('.', '_')}${idx}`] = f.value;
        }
    });

    return { clause: ' WHERE ' + clause, replacements };
}

const getHandler = async (req, res, sequelize, buildWhereClause) => {
    try {
        const {
            entity, alias, data, joins, filter, groupBy, orderBy, offset, limit, 
            select, addSelect, joinType
        } = req.body;

        // Verificações adicionais que podem não ter sido capturadas pela validação Joi
        if (!entity) {
            throw new ApiError(ErrorCodes.MISSING_REQUIRED_FIELD, 'Entidade é obrigatória');
        }

        const actualLimit = limit || 100;
        const actualOffset = offset || 0;
        
        // --- CACHE DE CONSULTAS ---
        // Incluir todos os parâmetros relevantes na chave de cache, incluindo os novos parâmetros
        const cacheParams = { 
            joins, 
            filter, 
            groupBy, 
            orderBy, 
            offset: actualOffset, 
            limit: actualLimit,
            // Incluir os novos parâmetros
            select: select || (data && data.select) || null,
            addSelect: addSelect || null,
            joinType: joinType || null
        };
        
        const cacheResult = cache.get(entity, cacheParams);
        if (cacheResult) {
            getLogger.debug(`Resultado obtido do cache para entidade: ${entity}`, {
                entity,
                params: {
                    ...cacheParams,
                    // Omitir detalhes muito grandes no log
                    joins: joins ? 'presente' : 'ausente',
                    filter: filter ? 'presente' : 'ausente'
                }
            });
            
            return res.status(200).json({
                success: true,
                data: cacheResult.data,
                totalItems: cacheResult.totalItems,
                totalPages: cacheResult.totalPages,
                fromCache: true,
                failure: false
            });
        }
        
        getLogger.debug(`Consultando banco de dados para entidade: ${entity}`, {
            entity,
            params: cacheParams
        });

        // Sanitizar o nome da tabela para prevenir injeção SQL
        const tableName = sanitizeTableName(entity);
        let replacements = {};

        try {
            // Construção da parte WHERE que será usada tanto na query principal quanto na de contagem
            const { clause: whereClause, replacements: whereReplacements } = buildWhereClause(filter);
            if (whereClause) {
                replacements = { ...replacements, ...whereReplacements };
            }

            // Query para contagem total de registros
            let countQuery = `SELECT COUNT(*) as total FROM ${tableName} ${alias || ''}`;
            
            // Adicionando JOINs à query de contagem se existirem
            if (joins && Array.isArray(joins) && joins.length > 0) {
                try {
                    // Processar cada join com seu tipo específico (mesmo código usado na query principal)
                    const processedJoins = joins.map(join => {
                        // Verificar se o join tem as propriedades necessárias
                        if (!join.table) {
                            throw new ApiError(ErrorCodes.INVALID_PARAMETER, 'Tabela não especificada no join');
                        }
                        
                        // Sanitizar o nome da tabela
                        const joinTable = sanitizeTableName(join.table);
                        
                        // Determinar o tipo de join (padrão é INNER JOIN se não especificado)
                        let type = 'INNER JOIN';
                        
                        // Se o tipo de join for especificado no próprio join
                        if (join.type) {
                            const validTypes = ['INNER JOIN', 'LEFT JOIN', 'RIGHT JOIN', 'OUTER JOIN', 'FULL OUTER JOIN', 'CROSS JOIN'];
                            const upperType = join.type.toUpperCase();
                            
                            if (!validTypes.includes(upperType)) {
                                throw new ApiError(ErrorCodes.INVALID_PARAMETER, `Tipo de join inválido: ${join.type}`);
                            }
                            
                            type = upperType;
                        }
                        // Se o tipo de join for especificado globalmente (para todos os joins)
                        else if (joinType) {
                            const validTypes = ['INNER', 'LEFT', 'RIGHT', 'OUTER', 'FULL OUTER', 'CROSS'];
                            const upperType = joinType.toUpperCase();
                            
                            if (!validTypes.includes(upperType)) {
                                throw new ApiError(ErrorCodes.INVALID_PARAMETER, `Tipo de join global inválido: ${joinType}`);
                            }
                            
                            type = `${upperType} JOIN`;
                        }
                        
                        // Construir a cláusula JOIN
                        let joinClause = `${type} ${joinTable}`;
                        
                        // Adicionar alias se fornecido
                        if (join.alias) {
                            joinClause += ` AS ${join.alias}`;
                        }
                        
                        // Adicionar condição ON
                        if (join.on) {
                            // Sanitizar a condição ON
                            const sanitizedOn = join.on.replace(/[;\-\'\"]|--/g, '');
                            joinClause += ` ON ${sanitizedOn}`;
                        } else {
                            throw new ApiError(ErrorCodes.INVALID_PARAMETER, 'Condição ON não especificada no join');
                        }
                        
                        return joinClause;
                    });
                    
                    countQuery += ` ${processedJoins.join(' ')}`;
                } catch (error) {
                    throw new ApiError(ErrorCodes.INVALID_PARAMETER, 'Definição de joins inválida', {
                        details: error.message
                    });
                }
            }
            
            if (whereClause) {
                countQuery += ` WHERE ${whereClause}`;
            }

            // Se tiver GROUP BY, a contagem precisa considerar o agrupamento
            if (groupBy && groupBy.length > 0) {
                countQuery = `SELECT COUNT(*) as total FROM (${countQuery} GROUP BY ${groupBy.map(col => `\`${col}\``).join(', ')}) as subquery`;
            }

            // Query principal para buscar os dados
            let dataQuery = `SELECT `;
            
            // Sanitizar colunas selecionadas
            try {
                // Verificar se há select específico no novo formato
                if (select && Array.isArray(select) && select.length > 0) {
                    const sanitizedColumns = sanitizeColumnNames(select);
                    dataQuery += sanitizedColumns.join(', ');
                }
                // Verificar se há select específico no formato antigo (compatibilidade)
                else if (data && data.select && Array.isArray(data.select) && data.select.length > 0) {
                    const sanitizedColumns = sanitizeColumnNames(data.select);
                    dataQuery += sanitizedColumns.join(', ');
                } 
                // Se não houver select específico, selecionar todas as colunas
                else {
                    dataQuery += '*';
                }
                
                // Adicionar funções agregadas (COUNT, SUM, etc.) se existirem
                if (addSelect && Array.isArray(addSelect) && addSelect.length > 0) {
                    // Verificar se estamos usando * e precisamos substituir por colunas específicas
                    // Se estamos usando * e adicionando funções agregadas, precisamos de uma vírgula
                    if (dataQuery.endsWith('* ')) {
                        // Remover o espaço após o asterisco
                        dataQuery = dataQuery.slice(0, -1);
                        // Adicionar vírgula após o asterisco
                        dataQuery += ', ';
                    } 
                    // Se já temos colunas selecionadas, adicionar vírgula
                    else if ((select && select.length > 0) || (data && data.select && data.select.length > 0)) {
                        dataQuery += ', ';
                    }
                    
                    // Processar cada expressão adicional (COUNT, SUM, etc.)
                    const sanitizedAddSelects = addSelect.map(item => {
                        // Verificar se o item é uma string direta ou um objeto estruturado
                        if (typeof item === 'string') {
                            // Usar a expressão SQL diretamente, mas com sanitização básica
                            // Remover caracteres potencialmente perigosos
                            return item.replace(/[;\-\'\"]|--/g, '');
                        } else if (typeof item === 'object') {
                            // Verificar se o item tem função e coluna
                            if (!item.function || !item.column) {
                                throw new ApiError(ErrorCodes.INVALID_PARAMETER, 'Função ou coluna não especificada em addSelect');
                            }
                            
                            // Lista de funções permitidas
                            const allowedFunctions = ['COUNT', 'SUM', 'AVG', 'MIN', 'MAX', 'DISTINCT'];
                            const func = item.function.toUpperCase();
                            
                            if (!allowedFunctions.includes(func)) {
                                throw new ApiError(ErrorCodes.INVALID_PARAMETER, `Função não permitida: ${item.function}`);
                            }
                            
                            // Sanitizar o nome da coluna
                            const sanitizedColumn = sanitizeColumnNames([item.column])[0];
                            
                            // Construir a expressão com alias se fornecido
                            let expression = `${func}(${sanitizedColumn})`;
                            if (item.alias) {
                                expression += ` AS \`${item.alias}\``;
                            }
                            
                            return expression;
                        } else {
                            throw new ApiError(ErrorCodes.INVALID_PARAMETER, 'Formato inválido em addSelect. Use string ou objeto.');
                        }
                    });
                    
                    dataQuery += sanitizedAddSelects.join(', ');
                }
            } catch (error) {
                throw new ApiError(ErrorCodes.INVALID_PARAMETER, 'Seleção de colunas inválida', {
                    details: error.message
                });
            }
            
            dataQuery += ` FROM ${tableName} ${alias || ''}`;
            
            // Adicionando JOINs se existirem
            if (joins && Array.isArray(joins) && joins.length > 0) {
                try {
                    getLogger.debug('Processando joins', {
                        joins,
                        entity,
                        alias,
                        joinType
                    });
                    
                    // Processar cada join com seu tipo específico
                    const processedJoins = joins.map(join => {
                        // Verificar se o join tem as propriedades necessárias
                        if (!join.table) {
                            throw new ApiError(ErrorCodes.INVALID_PARAMETER, 'Tabela não especificada no join');
                        }
                        
                        // Sanitizar o nome da tabela
                        const joinTable = sanitizeTableName(join.table);
                        
                        // Determinar o tipo de join (padrão é INNER JOIN se não especificado)
                        let type = 'INNER JOIN';
                        
                        // Se o tipo de join for especificado no próprio join
                        if (join.type) {
                            const validTypes = ['INNER JOIN', 'LEFT JOIN', 'RIGHT JOIN', 'OUTER JOIN', 'FULL OUTER JOIN', 'CROSS JOIN'];
                            const upperType = join.type.toUpperCase();
                            
                            if (!validTypes.includes(upperType)) {
                                throw new ApiError(ErrorCodes.INVALID_PARAMETER, `Tipo de join inválido: ${join.type}`);
                            }
                            
                            type = upperType;
                        }
                        // Se o tipo de join for especificado globalmente (para todos os joins)
                        else if (joinType) {
                            const validTypes = ['INNER', 'LEFT', 'RIGHT', 'OUTER', 'FULL OUTER', 'CROSS'];
                            const upperType = joinType.toUpperCase();
                            
                            if (!validTypes.includes(upperType)) {
                                throw new ApiError(ErrorCodes.INVALID_PARAMETER, `Tipo de join global inválido: ${joinType}`);
                            }
                            
                            type = `${upperType} JOIN`;
                        }
                        
                        // Construir a cláusula JOIN
                        let joinClause = `${type} ${joinTable}`;
                        
                        // Adicionar alias se fornecido
                        if (join.alias) {
                            joinClause += ` AS ${join.alias}`;
                        }
                        
                        // Adicionar condição ON
                        if (join.on) {
                            // Sanitizar a condição ON
                            const sanitizedOn = join.on.replace(/[;\-\'\"]|--/g, '');
                            joinClause += ` ON ${sanitizedOn}`;
                        } else {
                            throw new ApiError(ErrorCodes.INVALID_PARAMETER, 'Condição ON não especificada no join');
                        }
                        
                        return joinClause;
                    });
                    
                    dataQuery += ` ${processedJoins.join(' ')}`;
                } catch (error) {
                    throw new ApiError(ErrorCodes.INVALID_PARAMETER, 'Definição de joins inválida', {
                        details: error.message
                    });
                }
            }

            // Adicionando filtros (WHERE)
            if (whereClause) {
                dataQuery += ` WHERE ${whereClause}`;
            }

            // Adicionando GROUP BY
            if (groupBy && groupBy.length > 0) {
                try {
                    const sanitizedGroupBy = sanitizeColumnNames(groupBy);
                    dataQuery += ` GROUP BY ${sanitizedGroupBy.join(', ')}`;
                } catch (error) {
                    throw new ApiError(ErrorCodes.INVALID_PARAMETER, 'Agrupamento inválido', {
                        details: error.message
                    });
                }
            }

            // Adicionando ORDER BY
            if (orderBy && orderBy.length > 0) {
                try {
                    const sanitizedOrderBy = sanitizeOrderBy(orderBy);
                    dataQuery += ` ORDER BY ${sanitizedOrderBy}`;
                } catch (error) {
                    throw new ApiError(ErrorCodes.INVALID_PARAMETER, 'Ordenação inválida', {
                        details: error.message
                    });
                }
            }

            // Adicionando OFFSET e LIMIT
            dataQuery += ` LIMIT ${actualLimit} OFFSET ${actualOffset}`;
            console.log("Data Query:", dataQuery);
            console.log("Count Query:", countQuery);

            // Executando as queries
            try {
                getLogger.debug('Executando query de contagem', {
                    query: countQuery,
                    entity
                });
                
                const [countResults] = await sequelize.query(countQuery, { replacements });
                
                // Verificar se há resultados da contagem
                if (!countResults || countResults.length === 0) {
                    // Tabela não existe ou está vazia
                    throw new ApiError(ErrorCodes.ENTITY_NOT_FOUND, `Entidade '${entity}' não encontrada`, { entity });
                }
                
                // Calculando a quantidade total de itens
                const totalItems = countResults[0]?.total || 0;
                
                // Executar a query principal para buscar os dados
                getLogger.debug('Executando query principal', {
                    query: dataQuery,
                    entity
                });
                
                // Adicionar typeCast para preservar o formato original das datas
                const [results] = await sequelize.query(dataQuery, { 
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

                // Calculando a quantidade total de páginas
                const totalPages = Math.ceil(totalItems / actualLimit);
                
                // Processar os resultados para garantir que as datas estão no formato correto
                if (results && results.length > 0) {
                    results.forEach(record => {
                        Object.keys(record).forEach(field => {
                            // Se ainda houver algum objeto Date, convertê-lo para string ISO
                            if (record[field] instanceof Date) {
                                record[field] = record[field].toISOString();
                            }
                        });
                    });
                }

                // Salvar no cache antes de retornar
                getLogger.debug(`Salvando resultado no cache para entidade: ${entity}`, {
                    entity,
                    totalItems,
                    totalPages
                });
                
                cache.set(entity, cacheParams, {
                    data: results,
                    totalItems,
                    totalPages
                });

                return res.status(200).json({
                    success: true,
                    data: results,
                    pagination: {
                        totalItems,
                        totalPages,
                        currentPage: Math.floor(actualOffset / actualLimit) + 1,
                        itemsPerPage: actualLimit
                    },
                    failure: false
                });
            } catch (queryError) {
                // Erro específico para problemas na execução da query
                getLogger.error(`Erro ao executar consulta para entidade: ${entity}`, {
                    entity,
                    error: queryError.message,
                    stack: queryError.stack,
                    query: dataQuery
                });
                
                throw new ApiError(ErrorCodes.QUERY_ERROR, 'Erro ao executar consulta SQL', {
                    entity,
                    details: queryError.message
                });
            }
        } catch (filterError) {
            // Erro específico para problemas na construção do filtro
            getLogger.error(`Erro ao processar filtros para entidade: ${entity}`, {
                entity,
                filter,
                error: filterError.message,
                stack: filterError.stack
            });
            
            if (filterError instanceof ApiError) {
                throw filterError;
            }
            throw new ApiError(ErrorCodes.INVALID_FILTER, 'Erro ao processar filtros da consulta', {
                details: filterError.message
            });
        }
    } catch (error) {
        // Se já for um ApiError, propaga
        if (error instanceof ApiError) {
            throw error;
        }
        // Caso contrário, cria um erro genérico
        getLogger.error('Erro inesperado ao processar consulta', {
            entity,
            error: error.message,
            stack: error.stack
        });
        
        throw new ApiError(ErrorCodes.UNEXPECTED_ERROR, 'Erro ao processar consulta', {
            details: error.message
        });
    }
};

/**
 * Handler para operação dbmGet
 * @param {Object} req - Objeto de requisição
 * @param {Object} res - Objeto de resposta
 * @param {Object} sequelize - Instância do Sequelize
 */
getHandler.dbmGet = async (req, res, sequelize) => {
    const { entity, alias, select, leftJoin, innerJoin, rightJoin, outerJoin, filter, groupBy, orderBy, limit, offset } = req.body;

    if (!entity) {
        return res.status(400).json({ success: false, message: 'Entidade é obrigatória.', failure: true });
    }

    try {
        // Início da consulta
        let query = `SELECT ${select && select.length > 0 ? select.join(', ') : '*'} FROM \`${entity}\` ${alias ? alias : ''}`;

        getLogger.debug(`Início da consulta dbmGet para entidade: ${entity}`);

        // Adicionando LEFT JOINs
        if (leftJoin && leftJoin.length > 0) {
            leftJoin.forEach(join => {
                query += ` LEFT JOIN \`${join.table}\` ${join.alias} ON ${join.condition}`;
            });
        }
        
        // Adicionando INNER JOINs
        if (innerJoin && innerJoin.length > 0) {
            innerJoin.forEach(join => {
                query += ` INNER JOIN \`${join.table}\` ${join.alias} ON ${join.condition}`;
            });
        }
        
        // Adicionando RIGHT JOINs
        if (rightJoin && rightJoin.length > 0) {
            rightJoin.forEach(join => {
                query += ` RIGHT JOIN \`${join.table}\` ${join.alias} ON ${join.condition}`;
            });
        }
        
        // Adicionando OUTER JOINs (FULL OUTER JOIN)
        if (outerJoin && outerJoin.length > 0) {
            outerJoin.forEach(join => {
                // MySQL não suporta FULL OUTER JOIN diretamente, então usamos LEFT JOIN + RIGHT JOIN com UNION
                // Mas para manter a simplicidade da API, vamos usar LEFT JOIN OUTER que é mais próximo
                query += ` LEFT OUTER JOIN \`${join.table}\` ${join.alias} ON ${join.condition}`;
            });
        }

        // Adicionando filtros (WHERE)
        let replacements = {};
        if (filter && filter.length > 0) {
            const { clause, replacements: whereReplacements } = buildWhereClauseForDbmGet(filter);
            query += clause;
            replacements = { ...replacements, ...whereReplacements };
        }

        // Adicionando GROUP BY
        if (groupBy && groupBy.length > 0) {
            query += ` GROUP BY ${groupBy.join(', ')}`;
        }

        // Adicionando ORDER BY
        if (orderBy && orderBy.length > 0) {
            const orderClauses = orderBy
                .filter(o => o.column && o.type) // Garante que a coluna e o tipo sejam válidos
                .map(o => `\`${o.column}\` ${o.type.toUpperCase()}`); // Adiciona ASC/DESC em maiúsculas
            if (orderClauses.length > 0) {
                query += ` ORDER BY ${orderClauses.join(', ')}`;
            }
        }

        // Adicionando LIMIT e OFFSET
        if (limit) {
            query += ` LIMIT ${parseInt(limit, 10)}`;
        }
        if (offset) {
            query += ` OFFSET ${parseInt(offset, 10)}`;
        }

        getLogger.debug(`Executando consulta dbmGet: ${query}`);

        // Executando a consulta com typeCast para preservar o formato original das datas
        const [results] = await sequelize.query(query, { 
            replacements,
            typeCast: getHandler.typeCast
        });

        return res.json({
            success: true,
            data: results,
            failure: false
        });
    } catch (error) {
        getLogger.error(`Erro ao executar dbmGet para entidade: ${entity}`, {
            entity,
            error: error.message,
            stack: error.stack
        });
        
        res.status(500).json({
            success: false,
            message: 'Erro ao executar a consulta no banco de dados.',
            failure: true,
            error: error.message
        });
    }
};

module.exports = getHandler;