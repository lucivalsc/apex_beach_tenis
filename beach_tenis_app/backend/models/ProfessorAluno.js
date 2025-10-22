'use strict';

module.exports = (sequelize, DataTypes) => {
  const ProfessorAluno = sequelize.define('ProfessorAluno', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
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
    data_inicio: {
      type: DataTypes.DATEONLY,
      allowNull: false,
      defaultValue: DataTypes.NOW
    },
    data_fim: {
      type: DataTypes.DATEONLY,
      allowNull: true
    },
    ativo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    createdAt: {
      type: DataTypes.DATE,
      allowNull: false
    },
    updatedAt: {
      type: DataTypes.DATE,
      allowNull: false
    }
  }, {
    tableName: 'professores_alunos',
    timestamps: true,
    indexes: [
      {
        name: 'idx_professor_aluno',
        fields: ['professor_id', 'aluno_id'],
        unique: true
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
        name: 'idx_ativo',
        fields: ['ativo']
      }
    ]
  });

  ProfessorAluno.associate = function (models) {
    ProfessorAluno.belongsTo(models.Professor, {
      foreignKey: 'professor_id',
      as: 'professor'
    });

    ProfessorAluno.belongsTo(models.Aluno, {
      foreignKey: 'aluno_id',
      as: 'aluno'
    });
  };

  return ProfessorAluno;
};
