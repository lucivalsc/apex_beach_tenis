'use strict';

module.exports = (sequelize, DataTypes) => {
  const LogSistema = sequelize.define('LogSistema', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    usuario_id: {
      type: DataTypes.INTEGER,
      references: {
        model: 'usuarios',
        key: 'id'
      }
    },
    tipo: {
      type: DataTypes.ENUM('INFO', 'AVISO', 'ERRO', 'CRITICO', 'SEGURANCA', 'AUDITORIA'),
      allowNull: false,
      defaultValue: 'INFO'
    },
    modulo: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    acao: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    descricao: {
      type: DataTypes.TEXT
    },
    dados: {
      type: DataTypes.JSON
    },
    ip: {
      type: DataTypes.STRING(45)
    },
    user_agent: {
      type: DataTypes.STRING(255)
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'logs_sistema',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: false,
    indexes: [
      {
        name: 'idx_usuario',
        fields: ['usuario_id']
      },
      {
        name: 'idx_tipo',
        fields: ['tipo']
      },
      {
        name: 'idx_modulo',
        fields: ['modulo']
      },
      {
        name: 'idx_data',
        fields: ['created_at']
      }
    ]
  });

  LogSistema.associate = function(models) {
    LogSistema.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario'
    });
  };

  return LogSistema;
};
