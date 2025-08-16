/**
 * Configuração do banco de dados MySQL
 */
const mysql = require('mysql2/promise');

// Configurações do banco de dados
const dbConfig = {
  host: process.env.DB_HOST || 'localhost',
  user: process.env.DB_USER || 'root',
  password: process.env.DB_PASSWORD || '',
  database: process.env.DB_NAME || 'beach_tenis',
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0
};

// Cria um pool de conexões
const pool = mysql.createPool(dbConfig);

/**
 * Inicializa o banco de dados e cria as tabelas se não existirem
 */
const initializeDatabase = async () => {
  try {
    const connection = await pool.getConnection();
    console.log('Conexão com o banco de dados estabelecida com sucesso');
    
    // Importa os modelos
    const { 
      UserModel, 
      ArenaModel, 
      GameModel, 
      TrainingModel 
    } = require('../models');
    
    // Cria as tabelas se não existirem
    await connection.query(ArenaModel.createTable);
    console.log('Tabela de Arenas verificada/criada');
    
    await connection.query(UserModel.createTable);
    console.log('Tabela de Usuários verificada/criada');
    
    await connection.query(GameModel.createTable);
    console.log('Tabela de Jogos verificada/criada');
    
    await connection.query(GameModel.createPlayerRelationTable);
    console.log('Tabela de relação Jogos-Jogadores verificada/criada');
    
    await connection.query(TrainingModel.createTable);
    console.log('Tabela de Treinamentos verificada/criada');
    
    await connection.query(TrainingModel.createStudentRelationTable);
    console.log('Tabela de relação Treinamentos-Alunos verificada/criada');
    
    connection.release();
    return true;
  } catch (error) {
    console.error('Erro ao inicializar o banco de dados:', error);
    throw error;
  }
};

/**
 * Executa uma consulta SQL
 * @param {string} sql - Consulta SQL
 * @param {Array} params - Parâmetros para a consulta
 * @returns {Promise} - Resultado da consulta
 */
const query = async (sql, params) => {
  try {
    const [results] = await pool.execute(sql, params);
    return results;
  } catch (error) {
    console.error('Erro ao executar consulta:', error);
    throw error;
  }
};

module.exports = {
  pool,
  query,
  initializeDatabase
};
