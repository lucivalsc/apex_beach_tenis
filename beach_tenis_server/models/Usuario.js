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
      allowNull: true
    },
    telefone: {
      type: DataTypes.STRING(20),
      allowNull: true
    },
    instagram: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    facebook: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    linkedin: {
      type: DataTypes.STRING(100),
      allowNull: true
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
    tipo_usuario_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipos_usuario',
        key: 'id'
      }
    },
    tipo_sexo_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipos_sexo',
        key: 'id'
      }
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
    }
  }, {
    tableName: 'usuarios',
    timestamps: true,
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
    indexes: [
      {
        name: 'idx_email',
        fields: ['email'],
        unique: true
      },
      {
        name: 'idx_tipo_usuario',
        fields: ['tipo_usuario_id']
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

  Usuario.associate = function (models) {
    // Associação com tipo de usuário
    Usuario.belongsTo(models.TipoUsuario, {
      foreignKey: 'tipo_usuario_id',
      as: 'tipoUsuario'
    });
    
    // Associação com tipo de sexo
    Usuario.belongsTo(models.TipoSexo, {
      foreignKey: 'tipo_sexo_id',
      as: 'tipoSexo'
    });
    
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
    
    // Associação com endereços
    Usuario.hasMany(models.Endereco, {
      foreignKey: 'usuario_id',
      as: 'enderecos'
    });
    
    // Associação com tipos de usuário
    Usuario.hasMany(models.UsuarioTipo, {
      foreignKey: 'usuario_id',
      as: 'tipos'
    });
  
  };

  return Usuario;
};
