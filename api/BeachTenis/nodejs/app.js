const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const { initializeDatabase } = require('./config/database');
const customUnauthorizedMiddleware = require('./middleware/customUnauthorizedMiddleware');
require('dotenv').config();

// Importa as rotas
const userRoutes = require('./routes/userRoutes');
const arenaRoutes = require('./routes/arenaRoutes');
const gameRoutes = require('./routes/gameRoutes');
const trainingRoutes = require('./routes/trainingRoutes');

// Cria a aplicação Express
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(cors());
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

// Middleware personalizado para tratamento de erros de autenticação
app.use(customUnauthorizedMiddleware);

// Middleware para logging
app.use((req, res, next) => {
  console.log(`${new Date().toISOString()} - ${req.method} ${req.url}`);
  next();
});

// Rotas
app.use('/api/user', userRoutes);
app.use('/api/arena', arenaRoutes);
app.use('/api/game', gameRoutes);
app.use('/api/training', trainingRoutes);

// Rota raiz
app.get('/', (req, res) => {
  res.json({
    message: 'Beach Tênis API',
    version: '1.0.0',
    endpoints: [
      '/api/user',
      '/api/arena',
      '/api/game',
      '/api/training'
    ]
  });
});

// Middleware para tratamento de erros
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).json({
    message: 'Ocorreu um erro interno no servidor.',
    error: process.env.NODE_ENV === 'development' ? err.message : undefined
  });
});

// Rota para verificar o status da API
app.get('/api/status', (req, res) => {
  res.json({
    status: 'online',
    timestamp: new Date().toISOString(),
    environment: process.env.NODE_ENV || 'development'
  });
});

// Inicializa o banco de dados e inicia o servidor
const startServer = async () => {
  try {
    // Inicializa o banco de dados
    await initializeDatabase();
    
    // Inicia o servidor
    app.listen(PORT, () => {
      console.log(`Servidor rodando na porta ${PORT}`);
    });
  } catch (error) {
    console.error('Erro ao iniciar o servidor:', error);
    process.exit(1);
  }
};

startServer();
