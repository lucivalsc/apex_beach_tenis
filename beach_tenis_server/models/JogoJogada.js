'use strict';

module.exports = (sequelize, DataTypes) => {
  const JogoJogada = sequelize.define('JogoJogada', {
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
    atleta_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'atletas',
        key: 'id'
      }
    },
    golpe_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'golpes',
        key: 'id'
      }
    },
    set_numero: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    game_numero: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    ponto_numero: {
      type: DataTypes.INTEGER,
      allowNull: false
    },
    posicao_quadra: {
      type: DataTypes.JSON
    },
    resultado: {
      type: DataTypes.ENUM('SUCESSO', 'ERRO', 'NEUTRO'),
      allowNull: false
    },
    observacoes: {
      type: DataTypes.TEXT
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'jogo_jogadas',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: false,
    indexes: [
      {
        name: 'idx_jogo',
        fields: ['jogo_id']
      },
      {
        name: 'idx_atleta',
        fields: ['atleta_id']
      },
      {
        name: 'idx_golpe',
        fields: ['golpe_id']
      },
      {
        name: 'idx_set_game_ponto',
        fields: ['set_numero', 'game_numero', 'ponto_numero']
      }
    ]
  });

  JogoJogada.associate = function(models) {
    JogoJogada.belongsTo(models.Jogo, {
      foreignKey: 'jogo_id',
      as: 'jogo',
      onDelete: 'CASCADE'
    });
    
    JogoJogada.belongsTo(models.Atleta, {
      foreignKey: 'atleta_id',
      as: 'atleta'
    });
    
    JogoJogada.belongsTo(models.Golpe, {
      foreignKey: 'golpe_id',
      as: 'golpe'
    });
  };

  return JogoJogada;
};
