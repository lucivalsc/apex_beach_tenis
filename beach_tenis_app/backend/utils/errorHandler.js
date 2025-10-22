/**
 * Utilitário para padronização de erros e respostas HTTP
 */

// Códigos de erro personalizados
const ErrorCodes = {
    // Erros de validação (400)
    INVALID_ENTITY: 'INVALID_ENTITY',
    INVALID_ACTION: 'INVALID_ACTION',
    INVALID_FILTER: 'INVALID_FILTER',
    INVALID_PARAMETER: 'INVALID_PARAMETER',
    INVALID_PARAMETER_VALUE: 'INVALID_PARAMETER_VALUE',
    MISSING_REQUIRED_FIELD: 'MISSING_REQUIRED_FIELD',
    MISSING_REQUIRED_PARAMETER: 'MISSING_REQUIRED_PARAMETER',
    
    // Erros de autenticação (401)
    INVALID_TOKEN: 'INVALID_TOKEN',
    TOKEN_EXPIRED: 'TOKEN_EXPIRED',
    UNAUTHORIZED: 'UNAUTHORIZED',
    
    // Erros de permissão (403)
    FORBIDDEN: 'FORBIDDEN',
    INSUFFICIENT_PERMISSIONS: 'INSUFFICIENT_PERMISSIONS',
    
    // Erros de recursos (404)
    ENTITY_NOT_FOUND: 'ENTITY_NOT_FOUND',
    RESOURCE_NOT_FOUND: 'RESOURCE_NOT_FOUND',
    
    // Erros de conflito (409)
    DUPLICATE_ENTRY: 'DUPLICATE_ENTRY',
    CONFLICT: 'CONFLICT',
    
    // Erros de banco de dados (500)
    DATABASE_ERROR: 'DATABASE_ERROR',
    DATABASE_CONNECTION_ERROR: 'DATABASE_CONNECTION_ERROR',
    DATABASE_AUTH_ERROR: 'DATABASE_AUTH_ERROR',
    DATABASE_NOT_FOUND: 'DATABASE_NOT_FOUND',
    DATABASE_QUERY_ERROR: 'DATABASE_QUERY_ERROR',
    QUERY_ERROR: 'QUERY_ERROR',
    INITIALIZATION_ERROR: 'INITIALIZATION_ERROR',
    
    // Erros de arquivo (500)
    FILE_READ_ERROR: 'FILE_READ_ERROR',
    FILE_WRITE_ERROR: 'FILE_WRITE_ERROR',
    FILE_COMPRESSION_ERROR: 'FILE_COMPRESSION_ERROR',
    
    // Erros internos (500)
    INTERNAL_SERVER_ERROR: 'INTERNAL_SERVER_ERROR',
    UNEXPECTED_ERROR: 'UNEXPECTED_ERROR'
};

// Mapeamento de códigos de erro para códigos HTTP
const HttpStatusMap = {
    // 400 - Bad Request
    INVALID_ENTITY: 400,
    INVALID_ACTION: 400,
    INVALID_FILTER: 400,
    INVALID_PARAMETER: 400,
    INVALID_PARAMETER_VALUE: 400,
    MISSING_REQUIRED_FIELD: 400,
    MISSING_REQUIRED_PARAMETER: 400,
    
    // 401 - Unauthorized
    INVALID_TOKEN: 401,
    TOKEN_EXPIRED: 401,
    UNAUTHORIZED: 401,
    
    // 403 - Forbidden
    FORBIDDEN: 403,
    INSUFFICIENT_PERMISSIONS: 403,
    
    // 404 - Not Found
    ENTITY_NOT_FOUND: 404,
    RESOURCE_NOT_FOUND: 404,
    
    // 409 - Conflict
    DUPLICATE_ENTRY: 409,
    CONFLICT: 409,
    
    // 500 - Internal Server Error
    DATABASE_ERROR: 500,
    DATABASE_CONNECTION_ERROR: 500,
    DATABASE_AUTH_ERROR: 500,
    DATABASE_NOT_FOUND: 500,
    DATABASE_QUERY_ERROR: 500,
    QUERY_ERROR: 500,
    INITIALIZATION_ERROR: 500,
    FILE_READ_ERROR: 500,
    FILE_WRITE_ERROR: 500,
    FILE_COMPRESSION_ERROR: 500,
    INTERNAL_SERVER_ERROR: 500,
    UNEXPECTED_ERROR: 500
};

