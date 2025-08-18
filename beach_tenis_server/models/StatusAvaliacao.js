'use strict';

module.exports = (sequelize, DataTypes) => {
  const StatusAvaliacao = sequelize.define('StatusAvaliacao', {
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
    tableName: 'status_avaliacao',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_codigo_status_avaliacao',
        fields: ['codigo'],
        unique: true
      }
    ]
  });

  StatusAvaliacao.associate = function(models) {
    StatusAvaliacao.hasMany(models.Avaliacao, {
      foreignKey: 'status_id',
      as: 'avaliacoes'
    });
  };

  // Método para inserir valores padrão
  StatusAvaliacao.insertDefaultValues = async function() {
    const defaultValues = [
      { nome: 'Agendada', codigo: 'AGENDADA', descricao: 'Avaliação agendada para data futura' },
      { nome: 'Realizada', codigo: 'REALIZADA', descricao: 'Avaliação já realizada' },
      { nome: 'Cancelada', codigo: 'CANCELADA', descricao: 'Avaliação cancelada' }
    ];

    try {
      for (const value of defaultValues) {
        await StatusAvaliacao.findOrCreate({
          where: { codigo: value.codigo },
          defaults: value
        });
      }
      console.log('Valores padrão de StatusAvaliacao inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de StatusAvaliacao:', error);
    }
  };

  return StatusAvaliacao;
};
