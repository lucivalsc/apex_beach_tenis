require('dotenv').config();
const { Sequelize } = require('sequelize');

/**
 * Configuração do Sequelize para conexão com o banco de dados
 * Configurações adicionadas:
 * - dialectOptions.dateStrings: true - Mantém as datas como strings sem conversão automática
 * - timezone: '+00:00' - Define o timezone como UTC para evitar conversões automáticas
 * - define.timestamps: false - Desativa a criação automática de campos createdAt e updatedAt
 * - define.freezeTableName: true - Usa o nome exato da tabela sem pluralização
 */
const sequelize = new Sequelize('lsctecnologias04', 'lsctecnologias04', 'West912Gist167', {
  host: 'mysql.lsctecnologias.kinghost.net',
  dialect: 'mysql',
  // Configurações para preservar as datas exatamente como enviadas
  dialectOptions: {
    dateStrings: true,
    typeCast: function (field, next) {
      // Para campos de data, mantém o valor original sem conversão
      if (field.type === 'DATETIME' || field.type === 'DATE' || field.type === 'TIMESTAMP') {
        return field.string();
      }
      return next();
    }
  },
  // Define o timezone como UTC para evitar conversões automáticas
  timezone: '+00:00',
  // Configurações globais para todos os modelos
  define: {
    // Desativa a criação automática de campos createdAt e updatedAt
    timestamps: false,
    // Usa o nome exato da tabela sem pluralização
    freezeTableName: true
  }
});

module.exports = sequelize;