// Mensagens de erro padrão em português
const ErrorMessages = {
    INVALID_ENTITY: 'Entidade inválida ou não especificada',
    INVALID_ACTION: 'Ação inválida ou não suportada',
    INVALID_FILTER: 'Filtro inválido ou mal formatado',
    INVALID_PARAMETER: 'Parâmetro inválido ou mal formatado',
    MISSING_REQUIRED_FIELD: 'Campo obrigatório não fornecido',
    
    INVALID_TOKEN: 'Token de autenticação inválido',
    TOKEN_EXPIRED: 'Token de autenticação expirado',
    UNAUTHORIZED: 'Não autorizado. Autenticação necessária',
    
    FORBIDDEN: 'Acesso negado',
    INSUFFICIENT_PERMISSIONS: 'Permissões insuficientes para esta operação',
    
    ENTITY_NOT_FOUND: 'Entidade não encontrada',
    RESOURCE_NOT_FOUND: 'Recurso não encontrado',
    
    DUPLICATE_ENTRY: 'Entrada duplicada. Este registro já existe',
    CONFLICT: 'Conflito ao processar a solicitação',
    
    DATABASE_CONNECTION_ERROR: 'Erro de conexão com o banco de dados',
    DATABASE_AUTH_ERROR: 'Falha na autenticação com o banco de dados',
    DATABASE_NOT_FOUND: 'Banco de dados não encontrado',
    DATABASE_QUERY_ERROR: 'Erro ao executar consulta no banco de dados',
    QUERY_ERROR: 'Erro na consulta',
    INITIALIZATION_ERROR: 'Erro durante a inicialização',
    
    DATABASE_ERROR: 'Erro no banco de dados',
    INTERNAL_SERVER_ERROR: 'Erro interno do servidor',
    UNEXPECTED_ERROR: 'Ocorreu um erro inesperado'
};

/**
 * Classe para representar erros da API
 */
class ApiError extends Error {
    constructor(code, message, details = null) {
        super(message || ErrorMessages[code] || 'Erro desconhecido');
        this.code = code;
        this.statusCode = HttpStatusMap[code] || 500;
        this.details = details;
        this.timestamp = new Date().toISOString();
    }
}

/**
 * Função para criar resposta de erro padronizada
 * @param {Error|ApiError} error - Objeto de erro
 * @param {Object} res - Objeto de resposta Express
 */
const sendErrorResponse = (error, res) => {
    // Se for um erro da API, usamos os dados já estruturados
    if (error instanceof ApiError) {
        console.error(`[${error.code}] ${error.message}`, error.details || '');
        
        return res.status(error.statusCode).json({
            success: false,
            error: {
                code: error.code,
                message: error.message,
                details: error.details,
                timestamp: error.timestamp
            },
            failure: true
        });
    }
    
    // Para erros do Sequelize (banco de dados)
    if (error.name === 'SequelizeError' || error.name === 'SequelizeDatabaseError') {
        console.error(`[DATABASE_ERROR] ${error.message}`, error);
        
        return res.status(500).json({
            success: false,
            error: {
                code: 'DATABASE_ERROR',
                message: 'Erro no banco de dados',
                details: process.env.NODE_ENV === 'production' ? null : error.message,
                timestamp: new Date().toISOString()
            },
            failure: true
        });
    }
    
    // Para erros de validação do Joi
    if (error.name === 'ValidationError') {
        console.error(`[VALIDATION_ERROR] ${error.message}`, error);
        
        return res.status(400).json({
            success: false,
            error: {
                code: 'VALIDATION_ERROR',
                message: 'Erro de validação',
                details: error.details ? error.details.map(d => d.message) : error.message,
                timestamp: new Date().toISOString()
            },
            failure: true
        });
    }
    
    // Para outros tipos de erro
    console.error(`[UNEXPECTED_ERROR] ${error.message}`, error);
    
    return res.status(500).json({
        success: false,
        error: {
            code: 'UNEXPECTED_ERROR',
            message: 'Ocorreu um erro inesperado',
            details: process.env.NODE_ENV === 'production' ? null : error.message,
            timestamp: new Date().toISOString()
        },
        failure: true
    });
};

module.exports = {
    ApiError,
    ErrorCodes,
    sendErrorResponse
};
