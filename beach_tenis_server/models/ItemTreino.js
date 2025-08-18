'use strict';

module.exports = (sequelize, DataTypes) => {
  const ItemTreino = sequelize.define('ItemTreino', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    nome: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    descricao: {
      type: DataTypes.TEXT
    },
    categoria: {
      type: DataTypes.STRING(100)
    },
    dificuldade_id: {
      type: DataTypes.INTEGER,
      references: {
        model: 'dificuldade_item_treino',
        key: 'id'
      }
    },
    ativo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'itens_treino',
    timestamps: true,
    createdAt: 'created_at',
    updated_at: false,
    indexes: [
      {
        name: 'idx_categoria',
        fields: ['categoria']
      },
      {
        name: 'idx_dificuldade',
        fields: ['dificuldade_id']
      }
    ]
  });

  ItemTreino.associate = function(models) {
    ItemTreino.hasMany(models.TreinoItem, {
      foreignKey: 'item_treino_id',
      as: 'treinoItens'
    });
    
    ItemTreino.belongsTo(models.DificuldadeItemTreino, {
      foreignKey: 'dificuldade_id',
      as: 'dificuldade'
    });
  };

  return ItemTreino;
};
