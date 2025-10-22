'use strict';

module.exports = (sequelize, DataTypes) => {
  const DificuldadeItemTreino = sequelize.define('DificuldadeItemTreino', {
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
    tableName: 'dificuldade_item_treino',
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
  DificuldadeItemTreino.insertDefaultValues = async function() {
    const dificuldades = [
      { nome: 'Iniciante', codigo: 'INICIANTE', descricao: 'Nível básico para iniciantes' },
      { nome: 'Intermediário', codigo: 'INTERMEDIARIO', descricao: 'Nível médio para praticantes com experiência' },
      { nome: 'Avançado', codigo: 'AVANCADO', descricao: 'Nível avançado para praticantes experientes' }
    ];

    try {
      for (const dificuldade of dificuldades) {
        await DificuldadeItemTreino.findOrCreate({
          where: { codigo: dificuldade.codigo },
          defaults: dificuldade
        });
      }
      console.log('Valores padrão de DificuldadeItemTreino inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de DificuldadeItemTreino:', error);
      throw error;
    }
  };

  return DificuldadeItemTreino;
};
