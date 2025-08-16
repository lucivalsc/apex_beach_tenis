/**
 * Handler para operações DELETE
 * @param {Object} req - Objeto de requisição
 * @param {Object} res - Objeto de resposta
 * @param {Object} sequelize - Instância do Sequelize
 * @param {Object} Sequelize - Classe Sequelize para tipos de queries
 * @param {Function} buildWhereClause - Função para construir cláusulas WHERE
 */
const cache = require('../../utils/cache');
const deleteHandler = async (req, res, sequelize, Sequelize, buildWhereClause) => {
    const { entity, filter } = req.body;

    if (!filter || filter.length === 0) {
        return res.status(400).json({ success: false, message: 'Filter is required for deletions.', failure: true });
    }

    const tableName = `\`${entity}\``;
    let query = '';
    let replacements = {};

    const { clause: whereClause, replacements: whereReplacements } = buildWhereClause(filter);
    if (whereClause) {
        query = ` WHERE ${whereClause}`;
        replacements = { ...replacements, ...whereReplacements };
    }

    query = `DELETE FROM ${tableName}${query}`;

    // Executando a query
    await sequelize.query(query, {
        type: Sequelize.QueryTypes.DELETE,
        replacements
    });

    // Invalidar o cache para esta entidade após exclusão
    cache.del(entity);

    // Retornando a resposta de sucesso
    return res.status(200).json({
        success: true,
        message: 'Dados excluídos com sucesso.',
        failure: false
    });
};

module.exports = deleteHandler;