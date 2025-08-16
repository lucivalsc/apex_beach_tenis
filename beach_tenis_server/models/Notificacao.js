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
    tipo: {
      type: DataTypes.ENUM('SISTEMA', 'TREINO', 'AVALIACAO', 'JOGO', 'PAGAMENTO', 'CONEXAO', 'OUTRO'),
      allowNull: false
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
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'notificacoes',
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
        name: 'idx_lida',
        fields: ['lida']
      },
      {
        name: 'idx_data',
        fields: ['created_at']
      }
    ]
  });

  Notificacao.associate = function(models) {
    Notificacao.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario',
      onDelete: 'CASCADE'
    });
  };

  return Notificacao;
};
