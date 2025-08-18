'use strict';

module.exports = (sequelize, DataTypes) => {
  const StatusPagamento = sequelize.define('StatusPagamento', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    nome: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    codigo: {
      type: DataTypes.STRING(20),
      allowNull: false,
      unique: true
    },
    descricao: {
      type: DataTypes.STRING(255)
    },
    ativo: {
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
    tableName: 'status_pagamento',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_codigo_status_pagamento',
        fields: ['codigo'],
        unique: true
      }
    ]
  });

  StatusPagamento.associate = function(models) {
    StatusPagamento.hasMany(models.Pagamento, {
      foreignKey: 'status_id',
      as: 'pagamentos'
    });
  };

  // Método para inserir valores padrão
  StatusPagamento.insertDefaultValues = async function() {
    const defaultValues = [
      { nome: 'Pendente', codigo: 'PENDENTE', descricao: 'Pagamento pendente de processamento' },
      { nome: 'Processando', codigo: 'PROCESSANDO', descricao: 'Pagamento em processamento' },
      { nome: 'Aprovado', codigo: 'APROVADO', descricao: 'Pagamento aprovado' },
      { nome: 'Recusado', codigo: 'RECUSADO', descricao: 'Pagamento recusado' },
      { nome: 'Cancelado', codigo: 'CANCELADO', descricao: 'Pagamento cancelado' }
    ];

    try {
      for (const value of defaultValues) {
        await StatusPagamento.findOrCreate({
          where: { codigo: value.codigo },
          defaults: value
        });
      }
      console.log('Valores padrão de StatusPagamento inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de StatusPagamento:', error);
    }
  };

  return StatusPagamento;
};
