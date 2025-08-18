'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoConfiguracao = sequelize.define('TipoConfiguracao', {
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
    created_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    updated_at: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'tipo_configuracao',
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
  TipoConfiguracao.insertDefaultValues = async function() {
    const tiposConfiguracao = [
      { nome: 'String', codigo: 'STRING', descricao: 'Configuração do tipo texto' },
      { nome: 'Inteiro', codigo: 'INTEGER', descricao: 'Configuração do tipo número inteiro' },
      { nome: 'Booleano', codigo: 'BOOLEAN', descricao: 'Configuração do tipo verdadeiro/falso' },
      { nome: 'JSON', codigo: 'JSON', descricao: 'Configuração do tipo objeto JSON' }
    ];

    try {
      for (const tipo of tiposConfiguracao) {
        await TipoConfiguracao.findOrCreate({
          where: { codigo: tipo.codigo },
          defaults: tipo
        });
      }
      console.log('Valores padrão de TipoConfiguracao inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de TipoConfiguracao:', error);
      throw error;
    }
  };

  return TipoConfiguracao;
};
