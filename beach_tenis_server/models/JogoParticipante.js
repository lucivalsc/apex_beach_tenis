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
    tipo_equipe_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipo_equipe',
        key: 'id'
      }
    },
    tipo_posicao_id: {
      type: DataTypes.INTEGER,
      allowNull: true,
      references: {
        model: 'tipo_posicao',
        key: 'id'
      }
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
    updated_at: false,
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
        name: 'idx_tipo_equipe',
        fields: ['tipo_equipe_id']
      },
      {
        name: 'idx_tipo_posicao',
        fields: ['tipo_posicao_id']
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
    
    JogoParticipante.belongsTo(models.TipoEquipe, {
      foreignKey: 'tipo_equipe_id',
      as: 'tipoEquipe'
    });
    
    JogoParticipante.belongsTo(models.TipoPosicao, {
      foreignKey: 'tipo_posicao_id',
      as: 'tipoPosicao'
    });
  };

  return JogoParticipante;
};
