'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoEquipe = sequelize.define('TipoEquipe', {
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
    createdAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    updatedAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'tipo_equipe',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_codigo_tipo_equipe',
        fields: ['codigo'],
        unique: true
      }
    ]
  });

  TipoEquipe.associate = function(models) {
    // Associação removida pois agora usamos TipoEquipeJogo
  };

  // Método para inserir valores padrão
  TipoEquipe.insertDefaultValues = async function() {
    const defaultValues = [
      { nome: 'Equipe A', codigo: 'A', descricao: 'Equipe A do jogo' },
      { nome: 'Equipe B', codigo: 'B', descricao: 'Equipe B do jogo' }
    ];

    try {
      for (const value of defaultValues) {
        await TipoEquipe.findOrCreate({
          where: { codigo: value.codigo },
          defaults: value
        });
      }
      console.log('Valores padrão de TipoEquipe inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de TipoEquipe:', error);
    }
  };

  return TipoEquipe;
};
