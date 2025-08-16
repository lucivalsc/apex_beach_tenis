'use strict';

module.exports = (sequelize, DataTypes) => {
  const ProfissionalTecnico = sequelize.define('ProfissionalTecnico', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    usuario_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      unique: true,
      references: {
        model: 'usuarios',
        key: 'id'
      }
    },
    nome: {
      type: DataTypes.STRING(255),
      allowNull: false
    },
    cpf: {
      type: DataTypes.STRING(14),
      unique: true
    },
    data_nascimento: {
      type: DataTypes.DATEONLY
    },
    sexo: {
      type: DataTypes.ENUM('MASCULINO', 'FEMININO', 'OUTRO')
    },
    telefone: {
      type: DataTypes.STRING(20)
    },
    whatsapp: {
      type: DataTypes.BOOLEAN,
      defaultValue: false
    },
    instagram: {
      type: DataTypes.STRING(100)
    },
    facebook: {
      type: DataTypes.STRING(100)
    },
    especialidades: {
      type: DataTypes.JSON
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
    tableName: 'profissionais_tecnicos',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_cpf',
        fields: ['cpf']
      },
      {
        name: 'idx_nome',
        fields: ['nome']
      },
      {
        name: 'idx_ativo',
        fields: ['ativo']
      }
    ]
  });

  ProfissionalTecnico.associate = function(models) {
    ProfissionalTecnico.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario',
      onDelete: 'CASCADE'
    });
    
    // Relação com atletas
    ProfissionalTecnico.hasMany(models.ProfissionalAtleta, {
      foreignKey: 'profissional_id',
      as: 'atletasVinculados'
    });
    
    // Jogos analisados
    ProfissionalTecnico.hasMany(models.Jogo, {
      foreignKey: 'profissional_tecnico_id',
      as: 'jogosAnalisados'
    });
  };

  return ProfissionalTecnico;
};
