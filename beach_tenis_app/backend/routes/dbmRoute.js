
const express = require('express');
const router = express.Router();
const authenticateToken = require('../middleware/authMiddleware').authenticateToken;
const dbmController = require('../controllers/dbmController');
const { validateDbmRequest } = require('../middleware/validation/dbmValidation');
const { Op } = require('sequelize');
const sequelize = require('../config/database');

/**
 * @swagger
 * tags:
 *   name: DBM
 *   description: API para gerenciamento de dados (Database Management)
 */

/**
 * @swagger
 * /api/dbm:
 *   post:
 *     summary: Gerenciamento de dados (GET, POST, PUT, DELETE)
 *     description: Endpoint unificado para consulta e manipulação de dados
 *     tags: [DBM]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - entity
 *               - action
 *             properties:
 *               entity:
 *                 type: string
 *                 description: Nome da tabela a ser consultada
 *               action:
 *                 type: string
 *                 enum: [get, post, put, patch, delete]
 *                 description: Ação a ser realizada
 *     responses:
 *       200:
 *         description: Operação realizada com sucesso
 *       400:
 *         description: Parâmetros inválidos
 *       401:
 *         description: Não autorizado
 *       500:
 *         description: Erro interno do servidor
 */
// Rota principal dbm
router.post('/dbm', authenticateToken, validateDbmRequest, async (req, res) => {
    const {
        entity, alias, action, data, filter, groupBy, orderBy, offset, limit
    } = req.body;

    if (!entity) {
        return res.status(400).json({ success: false, message: 'Entidade é obrigatória.', failure: true });
    }

    try {
        switch (action) {
            case 'get':
                return await dbmController.handleGet(req, res);
            case 'post':
                return await dbmController.handlePost(req, res);
            case 'put':
            case 'patch':
                return await dbmController.handlePut(req, res);
            case 'delete':
                return await dbmController.handleDelete(req, res);
            default:
                return res.status(400).json({ success: false, message: 'Ação inválida.', failure: true });
        }
    } catch (error) {
        console.error(error);
        return res.status(500).json({ success: false, message: error.message, failure: true });
    }
});

/**
 * @swagger
 * /api/dbmGet:
 *   post:
 *     summary: Consulta avançada de dados
 *     description: Endpoint para consultas complexas com joins, filtros e ordenação
 *     tags: [DBM]
 *     security:
 *       - bearerAuth: []
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             required:
 *               - entity
 *             properties:
 *               entity:
 *                 type: string
 *                 description: Nome da tabela a ser consultada
 *               alias:
 *                 type: string
 *                 description: Alias para a tabela principal
 *               select:
 *                 type: array
 *                 description: Colunas a serem selecionadas
 *               leftJoin:
 *                 type: array
 *                 description: Tabelas a serem unidas com LEFT JOIN
 *               innerJoin:
 *                 type: array
 *                 description: Tabelas a serem unidas com INNER JOIN
 *               rightJoin:
 *                 type: array
 *                 description: Tabelas a serem unidas com RIGHT JOIN
 *               outerJoin:
 *                 type: array
 *                 description: Tabelas a serem unidas com OUTER JOIN
 *               filter:
 *                 type: array
 *                 description: Filtros a serem aplicados
 *               groupBy:
 *                 type: array
 *                 description: Colunas para agrupamento
 *               orderBy:
 *                 type: array
 *                 description: Colunas para ordenação
 *     responses:
 *       200:
 *         description: Consulta realizada com sucesso
 *       400:
 *         description: Parâmetros inválidos
 *       401:
 *         description: Não autorizado
 *       500:
 *         description: Erro interno do servidor
 */
router.post('/dbmGet', authenticateToken, async (req, res) => {
    return await dbmController.handleDbmGet(req, res);
});

module.exports = router;
