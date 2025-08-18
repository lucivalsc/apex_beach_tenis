'use strict';

module.exports = (sequelize, DataTypes) => {
  const UsuarioTipo = sequelize.define('UsuarioTipo', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    usuario_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'usuarios',
        key: 'id'
      }
    },
    tipo_usuario_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipos_usuario',
        key: 'id'
      }
    },
    principal: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false
    },
    ativo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    created_at: {
      type: DataTypes.DATE,
      allowNull: false
    },
    updated_at: {
      type: DataTypes.DATE,
      allowNull: false
    }
  }, {
    tableName: 'usuarios_tipos',
    indexes: [
      {
        name: 'idx_usuario_tipo_usuario',
        fields: ['usuario_id']
      },
      {
        name: 'idx_usuario_tipo_tipo',
        fields: ['tipo_usuario_id']
      },
      {
        name: 'idx_usuario_tipo_principal',
        fields: ['principal']
      },
      {
        name: 'idx_usuario_tipo_ativo',
        fields: ['ativo']
      },
      {
        name: 'idx_usuario_tipo_unico',
        unique: true,
        fields: ['usuario_id', 'tipo_usuario_id']
      }
    ]
  });

  UsuarioTipo.associate = function(models) {
    UsuarioTipo.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario'
    });
    
    UsuarioTipo.belongsTo(models.TipoUsuario, {
      foreignKey: 'tipo_usuario_id',
      as: 'tipo_usuario'
    });
  };

  return UsuarioTipo;
};
