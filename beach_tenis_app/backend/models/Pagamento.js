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
    metodo_pagamento_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'tipo_metodo_pagamento',
        key: 'id'
      }
    },
    status_id: {
      type: DataTypes.INTEGER,
      references: {
        model: 'status_pagamento',
        key: 'id'
      }
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
    createdAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    updatedAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'pagamentos',
    timestamps: true,
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
    indexes: [
      {
        name: 'idx_assinatura',
        fields: ['assinatura_id']
      },
      {
        name: 'idx_status',
        fields: ['status_id']
      },
      {
        name: 'idx_metodo_pagamento',
        fields: ['metodo_pagamento_id']
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
    
    Pagamento.belongsTo(models.TipoMetodoPagamento, {
      foreignKey: 'metodo_pagamento_id',
      as: 'metodoPagamento'
    });
    
    Pagamento.belongsTo(models.StatusPagamento, {
      foreignKey: 'status_id',
      as: 'status'
    });
  };

  return Pagamento;
};
