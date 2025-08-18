'use strict';

module.exports = (sequelize, DataTypes) => {
  const ConfiguracaoSistema = sequelize.define('ConfiguracaoSistema', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    chave: {
      type: DataTypes.STRING(100),
      allowNull: false,
      unique: true
    },
    valor: {
      type: DataTypes.TEXT
    },
    descricao: {
      type: DataTypes.STRING(255)
    },
    tipo_id: {
      type: DataTypes.INTEGER,
      references: {
        model: 'tipo_configuracao',
        key: 'id'
      }
    },
    updatedAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'configuracoes_sistema',
    timestamps: true,
    createdAt: false,
    updatedAt: 'updatedAt'
  });

  ConfiguracaoSistema.associate = function(models) {
    ConfiguracaoSistema.belongsTo(models.TipoConfiguracao, {
      foreignKey: 'tipo_id',
      as: 'tipo'
    });
  };

  return ConfiguracaoSistema;
};
