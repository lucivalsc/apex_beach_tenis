'use strict';

module.exports = (sequelize, DataTypes) => {
  const ConfiguracaoSistema = sequelize.define('ConfiguracaoSistema', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    chave: {
      type: DataTypes.STRING(100),
      allowNull: false,
      unique: true
    },
    valor: {
      type: DataTypes.TEXT
    },
    descricao: {
      type: DataTypes.STRING(255)
    },
    tipo: {
      type: DataTypes.ENUM('STRING', 'INTEGER', 'BOOLEAN', 'JSON'),
      defaultValue: 'STRING'
    },
    updated_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'configuracoes_sistema',
    timestamps: true,
    createdAt: false,
    updatedAt: 'updated_at'
  });

  return ConfiguracaoSistema;
};
