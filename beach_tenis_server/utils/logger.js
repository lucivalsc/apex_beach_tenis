// utils/logger.js
/**
 * Utilitário de logging usando winston
 * Implementa um sistema de logs detalhados para facilitar o diagnóstico de problemas
 */

const winston = require('winston');
const { createLogger, format, transports } = winston;
const DailyRotateFile = require('winston-daily-rotate-file');
const path = require('path');
const fs = require('fs');

// Diretório para armazenar os logs
const logDir = path.join(__dirname, '../logs');

// Criar o diretório de logs se não existir
if (!fs.existsSync(logDir)) {
    fs.mkdirSync(logDir, { recursive: true });
}

// Configuração de formato para os logs
const logFormat = format.combine(
    format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss' }),
    format.errors({ stack: true }),
    format.splat(),
    format.json()
);

// Configuração de formato para logs no console
const consoleFormat = format.combine(
    format.colorize(),
    format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss' }),
    format.printf(({ timestamp, level, message, ...meta }) => {
        return `${timestamp} ${level}: ${message} ${Object.keys(meta).length ? JSON.stringify(meta, null, 2) : ''}`;
    })
);

// Configuração para rotação de arquivos de log
const fileRotateTransport = new DailyRotateFile({
    filename: path.join(logDir, 'application-%DATE%.log'),
    datePattern: 'YYYY-MM-DD',
    maxSize: '20m',
    maxFiles: '14d',
    level: 'info'
});

// Configuração para logs de erro em arquivo separado
const errorFileRotateTransport = new DailyRotateFile({
    filename: path.join(logDir, 'error-%DATE%.log'),
    datePattern: 'YYYY-MM-DD',
    maxSize: '20m',
    maxFiles: '14d',
    level: 'error'
});

// Criação do logger
const logger = createLogger({
    level: process.env.LOG_LEVEL || 'info',
    format: logFormat,
    defaultMeta: { service: 'ontarget-api' },
    transports: [
        // Logs de informação e acima vão para o arquivo de rotação diária
        fileRotateTransport,
        // Logs de erro vão para um arquivo separado
        errorFileRotateTransport
    ]
});

// Se não estiver em produção, também loga no console
if (process.env.NODE_ENV !== 'production') {
    logger.add(new transports.Console({
        format: consoleFormat,
        level: 'debug'
    }));
}

// Função para criar um logger com contexto (ex: módulo específico)
logger.getSubLogger = function(context) {
    const subLogger = this.child({ context });
    return subLogger;
};

// Função para registrar requisições HTTP
logger.logRequest = function(req, res, next) {
    const start = Date.now();
    const { ip, method, originalUrl } = req;
    
    // Registrar o início da requisição
    this.info(`Requisição recebida: ${method} ${originalUrl}`, {
        ip,
        method,
        url: originalUrl,
        body: req.body,
        params: req.params,
        query: req.query
    });

    // Interceptar o fim da requisição para registrar a resposta
    const originalEnd = res.end;
    res.end = function(chunk, encoding) {
        const responseTime = Date.now() - start;
        const { statusCode } = res;

        // Registrar o fim da requisição
        if (statusCode >= 400) {
            logger.warn(`Resposta: ${statusCode} ${method} ${originalUrl} - ${responseTime}ms`, {
                statusCode,
                responseTime,
                method,
                url: originalUrl
            });
        } else {
            logger.info(`Resposta: ${statusCode} ${method} ${originalUrl} - ${responseTime}ms`, {
                statusCode,
                responseTime,
                method,
                url: originalUrl
            });
        }

        originalEnd.call(this, chunk, encoding);
    };

    next();
};

// Função para registrar erros
logger.logError = function(err, req, res, next) {
    const { ip, method, originalUrl } = req;
    
    this.error(`Erro: ${err.message}`, {
        error: err.stack,
        ip,
        method,
        url: originalUrl,
        body: req.body,
        params: req.params,
        query: req.query
    });

    next(err);
};

module.exports = logger;
