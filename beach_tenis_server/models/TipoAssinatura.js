'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoAssinatura = sequelize.define('TipoAssinatura', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    nome: {
      type: DataTypes.STRING(50),
      allowNull: false,
      unique: true
    },
    descricao: {
      type: DataTypes.TEXT
    },
    ativo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    createdAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    updatedAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'tipos_assinatura',
    timestamps: true,
    createdAt: 'createdAt',
    updatedAt: 'updatedAt'
  });

  TipoAssinatura.associate = function(models) {
    TipoAssinatura.hasMany(models.PacotePagamento, {
      foreignKey: 'tipo_assinatura_id',
      as: 'pacotes'
    });
  };

  return TipoAssinatura;
};
