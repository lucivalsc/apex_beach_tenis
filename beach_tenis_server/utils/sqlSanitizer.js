/**
 * Utilitário para sanitização e validação de nomes de tabelas e colunas SQL
 * para prevenir injeção SQL
 */

const { ApiError, ErrorCodes } = require('./errorHandler');

// Expressão regular para validar nomes de tabelas e colunas
// Permite apenas letras, números, sublinhados e pontos (para tabelas com esquema)
const VALID_IDENTIFIER_REGEX = /^[a-zA-Z0-9_\.]+$/;

// Lista de palavras reservadas do SQL que não devem ser usadas como nomes de tabelas ou colunas
const SQL_RESERVED_WORDS = [
    'ADD', 'ALL', 'ALTER', 'AND', 'ANY', 'AS', 'ASC', 'BACKUP', 'BETWEEN', 'BY', 
    'CASE', 'CHECK', 'COLUMN', 'CONSTRAINT', 'CREATE', 'DATABASE', 'DEFAULT', 'DELETE', 
    'DESC', 'DISTINCT', 'DROP', 'EXEC', 'EXISTS', 'FOREIGN', 'FROM', 'FULL', 'GROUP', 
    'HAVING', 'IN', 'INDEX', 'INNER', 'INSERT', 'INTO', 'IS', 'JOIN', 'KEY', 'LEFT', 
    'LIKE', 'LIMIT', 'NOT', 'NULL', 'OR', 'ORDER', 'OUTER', 'PRIMARY', 'PROCEDURE', 
    'RIGHT', 'ROWNUM', 'SELECT', 'SET', 'TABLE', 'TOP', 'TRUNCATE', 'UNION', 'UNIQUE', 
    'UPDATE', 'VALUES', 'VIEW', 'WHERE'
];

/**
 * Verifica se um identificador SQL (nome de tabela ou coluna) é válido
 * @param {string} identifier - Nome da tabela ou coluna
 * @param {string} type - Tipo de identificador ('table' ou 'column')
 * @returns {boolean} - Verdadeiro se o identificador for válido
 * @throws {ApiError} - Erro se o identificador for inválido
 */
function validateSqlIdentifier(identifier, type = 'identifier') {
    if (!identifier) {
        throw new ApiError(
            ErrorCodes.INVALID_PARAMETER, 
            `Nome de ${type === 'table' ? 'tabela' : 'coluna'} não pode ser vazio`
        );
    }

    // Verificar se o identificador contém apenas caracteres permitidos
    if (!VALID_IDENTIFIER_REGEX.test(identifier)) {
        throw new ApiError(
            ErrorCodes.INVALID_PARAMETER, 
            `Nome de ${type === 'table' ? 'tabela' : 'coluna'} contém caracteres inválidos: ${identifier}`,
            { identifier, type }
        );
    }

    // Verificar se o identificador é uma palavra reservada SQL
    if (SQL_RESERVED_WORDS.includes(identifier.toUpperCase())) {
        throw new ApiError(
            ErrorCodes.INVALID_PARAMETER, 
            `Nome de ${type === 'table' ? 'tabela' : 'coluna'} não pode ser uma palavra reservada SQL: ${identifier}`,
            { identifier, type }
        );
    }

    return true;
}

/**
 * Sanitiza um nome de tabela para uso seguro em consultas SQL
 * @param {string} tableName - Nome da tabela a ser sanitizado
 * @returns {string} - Nome da tabela sanitizado e entre crases
 * @throws {ApiError} - Erro se o nome da tabela for inválido
 */
function sanitizeTableName(tableName) {
    validateSqlIdentifier(tableName, 'table');
    return `\`${tableName}\``;
}

/**
 * Sanitiza um nome de coluna para uso seguro em consultas SQL
 * @param {string} columnName - Nome da coluna a ser sanitizado
 * @returns {string} - Nome da coluna sanitizado e entre crases
 * @throws {ApiError} - Erro se o nome da coluna for inválido
 */
function sanitizeColumnName(columnName) {
    validateSqlIdentifier(columnName, 'column');
    return `\`${columnName}\``;
}

/**
 * Sanitiza uma lista de nomes de colunas para uso seguro em consultas SQL
 * @param {Array<string>} columnNames - Lista de nomes de colunas
 * @returns {Array<string>} - Lista de nomes de colunas sanitizados
 * @throws {ApiError} - Erro se algum nome de coluna for inválido
 */
function sanitizeColumnNames(columnNames) {
    if (!Array.isArray(columnNames)) {
        throw new ApiError(
            ErrorCodes.INVALID_PARAMETER, 
            'Lista de colunas deve ser um array',
            { columnNames }
        );
    }
    
    return columnNames.map(col => sanitizeColumnName(col));
}

/**
 * Sanitiza uma cláusula ORDER BY para uso seguro em consultas SQL
 * @param {Array<string>} orderByColumns - Lista de colunas para ordenação (ex: ["nome ASC", "idade DESC"])
 * @returns {string} - Cláusula ORDER BY sanitizada
 * @throws {ApiError} - Erro se alguma cláusula de ordenação for inválida
 */
