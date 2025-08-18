'use strict';

module.exports = (sequelize, DataTypes) => {
  const PacotePagamento = sequelize.define('PacotePagamento', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    tipo_assinatura_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipos_assinatura',
        key: 'id'
      }
    },
    nome: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    descricao: {
      type: DataTypes.TEXT
    },
    valor: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false
    },
    periodicidade_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipo_periodicidade',
        key: 'id'
      }
    },
    quantidade_alunos: {
      type: DataTypes.INTEGER,
      allowNull: true
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
    tableName: 'pacotes_pagamento',
    timestamps: true,
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
    indexes: [
      {
        name: 'idx_tipo_assinatura',
        fields: ['tipo_assinatura_id']
      },
      {
        name: 'idx_periodicidade',
        fields: ['periodicidade_id']
      },
      {
        name: 'idx_ativo',
        fields: ['ativo']
      }
    ]
  });

  PacotePagamento.associate = function(models) {
    PacotePagamento.belongsTo(models.TipoAssinatura, {
      foreignKey: 'tipo_assinatura_id',
      as: 'tipoAssinatura'
    });
    
    PacotePagamento.belongsTo(models.TipoPeriodicidade, {
      foreignKey: 'periodicidade_id',
      as: 'periodicidade'
    });
    
    PacotePagamento.hasMany(models.Assinatura, {
      foreignKey: 'pacote_id',
      as: 'assinaturas'
    });
  };

  return PacotePagamento;
};
