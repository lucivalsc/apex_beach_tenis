const { Sequelize } = require('sequelize');
const sequelize = require('../config/database');
const { buildWhereClause } = require('../utils/queryBuilder');
const { ApiError, ErrorCodes, sendErrorResponse } = require('../utils/errorHandler');

// Importar handlers específicos para cada verbo HTTP
const getHandler = require('./handlers/getHandler');
const postHandler = require('./handlers/postHandler');
const putHandler = require('./handlers/putHandler');
const deleteHandler = require('./handlers/deleteHandler');

// Handler para verbo GET
const handleGet = async (req, res) => {
    try {
        return await getHandler(req, res, sequelize, buildWhereClause);
    } catch (error) {
        return sendErrorResponse(error, res);
    }
};

// Handler para verbo POST
const handlePost = async (req, res) => {
    try {
        return await postHandler(req, res, sequelize, Sequelize);
    } catch (error) {
        return sendErrorResponse(error, res);
    }
};

// Handler para verbos PUT e PATCH
const handlePut = async (req, res) => {
    try {
        return await putHandler(req, res, sequelize, Sequelize, buildWhereClause);
    } catch (error) {
        return sendErrorResponse(error, res);
    }
};

// Handler para verbo DELETE
const handleDelete = async (req, res) => {
    try {
        return await deleteHandler(req, res, sequelize, Sequelize, buildWhereClause);
    } catch (error) {
        return sendErrorResponse(error, res);
    }
};

// Handler para operação dbmGet
const handleDbmGet = async (req, res) => {
    try {
        return await getHandler.dbmGet(req, res, sequelize);
    } catch (error) {
        return sendErrorResponse(error, res);
    }
};

module.exports = {
    handleGet,
    handlePost,
    handlePut,
    handleDelete,
    handleDbmGet
};