'use strict';

module.exports = (sequelize, DataTypes) => {
  const StatusJogo = sequelize.define('StatusJogo', {
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
    tableName: 'status_jogos',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_codigo',
        fields: ['codigo']
      }
    ]
  });

  StatusJogo.associate = function(models) {
    StatusJogo.hasMany(models.Jogo, {
      foreignKey: 'status_id',
      as: 'jogos'
    });
  };

  // Método para inserir os valores padrão
  StatusJogo.insertDefaultValues = async function() {
    const statusJogos = [
      { nome: 'Agendado', descricao: 'Jogo agendado para acontecer', codigo: 'AGENDADO', ativo: true },
      { nome: 'Em Andamento', descricao: 'Jogo em andamento', codigo: 'EM_ANDAMENTO', ativo: true },
      { nome: 'Finalizado', descricao: 'Jogo finalizado', codigo: 'FINALIZADO', ativo: true },
      { nome: 'Cancelado', descricao: 'Jogo cancelado', codigo: 'CANCELADO', ativo: true }
    ];

    for (const status of statusJogos) {
      await this.findOrCreate({
        where: { codigo: status.codigo },
        defaults: status
      });
    }
  };

  return StatusJogo;
};
