'use strict';

module.exports = (sequelize, DataTypes) => {
  const Professor = sequelize.define('Professor', {
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
        model: 'tipo_sexo',
        key: 'id'
      }
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
    tableName: 'professores',
    timestamps: true,
    createdAt: 'created_at',
    updated_at: 'updated_at',
    indexes: [
      {
        name: 'idx_cpf',
        fields: ['cpf']
      },
      {
        name: 'idx_nome',
        fields: ['nome']
      },
      {
        name: 'idx_ativo',
        fields: ['ativo']
      },
      {
        name: 'idx_tipo_sexo',
        fields: ['tipo_sexo_id']
      }
    ]
  });

  Professor.associate = function(models) {
    Professor.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario',
      onDelete: 'CASCADE'
    });
    
    Professor.belongsTo(models.TipoSexo, {
      foreignKey: 'tipo_sexo_id',
      as: 'tipoSexo'
    });
    
    // Relação com arenas
    Professor.hasMany(models.ArenaProfessor, {
      foreignKey: 'professor_id',
      as: 'arenasVinculadas'
    });
    
    // Treinos ministrados
    Professor.hasMany(models.Treino, {
      foreignKey: 'professor_id',
      as: 'treinos'
    });
    
    // Avaliações realizadas
    Professor.hasMany(models.Avaliacao, {
      foreignKey: 'professor_id',
      as: 'avaliacoes'
    });
    
    // Relação com alunos
    Professor.belongsToMany(models.Aluno, {
      through: models.ProfessorAluno,
      foreignKey: 'professor_id',
      otherKey: 'aluno_id',
      as: 'alunos'
    });
  };

  return Professor;
};
