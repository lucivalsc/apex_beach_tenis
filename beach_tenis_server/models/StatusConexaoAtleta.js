'use strict';

module.exports = (sequelize, DataTypes) => {
  const StatusConexaoAtleta = sequelize.define('StatusConexaoAtleta', {
    id: {
      type: DataTypes.INTEGER,
      primaryKey: true,
      autoIncrement: true
    },
    nome: {
      type: DataTypes.STRING(50),
      allowNull: false
    },
    codigo: {
      type: DataTypes.STRING(20),
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
    tableName: 'status_conexao_atleta',
    timestamps: true,
    createdAt: 'created_at',
    updatedAt: 'updated_at',
    indexes: [
      {
        name: 'idx_codigo',
        fields: ['codigo'],
        unique: true
      }
    ]
  });

  // Método estático para inserir valores padrão
  StatusConexaoAtleta.insertDefaultValues = async function() {
    try {
      const statusValues = [
        { nome: 'Pendente', codigo: 'PENDENTE', descricao: 'Solicitação de conexão pendente de aprovação', ativo: true },
        { nome: 'Aceito', codigo: 'ACEITO', descricao: 'Solicitação de conexão aceita', ativo: true },
        { nome: 'Bloqueado', codigo: 'BLOQUEADO', descricao: 'Conexão bloqueada', ativo: true }
      ];

      // Verifica se já existem registros
      const count = await this.count();
      if (count === 0) {
        // Insere os valores padrão
        for (const status of statusValues) {
          await this.create(status);
        }
        console.log('Valores padrão inseridos em StatusConexaoAtleta');
      } else {
        console.log('StatusConexaoAtleta já possui registros, pulando inserção de valores padrão');
      }
    } catch (error) {
      console.error('Erro ao inserir valores padrão em StatusConexaoAtleta:', error);
      throw error;
    }
  };

  return StatusConexaoAtleta;
};
