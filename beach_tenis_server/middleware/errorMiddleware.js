/**
 * Middleware para tratamento centralizado de erros e logging
 */
const { sendErrorResponse } = require('../utils/errorHandler');
const logger = require('../utils/logger');

/**
 * Middleware para registrar requisições HTTP
 */
const requestLogger = (req, res, next) => {
    logger.logRequest(req, res, next);
};

/**
 * Middleware para capturar erros não tratados
 */
const errorHandler = (err, req, res, next) => {
    // Registrar o erro no logger
    logger.logError(err, req, res, () => {
        // Usar o utilitário de tratamento de erros para enviar a resposta
        sendErrorResponse(err, res);
    });
};

/**
 * Middleware para capturar rotas não encontradas (404)
 */
const notFoundHandler = (req, res, next) => {
    // Registrar no logger a tentativa de acesso a uma rota inexistente
    logger.warn(`Rota não encontrada: ${req.method} ${req.originalUrl}`, {
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
