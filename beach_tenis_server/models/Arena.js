'use strict';

module.exports = (sequelize, DataTypes) => {
  const Arena = sequelize.define('Arena', {
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
    cnpj: {
      type: DataTypes.STRING(18),
      unique: true
    },
    endereco: {
      type: DataTypes.TEXT
    },
    latitude: {
      type: DataTypes.DECIMAL(10, 8),
      allowNull: true
    },
    longitude: {
      type: DataTypes.DECIMAL(11, 8),
      allowNull: true
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
    status_assinatura: {
      type: DataTypes.ENUM('ATIVO', 'INATIVO', 'SUSPENSO', 'CANCELADO'),
      defaultValue: 'ATIVO'
    },
    data_vencimento: {
      type: DataTypes.DATEONLY
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
    tableName: 'arenas',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_cnpj',
        fields: ['cnpj']
      },
      {
        name: 'idx_status',
        fields: ['status_assinatura']
      }
    ]
  });

  Arena.associate = function(models) {
    Arena.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario',
      onDelete: 'CASCADE'
    });
    
    Arena.hasMany(models.ArenaProfessor, {
      foreignKey: 'arena_id',
      as: 'arenaProfessores'
    });
    
    Arena.hasMany(models.ArenaAluno, {
      foreignKey: 'arena_id',
      as: 'arenaAlunos'
    });
    
    Arena.hasMany(models.Treino, {
      foreignKey: 'arena_id',
      as: 'treinos'
    });
    
    Arena.hasMany(models.Avaliacao, {
      foreignKey: 'arena_id',
      as: 'avaliacoes'
    });
    
    Arena.hasMany(models.Jogo, {
      foreignKey: 'arena_id',
      as: 'jogos'
    });
  };

  return Arena;
};
