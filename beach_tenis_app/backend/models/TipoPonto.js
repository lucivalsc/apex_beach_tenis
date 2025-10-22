'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoPonto = sequelize.define('TipoPonto', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    nome: {
      type: DataTypes.STRING(100),
      allowNull: false
    },
    codigo: {
      type: DataTypes.STRING(50),
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
    createdAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    updatedAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'tipo_ponto',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_codigo',
        fields: ['codigo'],
        unique: true
      },
      {
        name: 'idx_ativo',
        fields: ['ativo']
      }
    ]
  });

  // Método estático para inserir valores padrão
  TipoPonto.insertDefaultValues = async function() {
    const tiposPonto = [
      { nome: 'Winner', codigo: 'WINNER', descricao: 'Ponto direto' },
      { nome: 'Erro do Adversário', codigo: 'ERRO_ADVERSARIO', descricao: 'Ponto por erro do adversário' },
      { nome: 'Ace', codigo: 'ACE', descricao: 'Saque direto sem devolução' },
      { nome: 'Dupla Falta', codigo: 'DUPLA_FALTA', descricao: 'Erro no saque' }
    ];

    try {
      for (const tipo of tiposPonto) {
        await TipoPonto.findOrCreate({
          where: { codigo: tipo.codigo },
          defaults: tipo
        });
      }
      console.log('Valores padrão de TipoPonto inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de TipoPonto:', error);
      throw error;
    }
  };

  return TipoPonto;
};
