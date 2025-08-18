'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoPeriodicidade = sequelize.define('TipoPeriodicidade', {
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
    tableName: 'tipo_periodicidade',
    timestamps: true,
    createdAt: 'created_at',
    updated_at: 'updated_at',
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
  TipoPeriodicidade.insertDefaultValues = async function() {
    const tiposPeriodicidade = [
      { nome: 'Mensal', codigo: 'MENSAL', descricao: 'Periodicidade mensal' },
      { nome: 'Trimestral', codigo: 'TRIMESTRAL', descricao: 'Periodicidade trimestral' },
      { nome: 'Semestral', codigo: 'SEMESTRAL', descricao: 'Periodicidade semestral' },
      { nome: 'Anual', codigo: 'ANUAL', descricao: 'Periodicidade anual' }
    ];

    try {
      for (const tipo of tiposPeriodicidade) {
        await TipoPeriodicidade.findOrCreate({
          where: { codigo: tipo.codigo },
          defaults: tipo
        });
      }
      console.log('Valores padrão de TipoPeriodicidade inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de TipoPeriodicidade:', error);
      throw error;
    }
  };

  return TipoPeriodicidade;
};
