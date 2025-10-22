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
    status_id: {
      type: DataTypes.INTEGER,
      references: {
        model: 'status_avaliacoes',
        key: 'id'
      }
    },
    observacoes_gerais: {
      type: DataTypes.TEXT
    }
  }, {
    tableName: 'avaliacoes',
    timestamps: true,
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
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
        fields: ['status_id']
      }
    ]
  });

  Avaliacao.associate = function(models) {
    Avaliacao.belongsTo(models.Arena, {
      foreignKey: 'arena_id',
      as: 'arena'
    });
    
    Avaliacao.belongsTo(models.StatusAvaliacao, {
      foreignKey: 'status_id',
      as: 'status'
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
