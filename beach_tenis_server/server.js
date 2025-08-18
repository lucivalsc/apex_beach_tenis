// INSTALACAO
// npm install express sequelize mysql2 dotenv joi swagger-ui-express yamljs winston winston-daily-rotate-file node-cache cors

// Executar servidor no terminal
// node server.js
// ncc build server.js -o dist

const sequelize = require('./config/database');
const initializeEnumTables = require('./utils/initializeEnumTables');

// Importar todos os modelos que representam as tabelas do esquema
const {
  Usuario, ConfiguracaoSistema, TipoAssinatura, PacotePagamento,
  Arena, Professor, Atleta, Aluno, ProfissionalTecnico,
  ArenaProfessor, ArenaAluno, ProfessorAluno, ConexaoAtleta, ProfissionalAtleta,
  Assinatura, Pagamento,
  Golpe, ItemTreino, Treino, TreinoItem, Avaliacao, AvaliacaoItem,
  Jogo, JogoParticipante, JogoSet, JogoGame, JogoPonto, JogoJogada,
  Notificacao, LogSistema,
  // Novos modelos de tipos
  TipoUsuario, TipoSexo, StatusAssinatura, TipoJogo, StatusJogo,
  StatusAvaliacao, TipoEquipe, TipoPosicao, TipoMetodoPagamento, StatusPagamento,
  StatusTreino, StatusConexaoAtleta, TipoNotificacao, TipoConfiguracao,
  DificuldadeItemTreino, TipoEquipeJogo, TipoResultadoJogada, TipoPonto,
  TipoLog, TipoPeriodicidade, StatusProfissionalAtleta, TipoEndereco,
  // Novos modelos adicionais
  Endereco, UsuarioTipo
} = require('./models/index');

// Função para verificar/criar tabelas sem alterar estrutura existente
async function syncModel(model, name) {
  try {
    console.log(`Verificando tabela ${name}...`);

    // Verificar se a tabela existe antes de tentar sincronizar
    const tableExists = await sequelize.getQueryInterface().tableExists(model.tableName);

    if (!tableExists) {
      console.log(`Criando tabela ${name}...`);
      // Criar tabela sem alterar estrutura existente - evita criação automática de índices
      await model.sync({ force: false });
      console.log(`Tabela ${name} criada com sucesso.`);
    } else {
      console.log(`Tabela ${name} já existe - pulando sincronização para evitar criação de índices desnecessários.`);
    }

    return true;
  } catch (error) {
    console.error(`Erro ao verificar/criar tabela ${name}:`, error.message);
    // Continuar mesmo com erro para tentar sincronizar as outras tabelas
    return false;
  }
}

