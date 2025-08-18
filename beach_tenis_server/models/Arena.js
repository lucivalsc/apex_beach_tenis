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
    status_assinatura_id: {
      type: DataTypes.INTEGER,
      allowNull: false,
      references: {
        model: 'status_assinaturas',
        key: 'id'
      }
    },
    data_vencimento: {
      type: DataTypes.DATEONLY
    }
  }, {
    tableName: 'arenas',
    timestamps: true,
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
    indexes: [
      {
        name: 'idx_cnpj',
        fields: ['cnpj']
      },
      {
        name: 'idx_status_assinatura',
        fields: ['status_assinatura_id']
      }
    ]
  });

  Arena.associate = function(models) {
    Arena.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario',
      onDelete: 'CASCADE'
    });
    
    Arena.belongsTo(models.StatusAssinatura, {
      foreignKey: 'status_assinatura_id',
      as: 'statusAssinatura'
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
