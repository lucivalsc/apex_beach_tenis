'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoJogo = sequelize.define('TipoJogo', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    nome: {
      type: DataTypes.STRING(50),
      allowNull: false,
      unique: true
    },
    descricao: {
      type: DataTypes.STRING(255),
      allowNull: true
    },
    codigo: {
      type: DataTypes.STRING(50),
      allowNull: false,
      unique: true
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
    tableName: 'tipos_jogo',
    timestamps: true,
    createdAt: 'created_at',
    updated_at: 'updated_at',
    indexes: [
      {
        name: 'idx_codigo',
        fields: ['codigo']
      }
    ]
  });

  TipoJogo.associate = function(models) {
    TipoJogo.hasMany(models.Jogo, {
      foreignKey: 'tipo_jogo_id',
      as: 'jogos'
    });
  };

  // Método para inserir os valores padrão
  TipoJogo.insertDefaultValues = async function() {
    const tiposJogo = [
      { nome: 'Simples', descricao: 'Jogo com um jogador de cada lado', codigo: 'SIMPLES', ativo: true },
      { nome: 'Duplas', descricao: 'Jogo com dois jogadores de cada lado', codigo: 'DUPLAS', ativo: true }
    ];

    for (const tipo of tiposJogo) {
      await this.findOrCreate({
        where: { codigo: tipo.codigo },
        defaults: tipo
      });
    }
  };

  return TipoJogo;
};
