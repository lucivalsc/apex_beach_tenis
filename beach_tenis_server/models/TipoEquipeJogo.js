'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoEquipeJogo = sequelize.define('TipoEquipeJogo', {
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
    tableName: 'tipo_equipe_jogo',
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
  TipoEquipeJogo.insertDefaultValues = async function() {
    const tiposEquipe = [
      { nome: 'Equipe A', codigo: 'A', descricao: 'Equipe A do jogo' },
      { nome: 'Equipe B', codigo: 'B', descricao: 'Equipe B do jogo' }
    ];

    try {
      for (const tipo of tiposEquipe) {
        await TipoEquipeJogo.findOrCreate({
          where: { codigo: tipo.codigo },
          defaults: tipo
        });
      }
      console.log('Valores padrão de TipoEquipeJogo inseridos com sucesso');
    } catch (error) {
      console.error('Erro ao inserir valores padrão de TipoEquipeJogo:', error);
      throw error;
    }
  };

  return TipoEquipeJogo;
};
