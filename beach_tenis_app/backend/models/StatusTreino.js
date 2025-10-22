'use strict';

module.exports = (sequelize, DataTypes) => {
  const StatusTreino = sequelize.define('StatusTreino', {
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
    createdAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    },
    updatedAt: {
      type: DataTypes.DATE,
      defaultValue: DataTypes.NOW
    }
  }, {
    tableName: 'status_treino',
    timestamps: true,
    createdAt: 'createdAt',
    updatedAt: 'updatedAt',
    indexes: [
      {
        name: 'idx_codigo',
        fields: ['codigo'],
        unique: true
      }
    ]
  });

  // Método estático para inserir valores padrão
  StatusTreino.insertDefaultValues = async function() {
    try {
      const statusValues = [
        { nome: 'Agendado', codigo: 'AGENDADO', descricao: 'Treino agendado e ainda não realizado', ativo: true },
        { nome: 'Realizado', codigo: 'REALIZADO', descricao: 'Treino já realizado', ativo: true },
        { nome: 'Cancelado', codigo: 'CANCELADO', descricao: 'Treino cancelado', ativo: true }
      ];

      // Verifica se já existem registros
      const count = await this.count();
      if (count === 0) {
        // Insere os valores padrão
        for (const status of statusValues) {
          await this.create(status);
        }
        console.log('Valores padrão inseridos em StatusTreino');
      } else {
        console.log('StatusTreino já possui registros, pulando inserção de valores padrão');
      }
    } catch (error) {
      console.error('Erro ao inserir valores padrão em StatusTreino:', error);
      throw error;
    }
  };

  return StatusTreino;
};
