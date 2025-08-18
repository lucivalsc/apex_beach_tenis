'use strict';

module.exports = (sequelize, DataTypes) => {
  const Endereco = sequelize.define('Endereco', {
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
    cep: {
      type: DataTypes.STRING(10),
      allowNull: false
    },
    logradouro: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    numero: {
      type: DataTypes.STRING(20),
      allowNull: false
    },
    complemento: {
      type: DataTypes.STRING(100),
      allowNull: true
    },
    bairro: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    cidade: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    estado: {
      type: DataTypes.STRING(2),
      allowNull: false
    },
    pais: {
      type: DataTypes.STRING(50),
      defaultValue: 'Brasil',
      allowNull: false
    },
    principal: {
      type: DataTypes.BOOLEAN,
      defaultValue: false,
      allowNull: false
    },
    tipo_endereco_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipos_endereco',
        key: 'id'
      }
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
    tableName: 'enderecos',
    indexes: [
      {
        name: 'idx_endereco_usuario',
        fields: ['usuario_id']
      },
      {
        name: 'idx_endereco_principal',
        fields: ['principal']
      },
      {
        name: 'idx_endereco_tipo',
        fields: ['tipo_endereco_id']
      },
      {
        name: 'idx_endereco_ativo',
        fields: ['ativo']
      }
    ]
  });

  Endereco.associate = function(models) {
    Endereco.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario'
    });
    
    Endereco.belongsTo(models.TipoEndereco, {
      foreignKey: 'tipo_endereco_id',
      as: 'tipo_endereco'
    });
  };

  return Endereco;
};
