'use strict';

module.exports = (sequelize, DataTypes) => {
  const Notificacao = sequelize.define('Notificacao', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    usuario_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'usuarios',
        key: 'id'
      }
    },
    tipo_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipo_notificacao',
        key: 'id'
      }
    },
    titulo: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    mensagem: {
      type: DataTypes.TEXT,
      allowNull: false
    },
    dados_adicionais: {
      type: DataTypes.JSON
    },
    lida: {
      type: DataTypes.BOOLEAN,
      defaultValue: false
    },
    data_leitura: {
      type: DataTypes.DATE
    },
    createdAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'notificacoes',
    timestamps: true,
    createdAt: 'createdAt',
    updatedAt: false,
    indexes: [
      {
        name: 'idx_usuario',
        fields: ['usuario_id']
      },
      {
        name: 'idx_tipo',
        fields: ['tipo_id']
      },
      {
        name: 'idx_lida',
        fields: ['lida']
      },
      {
        name: 'idx_data',
        fields: ['createdAt']
      }
    ]
  });

  Notificacao.associate = function(models) {
    Notificacao.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario',
      onDelete: 'CASCADE'
    });
    
    Notificacao.belongsTo(models.TipoNotificacao, {
      foreignKey: 'tipo_id',
      as: 'tipo'
    });
  };

  return Notificacao;
};
