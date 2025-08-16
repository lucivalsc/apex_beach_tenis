'use strict';

module.exports = (sequelize, DataTypes) => {
  const AvaliacaoItem = sequelize.define('AvaliacaoItem', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    avaliacao_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'avaliacoes',
        key: 'id'
      }
    },
    categoria: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    item: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    nota: {
      type: DataTypes.INTEGER,
      validate: {
        min: 0,
        max: 10
      }
    },
    observacoes: {
      type: DataTypes.TEXT
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'avaliacao_itens',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: false,
    indexes: [
      {
        name: 'idx_avaliacao',
        fields: ['avaliacao_id']
      },
      {
        name: 'idx_categoria',
        fields: ['categoria']
      }
    ]
  });

  AvaliacaoItem.associate = function(models) {
    AvaliacaoItem.belongsTo(models.Avaliacao, {
      foreignKey: 'avaliacao_id',
      as: 'avaliacao',
      onDelete: 'CASCADE'
    });
  };

  return AvaliacaoItem;
};