function sanitizeOrderBy(orderByColumns) {
    if (!Array.isArray(orderByColumns)) {
        throw new ApiError(
            ErrorCodes.INVALID_PARAMETER, 
            'Lista de ordenação deve ser um array',
            { orderByColumns }
        );
    }
    
    return orderByColumns.map(orderBy => {
        const parts = orderBy.trim().split(/\s+/);
        const columnName = parts[0];
        const direction = parts[1] ? parts[1].toUpperCase() : '';
        
        validateSqlIdentifier(columnName, 'column');
        
        if (direction && direction !== 'ASC' && direction !== 'DESC') {
            throw new ApiError(
                ErrorCodes.INVALID_PARAMETER, 
                `Direção de ordenação inválida: ${direction}. Use ASC ou DESC.`,
                { orderBy }
            );
        }
        
        return `\`${columnName}\` ${direction}`.trim();
    }).join(', ');
}

/**
 * Sanitiza uma definição de join para uso seguro em consultas SQL
 * @param {Object} join - Definição do join (table, alias, type, on)
 * @param {string} mainTable - Nome da tabela principal da consulta
 * @param {string} mainTableAlias - Alias da tabela principal (opcional)
 * @returns {string} - Cláusula JOIN sanitizada
 * @throws {ApiError} - Erro se a definição do join for inválida
 */
function sanitizeJoin(join, mainTable, mainTableAlias) {
    if (!join || typeof join !== 'object') {
        throw new ApiError(
            ErrorCodes.INVALID_PARAMETER, 
            'Definição de join inválida',
            { join }
        );
    }

    const { table, alias, type, on } = join;
    
    // Validar e sanitizar a tabela do join
    const sanitizedTable = sanitizeTableName(table);
    
    // Validar o tipo de join
    const validTypes = ['INNER', 'LEFT', 'RIGHT', 'FULL'];
    const joinType = (type || 'INNER').toUpperCase();
    
    if (!validTypes.includes(joinType)) {
        throw new ApiError(
            ErrorCodes.INVALID_PARAMETER, 
            `Tipo de join inválido: ${joinType}. Use INNER, LEFT, RIGHT ou FULL.`,
            { join }
        );
    }
    
    // Validar condições do join
    if (!on || !on.sourceColumn || !on.targetColumn) {
        throw new ApiError(
            ErrorCodes.INVALID_PARAMETER, 
            'Condições de join inválidas. Especifique sourceColumn e targetColumn.',
            { join }
        );
    }
    
    // Extrair tabela de origem e coluna (se fornecido no formato tabela.coluna)
    let sourceTable = '';
    let sourceCol = on.sourceColumn;
    if (on.sourceColumn.includes('.')) {
        const parts = on.sourceColumn.split('.');
        sourceTable = parts[0];
        sourceCol = parts[1];
    }
    
    // Extrair tabela de destino e coluna (se fornecido no formato tabela.coluna)
    let targetTable = '';
    let targetCol = on.targetColumn;
    if (on.targetColumn.includes('.')) {
        const parts = on.targetColumn.split('.');
        targetTable = parts[0];
        targetCol = parts[1];
    }
    
    // Se não foi especificada a tabela de origem, usar a tabela principal ou seu alias
    if (!sourceTable) {
        // Usar o alias da tabela principal se existir, caso contrário usar o nome da tabela principal
        sourceTable = mainTableAlias || mainTable;
    }
    
    // Se não foi especificada a tabela de destino, usar o nome da tabela (não o alias)
    // Não podemos usar o alias na cláusula ON pois ele ainda não foi definido nesse ponto da query
    if (!targetTable) {
        targetTable = table;
    }
    
    // Sanitizar colunas do join com suas tabelas
    const sanitizedSourceCol = sanitizeColumnName(sourceCol);
    const sanitizedTargetCol = sanitizeColumnName(targetCol);
    
    // Construir a cláusula JOIN com colunas qualificadas
    // Importante: Na cláusula ON, não podemos usar o alias da tabela que estamos unindo (ele ainda não foi definido)
    // Portanto, para a tabela de destino, sempre usamos o nome da tabela, não o alias
    return `${joinType} JOIN ${sanitizedTable}${alias ? ` AS \`${alias}\`` : ''} ON \`${sourceTable}\`.${sanitizedSourceCol} = \`${targetTable}\`.${sanitizedTargetCol}`;
}

/**
 * Sanitiza uma lista de definições de joins para uso seguro em consultas SQL
 * @param {Array<Object>} joins - Lista de definições de joins
 * @param {string} mainTable - Nome da tabela principal da consulta
 * @param {string} mainTableAlias - Alias da tabela principal (opcional)
 * @returns {string} - Cláusulas JOIN sanitizadas concatenadas
 * @throws {ApiError} - Erro se alguma definição de join for inválida
 */
function sanitizeJoins(joins, mainTable, mainTableAlias) {
    if (!Array.isArray(joins)) {
        throw new ApiError(
            ErrorCodes.INVALID_PARAMETER, 
            'Lista de joins deve ser um array',
            { joins }
        );
    }
    
    if (joins.length === 0) {
        return '';
    }
    
    return joins.map(join => sanitizeJoin(join, mainTable, mainTableAlias)).join(' ');
}

module.exports = {
    validateSqlIdentifier,
    sanitizeTableName,
    sanitizeColumnName,
    sanitizeColumnNames,
    sanitizeOrderBy,
    sanitizeJoin,
    sanitizeJoins
};
