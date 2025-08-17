'use strict';

module.exports = (sequelize, DataTypes) => {
  const Usuario = sequelize.define('Usuario', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    nome: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    telefone: {
      type: DataTypes.STRING(20),
      allowNull: false
    },
    instagram: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    facebook: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    linkedin: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    email: {
      type: DataTypes.STRING(255),
      allowNull: false,
      unique: true
    },
    password_hash: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    tipo_principal: {
      type: DataTypes.ENUM('ARENA', 'ATLETA', 'ALUNO', 'PROFESSOR', 'PROFISSIONAL_TECNICO', 'ADMIN'),
      allowNull: false
    },
    ativo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    email_verificado: {
      type: DataTypes.BOOLEAN,
      defaultValue: false
    },
    ultimo_login: {
      type: DataTypes.DATE,
      allowNull: true
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
    tableName: 'usuarios',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_email',
        fields: ['email']
      },
      {
        name: 'idx_tipo',
        fields: ['tipo_principal']
      },
      {
        name: 'idx_ativo',
        fields: ['ativo']
      }
    ]
  });

  Usuario.associate = function (models) {
    // Associações com os perfis específicos
    Usuario.hasOne(models.Arena, {
      foreignKey: 'usuario_id',
      as: 'arena'
    });

    Usuario.hasOne(models.Atleta, {
      foreignKey: 'usuario_id',
      as: 'atleta'
    });

    Usuario.hasOne(models.Professor, {
      foreignKey: 'usuario_id',
      as: 'professor'
    });

    Usuario.hasOne(models.Aluno, {
      foreignKey: 'usuario_id',
      as: 'aluno'
    });

    Usuario.hasOne(models.ProfissionalTecnico, {
      foreignKey: 'usuario_id',
      as: 'profissionalTecnico'
    });

    // Associação com assinaturas
    Usuario.hasMany(models.Assinatura, {
      foreignKey: 'usuario_id',
      as: 'assinaturas'
    });

    // Associação com notificações
    Usuario.hasMany(models.Notificacao, {
      foreignKey: 'usuario_id',
      as: 'notificacoes'
    });

    // Associação com logs
    Usuario.hasMany(models.LogSistema, {
      foreignKey: 'usuario_id',
      as: 'logs'
    });
  };

  return Usuario;
};
