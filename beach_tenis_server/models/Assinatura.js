'use strict';

module.exports = (sequelize, DataTypes) => {
  const Assinatura = sequelize.define('Assinatura', {
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
    pacote_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'pacotes_pagamento',
        key: 'id'
      }
    },
    status_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'status_assinaturas',
        key: 'id'
      }
    },
    data_inicio: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    data_fim: {
      type: DataTypes.DATEONLY,
      allowNull: false
    },
    renovacao_automatica: {
      type: DataTypes.BOOLEAN,
      defaultValue: true
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
    tableName: 'assinaturas',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_usuario',
        fields: ['usuario_id']
      },
      {
        name: 'idx_status',
        fields: ['status_id']
      },
      {
        name: 'idx_vencimento',
        fields: ['data_fim']
      }
    ]
  });

  Assinatura.associate = function(models) {
    Assinatura.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario',
      onDelete: 'CASCADE'
    });
    
    Assinatura.belongsTo(models.PacotePagamento, {
      foreignKey: 'pacote_id',
      as: 'pacote'
    });
    
    Assinatura.belongsTo(models.StatusAssinatura, {
      foreignKey: 'status_id',
      as: 'status'
    });
    
    Assinatura.hasMany(models.Pagamento, {
      foreignKey: 'assinatura_id',
      as: 'pagamentos'
    });
  };

  return Assinatura;
};
