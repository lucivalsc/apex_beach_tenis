'use strict';

module.exports = (sequelize, DataTypes) => {
  const TipoNotificacao = sequelize.define('TipoNotificacao', {
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
    tableName: 'tipo_notificacao',
    timestamps: true,
    createdAt: 'created_at',
    updated_at: 'updated_at',
    indexes: [
      {
        name: 'idx_codigo',
        fields: ['codigo'],
        unique: true
      }
    ]
  });

  // Método estático para inserir valores padrão
  TipoNotificacao.insertDefaultValues = async function() {
    try {
      const tipoValues = [
        { nome: 'Sistema', codigo: 'SISTEMA', descricao: 'Notificação do sistema', ativo: true },
        { nome: 'Treino', codigo: 'TREINO', descricao: 'Notificação relacionada a treinos', ativo: true },
        { nome: 'Avaliação', codigo: 'AVALIACAO', descricao: 'Notificação relacionada a avaliações', ativo: true },
        { nome: 'Jogo', codigo: 'JOGO', descricao: 'Notificação relacionada a jogos', ativo: true },
        { nome: 'Pagamento', codigo: 'PAGAMENTO', descricao: 'Notificação relacionada a pagamentos', ativo: true },
        { nome: 'Conexão', codigo: 'CONEXAO', descricao: 'Notificação relacionada a conexões entre atletas', ativo: true },
        { nome: 'Outro', codigo: 'OUTRO', descricao: 'Outros tipos de notificação', ativo: true }
      ];

      // Verifica se já existem registros
      const count = await this.count();
      if (count === 0) {
        // Insere os valores padrão
        for (const tipo of tipoValues) {
          await this.create(tipo);
        }
        console.log('Valores padrão inseridos em TipoNotificacao');
      } else {
        console.log('TipoNotificacao já possui registros, pulando inserção de valores padrão');
      }
    } catch (error) {
      console.error('Erro ao inserir valores padrão em TipoNotificacao:', error);
      throw error;
    }
  };

  return TipoNotificacao;
};
