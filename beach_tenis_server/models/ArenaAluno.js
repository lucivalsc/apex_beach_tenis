'use strict';

module.exports = (sequelize, DataTypes) => {
  const ArenaAluno = sequelize.define('ArenaAluno', {
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
    aluno_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'alunos',
        key: 'id'
      }
    },
    ativo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    data_vinculo: {
      type: DataTypes.DATEONLY,
      defaultValue: DataTypes.NOW
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'arena_alunos',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: false,
    indexes: [
      {
        name: 'idx_arena',
        fields: ['arena_id']
      },
      {
        name: 'idx_aluno',
        fields: ['aluno_id']
      },
      {
        name: 'unique_arena_aluno',
        unique: true,
        fields: ['arena_id', 'aluno_id']
      }
    ]
  });

  ArenaAluno.associate = function(models) {
    ArenaAluno.belongsTo(models.Arena, {
      foreignKey: 'arena_id',
      as: 'arena',
      onDelete: 'CASCADE'
    });
    
    ArenaAluno.belongsTo(models.Aluno, {
      foreignKey: 'aluno_id',
      as: 'aluno',
      onDelete: 'CASCADE'
    });
  };

  return ArenaAluno;
};
