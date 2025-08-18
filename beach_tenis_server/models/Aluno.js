'use strict';

module.exports = (sequelize, DataTypes) => {
  const Aluno = sequelize.define('Aluno', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    usuario_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      unique: true,
      references: {
        model: 'usuarios',
        key: 'id'
      }
    },
    nome: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    cpf: {
      type: DataTypes.STRING(14),
      unique: true
    },
    data_nascimento: {
      type: DataTypes.DATEONLY
    },
    tipo_sexo_id: {
      type: DataTypes.INTEGER,
      references: {
        model: 'tipos_sexo',
        key: 'id'
      }
    },
    cidade: {
      type: DataTypes.STRING(100)
    },
    telefone: {
      type: DataTypes.STRING(20)
    },
    whatsapp: {
      type: DataTypes.BOOLEAN,
      defaultValue: false
    },
    instagram: {
      type: DataTypes.STRING(100)
    },
    facebook: {
      type: DataTypes.STRING(100)
    },
    ativo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
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
    tableName: 'alunos',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_usuario',
        fields: ['usuario_id']
      },
      {
        name: 'idx_cpf',
        fields: ['cpf'],
        unique: true
      },
      {
        name: 'idx_tipo_sexo',
        fields: ['tipo_sexo_id']
      },
      {
        name: 'idx_ativo',
        fields: ['ativo']
      }
    ]
  });

  Aluno.associate = function(models) {
    Aluno.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario'
    });
    
    Aluno.belongsTo(models.TipoSexo, {
      foreignKey: 'tipo_sexo_id',
      as: 'tipoSexo'
    });

    Aluno.belongsToMany(models.Arena, {
      through: models.ArenaAluno,
      foreignKey: 'aluno_id',
      otherKey: 'arena_id',
      as: 'arenas'
    });

    Aluno.belongsToMany(models.Professor, {
      through: models.ProfessorAluno,
      foreignKey: 'aluno_id',
      otherKey: 'professor_id',
      as: 'professores'
    });

    Aluno.hasMany(models.Jogo, {
      foreignKey: 'aluno_id',
      as: 'jogos'
    });
  };

  return Aluno;
};
