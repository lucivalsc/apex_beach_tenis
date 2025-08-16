'use strict';

module.exports = (sequelize, DataTypes) => {
  const JogoParticipante = sequelize.define('JogoParticipante', {
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
    equipe: {
      type: DataTypes.ENUM('A', 'B'),
      allowNull: false
    },
    posicao: {
      type: DataTypes.ENUM('DIREITA', 'ESQUERDA'),
      allowNull: true
    },
    confirmado: {
      type: DataTypes.BOOLEAN,
      defaultValue: false
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'jogo_participantes',
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
        name: 'idx_equipe',
        fields: ['equipe']
      },
      {
        name: 'unique_jogo_atleta',
        unique: true,
        fields: ['jogo_id', 'atleta_id']
      }
    ]
  });

  JogoParticipante.associate = function(models) {
    JogoParticipante.belongsTo(models.Jogo, {
      foreignKey: 'jogo_id',
      as: 'jogo',
      onDelete: 'CASCADE'
    });
    
    JogoParticipante.belongsTo(models.Atleta, {
      foreignKey: 'atleta_id',
      as: 'atleta'
    });
  };

  return JogoParticipante;
};
