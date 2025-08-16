// utils/cache.js
// Utilitário de cache simples usando node-cache

/**
 * Utilitário para cache de consultas
 * Implementa um sistema de cache em memória para reduzir a carga no banco de dados
 * e melhorar a performance das consultas frequentes.
 */

const NodeCache = require('node-cache');

// TTL padrão: 60 segundos (tempo de vida do cache)
const DEFAULT_TTL = 60;

// Inicializa o cache com TTL padrão e verificação a cada 120 segundos
const cache = new NodeCache({ stdTTL: DEFAULT_TTL, checkperiod: 120 });

/**
 * Gera uma chave única baseada nos parâmetros da consulta
 * @param {string} entity Nome da tabela
 * @param {object} params Parâmetros do body (filtros, ordem, etc)
 * @returns {string} Chave única para o cache
 */
function generateCacheKey(entity, params) {
    // Ordena as chaves para garantir consistência
    const sorted = Object.keys(params || {})
        .sort()
        .reduce((acc, key) => {
            acc[key] = params[key];
            return acc;
        }, {});
    return `${entity}:${JSON.stringify(sorted)}`;
}

/**
 * Obtém todas as chaves do cache que começam com o prefixo da entidade
 * @param {string} entity Nome da tabela
 * @returns {Array<string>} Lista de chaves do cache para a entidade
 */
function getEntityKeys(entity) {
    const keys = cache.keys();
    const prefix = `${entity}:`;
    return keys.filter(key => key.startsWith(prefix));
}

module.exports = {
    /**
     * Obtém um valor do cache
     * @param {string} entity Nome da tabela
     * @param {object} params Parâmetros da consulta
     * @returns {object|null} Valor armazenado no cache ou null se não existir
     */
    get: (entity, params) => {
        const key = generateCacheKey(entity, params);
        return cache.get(key);
    },
    
    /**
     * Armazena um valor no cache
     * @param {string} entity Nome da tabela
     * @param {object} params Parâmetros da consulta
     * @param {object} value Valor a ser armazenado
     * @param {number} ttl Tempo de vida em segundos (opcional)
     */
    set: (entity, params, value, ttl = DEFAULT_TTL) => {
        const key = generateCacheKey(entity, params);
        cache.set(key, value, ttl);
    },
    
    /**
     * Remove uma entrada específica do cache
     * @param {string} entity Nome da tabela
     * @param {object} params Parâmetros da consulta (opcional)
     */
    del: (entity, params) => {
        if (params) {
            // Remove uma entrada específica
            const key = generateCacheKey(entity, params);
            cache.del(key);
        } else {
            // Remove todas as entradas relacionadas à entidade
            const keys = getEntityKeys(entity);
            cache.del(keys);
        }
    },
    
    /**
     * Limpa todo o cache
     */
    flush: () => cache.flushAll(),
    
    /**
     * Obtém estatísticas do cache
     * @returns {object} Estatísticas do cache
     */
    stats: () => cache.getStats(),
    
    // Para testes ou acesso avançado
    _cache: cache
};
