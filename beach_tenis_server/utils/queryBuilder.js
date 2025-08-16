// Função para mapear operadores para SQL
function mapOperatorToSQL(operator) {
    switch (operator) {
        case 'eq':
            return '=';
        case 'ne':
            return '<>';
        case 'gt':
            return '>';
        case 'gte':
            return '>=';
        case 'lt':
            return '<';
        case 'lte':
            return '<=';
        case 'cont':
            return 'LIKE';
        case 'contL':
            return 'ILIKE';
        case 'excl':
            return 'NOT LIKE';
        case 'exclL':
            return 'NOT ILIKE';
        case 'in':
            return 'IN';
        case 'notin':
            return 'NOT IN';
        case 'isnull':
            return 'IS NULL';
        case 'notnull':
            return 'IS NOT NULL';
        case 'starts':
            return 'LIKE';
        case 'ends':
            return 'LIKE';
        case 'between':
            return 'BETWEEN';
        default:
            throw new Error(`Unsupported operator: ${operator}`);
    }
}

const { sanitizeColumnName } = require('./sqlSanitizer');
const { ApiError, ErrorCodes } = require('./errorHandler');

// Função para gerar a cláusula WHERE e os substitutos
function buildWhereClause(filters) {
    if (!filters || filters.length === 0) {
        return { clause: '', replacements: {} };
    }

    const replacements = {};
    const clauseParts = [];

    for (const f of filters) {
        // Validação básica
        if (f.column === undefined || f.column === null || f.column === '') {
            throw new ApiError(ErrorCodes.INVALID_FILTER, 'Coluna do filtro não pode estar vazia');
        }
        
        if (f.operator === undefined || f.operator === null || f.operator === '') {
            throw new ApiError(ErrorCodes.INVALID_FILTER, 'Operador do filtro não pode estar vazio');
        }
        
        // Sanitizar o nome da coluna para prevenir injeção SQL
        let sanitizedColumn;
        try {
            sanitizedColumn = sanitizeColumnName(f.column);
        } catch (error) {
            throw new ApiError(ErrorCodes.INVALID_FILTER, `Nome de coluna inválido: ${f.column}`, {
                details: error.message,
                column: f.column
            });
        }
        
        const operator = mapOperatorToSQL(f.operator);
        let clausePart;
        let value = f.value;

        switch (f.operator) {
            case 'between':
                if (!Array.isArray(value) || value.length !== 2) {
                    throw new ApiError(ErrorCodes.INVALID_FILTER, `Operador 'between' requer um array com exatamente 2 valores para a coluna ${f.column}`);
                }
                clausePart = `${sanitizedColumn} ${operator} :${f.column}Start AND :${f.column}End`;
                replacements[`${f.column}Start`] = value[0];
                replacements[`${f.column}End`] = value[1];
                break;

            case 'in':
            case 'notin':
                if (!Array.isArray(value)) {
                    throw new ApiError(ErrorCodes.INVALID_FILTER, `Operador '${f.operator}' requer um array de valores para a coluna ${f.column}`);
                }
                clausePart = `${sanitizedColumn} ${operator} (:${f.column})`;
                replacements[f.column] = value;
                break;

            case 'isnull':
            case 'notnull':
                if (value !== undefined && value !== null) {
                    throw new ApiError(ErrorCodes.INVALID_FILTER, `Operador '${f.operator}' não aceita valores para a coluna ${f.column}`);
                }
                clausePart = `${sanitizedColumn} ${operator}`;
                break;

            case 'cont':   // LIKE com %value%
            case 'excl':    // NOT LIKE com %value%
                if (value === undefined || value === null || value === '') {
                    throw new ApiError(ErrorCodes.INVALID_FILTER, `Operador '${f.operator}' requer um valor não vazio para a coluna ${f.column}`);
                }
                clausePart = `${sanitizedColumn} ${operator} :${f.column}`;
                // Sanitizar valor para evitar ataques de LIKE injection
                value = value.replace(/[\\%_]/g, (match) => `\\${match}`);
                replacements[f.column] = `%${value}%`;
                break;

            case 'contL':  // ILIKE com %value%
            case 'exclL':   // NOT ILIKE com %value%
                if (value === undefined || value === null || value === '') {
                    throw new ApiError(ErrorCodes.INVALID_FILTER, `Operador '${f.operator}' requer um valor não vazio para a coluna ${f.column}`);
                }
                clausePart = `${sanitizedColumn} ${operator} :${f.column}`;
                // Sanitizar valor para evitar ataques de LIKE injection
                value = value.replace(/[\\%_]/g, (match) => `\\${match}`);
                replacements[f.column] = `%${value}%`;
                break;

            case 'starts': // LIKE com value%
                if (value === undefined || value === null || value === '') {
                    throw new ApiError(ErrorCodes.INVALID_FILTER, `Operador 'starts' requer um valor não vazio para a coluna ${f.column}`);
                }
                clausePart = `${sanitizedColumn} LIKE :${f.column}`;
                // Sanitizar valor para evitar ataques de LIKE injection
                value = value.replace(/[\\%_]/g, (match) => `\\${match}`);
                replacements[f.column] = `${value}%`;
                break;

            case 'ends':   // LIKE com %value
                if (value === undefined || value === null || value === '') {
                    throw new ApiError(ErrorCodes.INVALID_FILTER, `Operador 'ends' requer um valor não vazio para a coluna ${f.column}`);
                }
                clausePart = `${sanitizedColumn} LIKE :${f.column}`;
                // Sanitizar valor para evitar ataques de LIKE injection
                value = value.replace(/[\\%_]/g, (match) => `\\${match}`);
                replacements[f.column] = `%${value}`;
                break;

            default: // Operadores padrão (=, <>, >, <, etc)
                if (value === undefined || value === null) {
                    throw new ApiError(ErrorCodes.INVALID_FILTER, `Operador '${f.operator}' requer um valor para a coluna ${f.column}`);
                }
                clausePart = `${sanitizedColumn} ${operator} :${f.column}`;
                replacements[f.column] = value;
        }

        clauseParts.push(clausePart);
    }

    return {
        clause: clauseParts.join(' AND '),
        replacements
    };
}

module.exports = {
    mapOperatorToSQL,
    buildWhereClause
};