'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoMetodoPagamento = sequelize.define('TipoMetodoPagamento', {
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
    tableName: 'tipo_metodo_pagamento',
    timestamps: true,
    createdAt: 'created_at',
    updated_at: 'updated_at',
    indexes: [
      {
        name: 'idx_codigo_tipo_metodo_pagamento',
        fields: ['codigo'],
        unique: true
      }
    ]
  });

  TipoMetodoPagamento.associate = function(models) {
    TipoMetodoPagamento.hasMany(models.Pagamento, {
      foreignKey: 'metodo_pagamento_id',
      as: 'pagamentos'
    });
  };

  // Método para inserir valores padrão
  TipoMetodoPagamento.insertDefaultValues = async function() {
    const defaultValues = [
      { nome: 'Cartão de Crédito', codigo: 'CARTAO_CREDITO', descricao: 'Pagamento via cartão de crédito' },
      { nome: 'PIX', codigo: 'PIX', descricao: 'Pagamento via PIX' },
      { nome: 'Boleto', codigo: 'BOLETO', descricao: 'Pagamento via boleto bancário' }
    ];

    try {
      for (const value of defaultValues) {
        await TipoMetodoPagamento.findOrCreate({
          where: { codigo: value.codigo },
          defaults: value
        });
      }
      console.log('Valores padrão de TipoMetodoPagamento inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de TipoMetodoPagamento:', error);
    }
  };

  return TipoMetodoPagamento;
};
