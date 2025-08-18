'use strict';

module.exports = (sequelize, DataTypes) => {
  const Jogo = sequelize.define('Jogo', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    arena_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'arenas',
        key: 'id'
      }
    },
    profissional_tecnico_id: {
      type: DataTypes.INTEGER,
      references: {
        model: 'profissionais_tecnicos',
        key: 'id'
      }
    },
    titulo: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    descricao: {
      type: DataTypes.TEXT
    },
    data_jogo: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    hora_inicio: {
      type: DataTypes.TIME,
      allowNull: false
    },
    hora_fim: {
      type: DataTypes.TIME
    },
    tipo_jogo_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipos_jogo',
        key: 'id'
      }
    },
    status_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'status_jogos',
        key: 'id'
      }
    },
    resultado: {
      type: DataTypes.JSON
    },
    observacoes: {
      type: DataTypes.TEXT
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
    tableName: 'jogos',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_arena',
        fields: ['arena_id']
      },
      {
        name: 'idx_profissional',
        fields: ['profissional_tecnico_id']
      },
      {
        name: 'idx_data',
        fields: ['data_jogo']
      },
      {
        name: 'idx_status',
        fields: ['status_id']
      },
      {
        name: 'idx_tipo',
        fields: ['tipo_jogo_id']
      }
    ]
  });

  Jogo.associate = function(models) {
    Jogo.belongsTo(models.Arena, {
      foreignKey: 'arena_id',
      as: 'arena'
    });
    
    Jogo.belongsTo(models.ProfissionalTecnico, {
      foreignKey: 'profissional_tecnico_id',
      as: 'profissionalTecnico'
    });
    
    Jogo.belongsTo(models.TipoJogo, {
      foreignKey: 'tipo_jogo_id',
      as: 'tipoJogo'
    });
    
    Jogo.belongsTo(models.StatusJogo, {
      foreignKey: 'status_id',
      as: 'status'
    });
    
    Jogo.hasMany(models.JogoParticipante, {
      foreignKey: 'jogo_id',
      as: 'participantes'
    });
    
    Jogo.hasMany(models.JogoSet, {
      foreignKey: 'jogo_id',
      as: 'sets'
    });
    
    Jogo.hasMany(models.JogoJogada, {
      foreignKey: 'jogo_id',
      as: 'jogadas'
    });
  };

  return Jogo;
};
