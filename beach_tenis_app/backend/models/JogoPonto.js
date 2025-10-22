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
    equipe_vencedora_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipo_equipe_jogo',
        key: 'id'
      }
    },
    atleta_id: {
      type: DataTypes.INTEGER,
      references: {
        model: 'atletas',
        key: 'id'
      }
    },
    tipo_ponto_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipo_ponto',
        key: 'id'
      }
    },
    createdAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'jogo_pontos',
    timestamps: true,
    createdAt: 'createdAt',
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
        name: 'idx_tipo_ponto',
        fields: ['tipo_ponto_id']
      },
      {
        name: 'idx_equipe_vencedora',
        fields: ['equipe_vencedora_id']
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
    
    JogoPonto.belongsTo(models.TipoEquipeJogo, {
      foreignKey: 'equipe_vencedora_id',
      as: 'equipeVencedora'
    });
    
    JogoPonto.belongsTo(models.TipoPonto, {
      foreignKey: 'tipo_ponto_id',
      as: 'tipoPonto'
    });
  };

  return JogoPonto;
};
