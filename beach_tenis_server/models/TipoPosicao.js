'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoPosicao = sequelize.define('TipoPosicao', {
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
    tableName: 'tipo_posicao',
    timestamps: true,
    createdAt: 'created_at',
    updated_at: 'updated_at',
    indexes: [
      {
        name: 'idx_codigo_tipo_posicao',
        fields: ['codigo'],
        unique: true
      }
    ]
  });

  TipoPosicao.associate = function(models) {
    TipoPosicao.hasMany(models.JogoParticipante, {
      foreignKey: 'tipo_posicao_id',
      as: 'participantes'
    });
  };

  // Método para inserir valores padrão
  TipoPosicao.insertDefaultValues = async function() {
    const defaultValues = [
      { nome: 'Direita', codigo: 'DIREITA', descricao: 'Posição do lado direito da quadra' },
      { nome: 'Esquerda', codigo: 'ESQUERDA', descricao: 'Posição do lado esquerdo da quadra' }
    ];

    try {
      for (const value of defaultValues) {
        await TipoPosicao.findOrCreate({
          where: { codigo: value.codigo },
          defaults: value
        });
      }
      console.log('Valores padrão de TipoPosicao inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de TipoPosicao:', error);
    }
  };

  return TipoPosicao;
};
