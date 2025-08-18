'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoResultadoJogada = sequelize.define('TipoResultadoJogada', {
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
    tableName: 'tipo_resultado_jogada',
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
  TipoResultadoJogada.insertDefaultValues = async function() {
    const tiposResultado = [
      { nome: 'Sucesso', codigo: 'SUCESSO', descricao: 'Jogada bem-sucedida' },
      { nome: 'Erro', codigo: 'ERRO', descricao: 'Jogada com erro' },
      { nome: 'Neutro', codigo: 'NEUTRO', descricao: 'Jogada neutra sem resultado definido' }
    ];

    try {
      for (const tipo of tiposResultado) {
        await TipoResultadoJogada.findOrCreate({
          where: { codigo: tipo.codigo },
          defaults: tipo
        });
      }
      console.log('Valores padrão de TipoResultadoJogada inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de TipoResultadoJogada:', error);
      throw error;
    }
  };

  return TipoResultadoJogada;
};