// Verificar conexão com o banco de dados e sincronizar tabelas
sequelize.authenticate()
  .then(async () => {
    console.log('Conexão com o banco de dados estabelecida com sucesso.');

    try {
      // Primeiro, verificamos se as tabelas existem
      console.log('Verificando e criando tabelas no banco de dados...');

      // Criamos as tabelas em ordem para evitar problemas com chaves estrangeiras
      // 1. Primeiro as tabelas base sem dependências externas
      await syncModel(Usuario, 'Usuario');
      await syncModel(ConfiguracaoSistema, 'ConfiguracaoSistema');
      await syncModel(TipoAssinatura, 'TipoAssinatura');
      await syncModel(PacotePagamento, 'PacotePagamento');

      // 2. Tabelas de perfis de usuários
      await syncModel(Arena, 'Arena');
      await syncModel(Professor, 'Professor');
      await syncModel(Atleta, 'Atleta');
      await syncModel(Aluno, 'Aluno');
      await syncModel(ProfissionalTecnico, 'ProfissionalTecnico');

      // 3. Tabelas de relacionamentos entre perfis
      await syncModel(ArenaProfessor, 'ArenaProfessor');
      await syncModel(ArenaAluno, 'ArenaAluno');
      await syncModel(ProfessorAluno, 'ProfessorAluno');
      await syncModel(ConexaoAtleta, 'ConexaoAtleta');
      await syncModel(ProfissionalAtleta, 'ProfissionalAtleta');

      // 4. Tabelas de pagamentos e assinaturas
      await syncModel(Assinatura, 'Assinatura');
      await syncModel(Pagamento, 'Pagamento');

      // 5. Tabelas de treinos e avaliações
      await syncModel(Golpe, 'Golpe');
      await syncModel(ItemTreino, 'ItemTreino');
      await syncModel(Treino, 'Treino');
      await syncModel(TreinoItem, 'TreinoItem');
      await syncModel(Avaliacao, 'Avaliacao');
      await syncModel(AvaliacaoItem, 'AvaliacaoItem');

      // 6. Tabelas de jogos e partidas
      await syncModel(Jogo, 'Jogo');
      await syncModel(JogoParticipante, 'JogoParticipante');
      await syncModel(JogoSet, 'JogoSet');
      await syncModel(JogoGame, 'JogoGame');
      await syncModel(JogoPonto, 'JogoPonto');
      await syncModel(JogoJogada, 'JogoJogada');

      // 7. Tabelas de notificações e logs
      await syncModel(Notificacao, 'Notificacao');
      await syncModel(LogSistema, 'LogSistema');

      // Sincronizar as novas tabelas de tipos
      await syncModel(TipoUsuario, 'TipoUsuario');
      await syncModel(TipoSexo, 'TipoSexo');
      await syncModel(StatusAssinatura, 'StatusAssinatura');
      await syncModel(TipoJogo, 'TipoJogo');
      await syncModel(StatusJogo, 'StatusJogo');
      await syncModel(StatusAvaliacao, 'StatusAvaliacao');
      await syncModel(TipoEquipe, 'TipoEquipe');
      await syncModel(TipoPosicao, 'TipoPosicao');
      await syncModel(TipoMetodoPagamento, 'TipoMetodoPagamento');
      await syncModel(StatusPagamento, 'StatusPagamento');
      await syncModel(StatusTreino, 'StatusTreino');
      await syncModel(StatusConexaoAtleta, 'StatusConexaoAtleta');
      await syncModel(TipoNotificacao, 'TipoNotificacao');
      await syncModel(TipoConfiguracao, 'TipoConfiguracao');
      await syncModel(DificuldadeItemTreino, 'DificuldadeItemTreino');
      await syncModel(TipoEquipeJogo, 'TipoEquipeJogo');
      await syncModel(TipoResultadoJogada, 'TipoResultadoJogada');
      await syncModel(TipoPonto, 'TipoPonto');
      await syncModel(TipoLog, 'TipoLog');
      await syncModel(TipoPeriodicidade, 'TipoPeriodicidade');
      await syncModel(StatusProfissionalAtleta, 'StatusProfissionalAtleta');
      await syncModel(TipoEndereco, 'TipoEndereco');
      
      // 8. Novas tabelas adicionais que dependem das tabelas de tipos
      await syncModel(Endereco, 'Endereco');
      await syncModel(UsuarioTipo, 'UsuarioTipo');

      console.log('Todas as tabelas foram verificadas e processadas!');

      // Inicializar as tabelas de tipos com valores padrão
      await initializeEnumTables({
        TipoUsuario,
        TipoSexo,
        StatusAssinatura,
        TipoJogo,
        StatusJogo,
        TipoEndereco,
        StatusAvaliacao,
        TipoEquipe,
        TipoPosicao,
        TipoMetodoPagamento,
        StatusPagamento,
        StatusTreino,
        StatusConexaoAtleta,
        TipoNotificacao,
        TipoConfiguracao,
        DificuldadeItemTreino,
        TipoEquipeJogo,
        TipoResultadoJogada,
        TipoPonto,
        TipoLog,
        TipoPeriodicidade,
        StatusProfissionalAtleta
      });
    } catch (error) {
      console.error('Erro ao sincronizar tabelas:', error);
      // Não propagar o erro para permitir que o servidor inicie mesmo com problemas de sincronização
    }
  })
  .catch(error => {
    console.error('Erro ao conectar com o banco de dados:', error);
  });

const express = require('express');
const cors = require('cors');
const { errorHandler } = require('./middleware/errorMiddleware');
const usuarioRoutes = require('./routes/usuarioRoute');
const dbmRoutes = require('./routes/dbmRoute');
const processarJsonRoutes = require('./routes/processar_json');

const app = express();

// Middleware CORS
app.use(cors());

// Middleware para processar JSON
app.use(express.json({ limit: '50mb' }));
app.use(express.urlencoded({ extended: true, limit: '50mb' }));

// Middleware para processar erros de JSON malformado
app.use((err, req, res, next) => {
  if (err instanceof SyntaxError && err.status === 400 && 'body' in err) {
    console.warn('JSON inválido na requisição', {
      error: err.message,
      method: req.method,
      url: req.originalUrl,
      ip: req.ip
    });

    return res.status(400).json({
      success: false,
      error: {
        code: 'INVALID_JSON',
        message: 'JSON inválido na requisição',
        details: err.message,
        timestamp: new Date().toISOString()
      },
      failure: true
    });
  }
  next(err);
});

// Rotas da API
app.use('/auth', usuarioRoutes); // Rota para usuário
app.use('/api', dbmRoutes); // Rota para gerenciamento de dados (DBM)
app.use('/api', processarJsonRoutes); // Rota para processamento de JSON

// Rota de status da API
app.get('/api/status', (req, res) => {
  res.json({
    status: 'online',
    version: '1.0.0',
    timestamp: new Date().toISOString()
  });
});

// Definir a porta e iniciar o servidor
const PORT = 21003;

// Middleware para tratar rotas não encontradas (404)
app.use((req, res) => {
  res.status(404).json({
    success: false,
    error: {
      code: 'NOT_FOUND',
      message: 'Rota não encontrada',
      timestamp: new Date().toISOString()
    }
  });
});

// Middleware para tratamento global de erros
app.use(errorHandler);

app.listen(PORT, () => {
  console.log(`Servidor rodando na porta ${PORT}`);
});
