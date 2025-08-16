'use strict';

module.exports = (sequelize, DataTypes) => {
  const Treino = sequelize.define('Treino', {
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
    professor_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'professores',
        key: 'id'
      }
    },
    aluno_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'alunos',
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
    data_treino: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    hora_inicio: {
      type: DataTypes.TIME,
      allowNull: false
    },
    hora_fim: {
      type: DataTypes.TIME,
      allowNull: false
    },
    status: {
      type: DataTypes.ENUM('AGENDADO', 'REALIZADO', 'CANCELADO'),
      defaultValue: 'AGENDADO'
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
    tableName: 'treinos',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_arena',
        fields: ['arena_id']
      },
      {
        name: 'idx_professor',
        fields: ['professor_id']
      },
      {
        name: 'idx_aluno',
        fields: ['aluno_id']
      },
      {
        name: 'idx_data',
        fields: ['data_treino']
      },
      {
        name: 'idx_status',
        fields: ['status']
      }
    ]
  });

  Treino.associate = function(models) {
    Treino.belongsTo(models.Arena, {
      foreignKey: 'arena_id',
      as: 'arena'
    });
    
    Treino.belongsTo(models.Professor, {
      foreignKey: 'professor_id',
      as: 'professor'
    });
    
    Treino.belongsTo(models.Aluno, {
      foreignKey: 'aluno_id',
      as: 'aluno'
    });
    
    Treino.hasMany(models.TreinoItem, {
      foreignKey: 'treino_id',
      as: 'itens'
    });
  };

  return Treino;
};
