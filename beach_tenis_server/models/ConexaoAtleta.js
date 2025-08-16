'use strict';

module.exports = (sequelize, DataTypes) => {
  const ConexaoAtleta = sequelize.define('ConexaoAtleta', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    atleta_origem_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'atletas',
        key: 'id'
      }
    },
    atleta_destino_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'atletas',
        key: 'id'
      }
    },
    status: {
      type: DataTypes.ENUM('PENDENTE', 'ACEITO', 'BLOQUEADO'),
      defaultValue: 'PENDENTE'
    },
    data_solicitacao: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    data_resposta: {
      type: DataTypes.DATE,
      allowNull: true
    }
  }, {
    tableName: 'conexoes_atletas',
    timestamps: false,
    indexes: [
      {
        name: 'idx_origem',
        fields: ['atleta_origem_id']
      },
      {
        name: 'idx_destino',
        fields: ['atleta_destino_id']
      },
      {
        name: 'idx_status',
        fields: ['status']
      },
      {
        name: 'unique_conexao',
        unique: true,
        fields: ['atleta_origem_id', 'atleta_destino_id']
      }
    ]
  });

  ConexaoAtleta.associate = function(models) {
    ConexaoAtleta.belongsTo(models.Atleta, {
      foreignKey: 'atleta_origem_id',
      as: 'atletaOrigem',
      onDelete: 'CASCADE'
    });
    
    ConexaoAtleta.belongsTo(models.Atleta, {
      foreignKey: 'atleta_destino_id',
      as: 'atletaDestino',
      onDelete: 'CASCADE'
    });
  };

  return ConexaoAtleta;
};
