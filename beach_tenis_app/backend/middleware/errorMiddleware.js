/**
 * Middleware para tratamento centralizado de erros e logging
 */
const { sendErrorResponse } = require('../utils/errorHandler');

/**
 * Middleware para registrar requisições HTTP
 */
const requestLogger = (req, res, next) => {
    console.log(`Requisição: ${req.method} ${req.originalUrl}`);
    next();
};

/**
 * Middleware para capturar erros não tratados
 */
const errorHandler = (err, req, res, next) => {
    // Registrar o erro no logger
    console.log(`Erro: ${err.message}`);
    next(err);
};

/**
 * Middleware para capturar rotas não encontradas (404)
 */
const notFoundHandler = (req, res, next) => {
    // Registrar no logger a tentativa de acesso a uma rota inexistente
    console.log(`Rota não encontrada: ${req.method} ${req.originalUrl}`, {
        method: req.method,
        url: req.originalUrl,
        ip: req.ip
    });

    res.status(404).json({
        success: false,
        error: {
            code: 'RESOURCE_NOT_FOUND',
            message: 'Recurso não encontrado',
            details: `A rota ${req.method} ${req.originalUrl} não existe`,
            timestamp: new Date().toISOString()
        },
        failure: true
    });
};

module.exports = {
    requestLogger,
    errorHandler,
    notFoundHandler
};
