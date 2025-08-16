'use strict';

module.exports = (sequelize, DataTypes) => {
  const Avaliacao = sequelize.define('Avaliacao', {
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
    data_avaliacao: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    status: {
      type: DataTypes.ENUM('AGENDADA', 'REALIZADA', 'CANCELADA'),
      defaultValue: 'AGENDADA'
    },
    observacoes_gerais: {
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
    tableName: 'avaliacoes',
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
        fields: ['data_avaliacao']
      },
      {
        name: 'idx_status',
        fields: ['status']
      }
    ]
  });

  Avaliacao.associate = function(models) {
    Avaliacao.belongsTo(models.Arena, {
      foreignKey: 'arena_id',
      as: 'arena'
    });
    
    Avaliacao.belongsTo(models.Professor, {
      foreignKey: 'professor_id',
      as: 'professor'
    });
    
    Avaliacao.belongsTo(models.Aluno, {
      foreignKey: 'aluno_id',
      as: 'aluno'
    });
    
    Avaliacao.hasMany(models.AvaliacaoItem, {
      foreignKey: 'avaliacao_id',
      as: 'itens'
    });
  };

  return Avaliacao;
};
