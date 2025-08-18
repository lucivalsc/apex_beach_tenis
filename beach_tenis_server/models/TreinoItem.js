'use strict';

module.exports = (sequelize, DataTypes) => {
  const TreinoItem = sequelize.define('TreinoItem', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    treino_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'treinos',
        key: 'id'
      }
    },
    item_treino_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'itens_treino',
        key: 'id'
      }
    },
    ordem: {
      type: DataTypes.INTEGER,
      defaultValue: 0
    },
    repeticoes: {
      type: DataTypes.INTEGER
    },
    duracao_minutos: {
      type: DataTypes.INTEGER
    },
    observacoes: {
      type: DataTypes.TEXT
    },
    concluido: {
      type: DataTypes.BOOLEAN,
      defaultValue: false
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'treino_itens',
    timestamps: true,
    createdAt: 'created_at',
    updated_at: false,
    indexes: [
      {
        name: 'idx_treino',
        fields: ['treino_id']
      },
      {
        name: 'idx_item',
        fields: ['item_treino_id']
      },
      {
        name: 'idx_ordem',
        fields: ['ordem']
      }
    ]
  });

  TreinoItem.associate = function(models) {
    TreinoItem.belongsTo(models.Treino, {
      foreignKey: 'treino_id',
      as: 'treino',
      onDelete: 'CASCADE'
    });
    
    TreinoItem.belongsTo(models.ItemTreino, {
      foreignKey: 'item_treino_id',
      as: 'itemTreino'
    });
  };

  return TreinoItem;
};
