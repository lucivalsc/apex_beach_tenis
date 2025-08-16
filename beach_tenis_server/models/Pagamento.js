'use strict';

module.exports = (sequelize, DataTypes) => {
  const Pagamento = sequelize.define('Pagamento', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    assinatura_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'assinaturas',
        key: 'id'
      }
    },
    valor: {
      type: DataTypes.DECIMAL(10, 2),
      allowNull: false
    },
    metodo_pagamento: {
      type: DataTypes.ENUM('CARTAO_CREDITO', 'PIX', 'BOLETO'),
      allowNull: false
    },
    status: {
      type: DataTypes.ENUM('PENDENTE', 'PROCESSANDO', 'APROVADO', 'RECUSADO', 'CANCELADO'),
      defaultValue: 'PENDENTE'
    },
    referencia_externa: {
      type: DataTypes.STRING(255)
    },
    dados_pagamento: {
      type: DataTypes.JSON
    },
    data_vencimento: {
      type: DataTypes.DATEONLY
    },
    data_pagamento: {
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
    tableName: 'pagamentos',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_assinatura',
        fields: ['assinatura_id']
      },
      {
        name: 'idx_status',
        fields: ['status']
      },
      {
        name: 'idx_referencia',
        fields: ['referencia_externa']
      }
    ]
  });

  Pagamento.associate = function(models) {
    Pagamento.belongsTo(models.Assinatura, {
      foreignKey: 'assinatura_id',
      as: 'assinatura',
      onDelete: 'CASCADE'
    });
  };

  return Pagamento;
};
