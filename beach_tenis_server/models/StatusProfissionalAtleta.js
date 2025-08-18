'use strict';

module.exports = (sequelize, DataTypes) => {
  const StatusProfissionalAtleta = sequelize.define('StatusProfissionalAtleta', {
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
    tableName: 'status_profissional_atleta',
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
  StatusProfissionalAtleta.insertDefaultValues = async function() {
    const statusProfissionalAtleta = [
      { nome: 'Pendente', codigo: 'PENDENTE', descricao: 'Solicitação pendente de aprovação' },
      { nome: 'Aceito', codigo: 'ACEITO', descricao: 'Solicitação aceita' },
      { nome: 'Cancelado', codigo: 'CANCELADO', descricao: 'Solicitação cancelada' }
    ];

    try {
      for (const status of statusProfissionalAtleta) {
        await StatusProfissionalAtleta.findOrCreate({
          where: { codigo: status.codigo },
          defaults: status
        });
      }
      console.log('Valores padrão de StatusProfissionalAtleta inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de StatusProfissionalAtleta:', error);
      throw error;
    }
  };

  return StatusProfissionalAtleta;
};
