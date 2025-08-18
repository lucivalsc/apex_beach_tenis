'use strict';

module.exports = (sequelize, DataTypes) => {
  const JogoSet = sequelize.define('JogoSet', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    jogo_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'jogos',
        key: 'id'
      }
    },
    numero_set: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    pontos_equipe_a: {
      type: DataTypes.INTEGER,
      defaultValue: 0
    },
    pontos_equipe_b: {
      type: DataTypes.INTEGER,
      defaultValue: 0
    },
    vencedor_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'tipo_equipe_jogo',
        key: 'id'
      }
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    updated_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'jogo_sets',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_jogo',
        fields: ['jogo_id']
      },
      {
        name: 'idx_numero',
        fields: ['numero_set']
      },
      {
        name: 'idx_vencedor',
        fields: ['vencedor_id']
      },
      {
        name: 'unique_jogo_set',
        unique: true,
        fields: ['jogo_id', 'numero_set']
      }
    ]
  });

  JogoSet.associate = function(models) {
    JogoSet.belongsTo(models.Jogo, {
      foreignKey: 'jogo_id',
      as: 'jogo',
      onDelete: 'CASCADE'
    });
    
    JogoSet.hasMany(models.JogoGame, {
      foreignKey: 'set_id',
      as: 'games'
    });
    
    JogoSet.belongsTo(models.TipoEquipeJogo, {
      foreignKey: 'vencedor_id',
      as: 'vencedor'
    });
  };

  return JogoSet;
};
