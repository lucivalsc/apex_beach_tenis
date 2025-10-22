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
    tipo_sexo_id: {
      type: DataTypes.INTEGER,
      references: {
        model: 'tipos_sexo',
        key: 'id'
      }
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
    status_assinatura_id: {
      type: DataTypes.INTEGER,
      references: {
        model: 'status_assinaturas',
        key: 'id'
      }
    },
    data_vencimento: {
      type: DataTypes.DATEONLY
    }
  }, {
    tableName: 'atletas',
    timestamps: true,
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
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
        name: 'idx_status_assinatura',
        fields: ['status_assinatura_id']
      },
      {
        name: 'idx_tipo_sexo',
        fields: ['tipo_sexo_id']
      }
    ]
  });

  Atleta.associate = function(models) {
    Atleta.belongsTo(models.Usuario, {
      foreignKey: 'usuario_id',
      as: 'usuario',
      onDelete: 'CASCADE'
    });
    
    Atleta.belongsTo(models.TipoSexo, {
      foreignKey: 'tipo_sexo_id',
      as: 'tipoSexo'
    });
    
    Atleta.belongsTo(models.StatusAssinatura, {
      foreignKey: 'status_assinatura_id',
      as: 'statusAssinatura'
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
