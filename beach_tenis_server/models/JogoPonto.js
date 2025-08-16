'use strict';

module.exports = (sequelize, DataTypes) => {
  const JogoPonto = sequelize.define('JogoPonto', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    game_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'jogo_games',
        key: 'id'
      }
    },
    numero_ponto: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    equipe_vencedora: {
      type: DataTypes.ENUM('A', 'B'),
      allowNull: false
    },
    atleta_id: {
      type: DataTypes.INTEGER,
      references: {
        model: 'atletas',
        key: 'id'
      }
    },
    tipo_ponto: {
      type: DataTypes.ENUM('WINNER', 'ERRO_ADVERSARIO', 'ACE', 'DUPLA_FALTA'),
      allowNull: false
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'jogo_pontos',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: false,
    indexes: [
      {
        name: 'idx_game',
        fields: ['game_id']
      },
      {
        name: 'idx_atleta',
        fields: ['atleta_id']
      },
      {
        name: 'idx_tipo',
        fields: ['tipo_ponto']
      },
      {
        name: 'unique_game_ponto',
        unique: true,
        fields: ['game_id', 'numero_ponto']
      }
    ]
  });

  JogoPonto.associate = function(models) {
    JogoPonto.belongsTo(models.JogoGame, {
      foreignKey: 'game_id',
      as: 'game',
      onDelete: 'CASCADE'
    });
    
    JogoPonto.belongsTo(models.Atleta, {
      foreignKey: 'atleta_id',
      as: 'atleta'
    });
  };

  return JogoPonto;
};
