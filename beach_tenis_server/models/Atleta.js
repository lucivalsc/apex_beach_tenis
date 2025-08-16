'use strict';

module.exports = (sequelize, DataTypes) => {
  const Atleta = sequelize.define('Atleta', {
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
    cidade: {
      type: DataTypes.STRING(100)
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
    tableName: 'atletas',
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
        name: 'idx_status',
        fields: ['status_assinatura']
      }
    ]
  });

  Atleta.associate = function(models) {
    Atleta.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario',
      onDelete: 'CASCADE'
    });
    
    // Conexões entre atletas (rede social)
    Atleta.hasMany(models.ConexaoAtleta, {
      foreignKey: 'atleta_origem_id',
      as: 'conexoesEnviadas'
    });
    
    Atleta.hasMany(models.ConexaoAtleta, {
      foreignKey: 'atleta_destino_id',
      as: 'conexoesRecebidas'
    });
    
    // Relação com profissionais técnicos
    Atleta.hasMany(models.ProfissionalAtleta, {
      foreignKey: 'atleta_id',
      as: 'profissionaisTecnicos'
    });
    
    // Participação em jogos
    Atleta.hasMany(models.JogoParticipante, {
      foreignKey: 'atleta_id',
      as: 'participacoesJogos'
    });
    
    // Jogadas em pontos
    Atleta.hasMany(models.JogoJogada, {
      foreignKey: 'atleta_id',
      as: 'jogadas'
    });
    
    // Saques em pontos
    Atleta.hasMany(models.JogoPonto, {
      foreignKey: 'atleta_sacador_id',
      as: 'saques'
    });
  };

  return Atleta;
};
