'use strict';

module.exports = (sequelize, DataTypes) => {
  const JogoGame = sequelize.define('JogoGame', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    set_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'jogo_sets',
        key: 'id'
      }
    },
    numero_game: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    equipe_sacadora_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipo_equipe_jogo',
        key: 'id'
      }
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
    tableName: 'jogo_games',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_set',
        fields: ['set_id']
      },
      {
        name: 'idx_numero',
        fields: ['numero_game']
      },
      {
        name: 'idx_equipe_sacadora',
        fields: ['equipe_sacadora_id']
      },
      {
        name: 'idx_vencedor',
        fields: ['vencedor_id']
      },
      {
        name: 'unique_set_game',
        unique: true,
        fields: ['set_id', 'numero_game']
      }
    ]
  });

  JogoGame.associate = function(models) {
    JogoGame.belongsTo(models.JogoSet, {
      foreignKey: 'set_id',
      as: 'set',
      onDelete: 'CASCADE'
    });
    
    JogoGame.hasMany(models.JogoPonto, {
      foreignKey: 'game_id',
      as: 'pontos'
    });
    
    JogoGame.belongsTo(models.TipoEquipeJogo, {
      foreignKey: 'equipe_sacadora_id',
      as: 'equipeSacadora'
    });
    
    JogoGame.belongsTo(models.TipoEquipeJogo, {
      foreignKey: 'vencedor_id',
      as: 'vencedor'
    });
  };

  return JogoGame;
};
