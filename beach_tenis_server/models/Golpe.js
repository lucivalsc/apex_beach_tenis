'use strict';

module.exports = (sequelize, DataTypes) => {
  const Golpe = sequelize.define('Golpe', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    nome: {
      type: DataTypes.STRING(100),
      allowNull: false,
      unique: true
    },
    descricao: {
      type: DataTypes.TEXT
    },
    categoria: {
      type: DataTypes.STRING(50)
    },
    ativo: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
    },
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'golpes',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: false
  });

  Golpe.associate = function(models) {
    Golpe.hasMany(models.JogoJogada, {
      foreignKey: 'golpe_id',
      as: 'jogadas'
    });
  };

  return Golpe;
};
