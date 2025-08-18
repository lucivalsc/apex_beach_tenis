'use strict';

module.exports = (sequelize, DataTypes) => {
  const ProfissionalAtleta = sequelize.define('ProfissionalAtleta', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    profissional_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'profissionais_tecnicos',
        key: 'id'
      }
    },
    atleta_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'atletas',
        key: 'id'
      }
    },
    status_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'status_profissional_atleta',
        key: 'id'
      }
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
    tableName: 'profissional_atletas',
    timestamps: false,
    indexes: [
      {
        name: 'idx_profissional',
        fields: ['profissional_id']
      },
      {
        name: 'idx_atleta',
        fields: ['atleta_id']
      },
      {
        name: 'idx_status',
        fields: ['status_id']
      },
      {
        name: 'unique_prof_atleta',
        unique: true,
        fields: ['profissional_id', 'atleta_id']
      }
    ]
  });

  ProfissionalAtleta.associate = function(models) {
    ProfissionalAtleta.belongsTo(models.ProfissionalTecnico, {
      foreignKey: 'profissional_id',
      as: 'profissional',
      onDelete: 'CASCADE'
    });
    
    ProfissionalAtleta.belongsTo(models.Atleta, {
      foreignKey: 'atleta_id',
      as: 'atleta',
      onDelete: 'CASCADE'
    });
    
    ProfissionalAtleta.belongsTo(models.StatusProfissionalAtleta, {
      foreignKey: 'status_id',
      as: 'status'
    });
  };

  return ProfissionalAtleta;
};
