'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoLog = sequelize.define('TipoLog', {
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
    tableName: 'tipo_log',
    timestamps: true,
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
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
  TipoLog.insertDefaultValues = async function() {
    const tiposLog = [
      { nome: 'Informação', codigo: 'INFO', descricao: 'Log informativo' },
      { nome: 'Aviso', codigo: 'AVISO', descricao: 'Log de aviso' },
      { nome: 'Erro', codigo: 'ERRO', descricao: 'Log de erro' },
      { nome: 'Crítico', codigo: 'CRITICO', descricao: 'Log de erro crítico' },
      { nome: 'Segurança', codigo: 'SEGURANCA', descricao: 'Log relacionado à segurança' },
      { nome: 'Auditoria', codigo: 'AUDITORIA', descricao: 'Log de auditoria' }
    ];

    try {
      for (const tipo of tiposLog) {
        await TipoLog.findOrCreate({
          where: { codigo: tipo.codigo },
          defaults: tipo
        });
      }
      console.log('Valores padrão de TipoLog inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de TipoLog:', error);
      throw error;
    }
  };

  return TipoLog;
};
