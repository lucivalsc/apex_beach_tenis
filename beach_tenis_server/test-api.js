/**
 * Script de teste para validar a API Beach Tênis
 * 
 * Este script testa as principais funcionalidades da API:
 * - Registro de usuário
 * - Login
 * - Refresh token
 * - Logout
 * - CRUD de arenas
 * - CRUD de jogos
 * - CRUD de treinamentos
 * - Status da API
 */

const axios = require('axios');
const crypto = require('crypto');
const { v4: uuidv4 } = require('uuid');

// Configuração
const API_URL = 'http://localhost:21012/api';
const AUTH_URL = 'http://localhost:21012/auth';
let authToken = null;
let refreshToken = null;
let userId = null;
let arenaId = null;
let gameId = null;
let trainingId = null;

// Cores para console
const colors = {
  reset: '\x1b[0m',
  green: '\x1b[32m',
  red: '\x1b[31m',
  yellow: '\x1b[33m',
  blue: '\x1b[34m'
};

// Função para gerar hash SHA-256 em base64
const hashPassword = (password) => {
  const hash = crypto.createHash('sha256');
  hash.update(password);
  return hash.digest('base64');
};

// Função para exibir resultado do teste
const logResult = (testName, success, message = '') => {
  const status = success ? `${colors.green}PASSOU${colors.reset}` : `${colors.red}FALHOU${colors.reset}`;
  console.log(`[${status}] ${testName}${message ? ': ' + message : ''}`);
  return success;
};

// Função para fazer requisições com tratamento de erro
const apiRequest = async (method, endpoint, data = null, auth = false, isAuth = false) => {
  try {
    const headers = auth && authToken ? { Authorization: `Bearer ${authToken}` } : {};
    const url = isAuth ? `${AUTH_URL}${endpoint}` : `${API_URL}${endpoint}`;
    
    console.log(`${colors.blue}Requisição ${method.toUpperCase()}${colors.reset} para ${url}`);
    
    const response = await axios({
      method,
      url,
      data,
      headers
    });
    
    return { success: true, data: response.data, status: response.status };
  } catch (error) {
    const status = error.response?.status || 500;
    const data = error.response?.data || { message: error.message };
    return { success: false, data, status };
  }
};

// Teste 1: Verificar status da API
const testApiStatus = async () => {
  console.log(`\n${colors.yellow}=== Teste de Status da API ===${colors.reset}`);
  
  const response = await apiRequest('get', '/status');
  return logResult('Status da API', response.success && response.data.status === 'online');
};

// Teste 2: Registrar um novo usuário
const testRegisterUser = async () => {
  console.log(`\n${colors.yellow}=== Teste de Registro de Usuário ===${colors.reset}`);
  
  const userData = {
    id: uuidv4(),
    name: 'Usuário Teste',
    email: `teste_${Date.now()}@example.com`,
    password: 'Senha@123',
    passwordConfirm: 'Senha@123',
    phone: '11999999999',
    birthDate: '1990-01-01',
    gender: 'M',
    userType: 1, // Jogador
    status: 1
  };
  
  const response = await apiRequest('post', '/register', userData, false, true);
  
  if (response.success) {
    userId = response.data.id;
  }
  
  return logResult('Registro de usuário', response.success, response.success ? `ID: ${userId}` : response.data.message);
};

// Teste 3: Login com o usuário criado
const testLogin = async () => {
  console.log(`\n${colors.yellow}=== Teste de Login ===${colors.reset}`);
  
  const loginData = {
    email: `teste_${Date.now()}@example.com`,
    password: 'Senha@123'
  };
  
  const response = await apiRequest('post', '/login', loginData, false, true);
  
  if (response.success) {
    authToken = response.data.accessToken;
    refreshToken = response.data.refreshToken;
  }
  
  return logResult('Login', response.success && authToken !== null, response.success ? 'Token obtido com sucesso' : response.data.message);
};

// Teste 4: Refresh token
const testRefreshToken = async () => {
  console.log(`\n${colors.yellow}=== Teste de Refresh Token ===${colors.reset}`);
  
  if (!refreshToken) {
    return logResult('Refresh token', false, 'Refresh token não disponível');
  }
  
  const response = await apiRequest('post', '/refresh-token', { refreshToken }, false, true);
  
  if (response.success) {
    const oldToken = authToken;
    authToken = response.data.accessToken;
    refreshToken = response.data.refreshToken;
    
    return logResult('Refresh token', response.success && oldToken !== authToken, 'Novo token obtido com sucesso');
  }
  
  return logResult('Refresh token', false, response.data.message);
};

// Teste 5: Criar uma arena
const testCreateArena = async () => {
  console.log(`\n${colors.yellow}=== Teste de Criação de Arena ===${colors.reset}`);
  
  if (!authToken) {
    return logResult('Criar arena', false, 'Token não disponível');
  }
  
  const arenaData = {
    id: uuidv4(),
    name: `Arena Teste ${Date.now()}`,
    address: 'Rua de Teste, 123',
    phone: '11988888888',
    email: `arena_${Date.now()}@example.com`,
    status: 1
  };
  
  const response = await apiRequest('post', '/arena', arenaData, true);
  
  if (response.success) {
    arenaId = response.data.id || arenaData.id;
  }
  
  return logResult('Criar arena', response.success, response.success ? `ID: ${arenaId}` : response.data.message);
};

// Teste 6: Obter arena criada
const testGetArena = async () => {
  console.log(`\n${colors.yellow}=== Teste de Obtenção de Arena ===${colors.reset}`);
  
  if (!authToken || !arenaId) {
    return logResult('Obter arena', false, 'Token ou ID da arena não disponível');
  }
  
  const response = await apiRequest('get', `/arena/${arenaId}`, null, true);
  
  return logResult('Obter arena', response.success && response.data.id === arenaId);
};

// Teste 7: Criar um jogo
const testCreateGame = async () => {
  console.log(`\n${colors.yellow}=== Teste de Criação de Jogo ===${colors.reset}`);
  
  if (!authToken || !arenaId) {
    return logResult('Criar jogo', false, 'Token ou ID da arena não disponível');
  }
  
  const tomorrow = new Date();
  tomorrow.setDate(tomorrow.getDate() + 1);
  
  const gameData = {
    id: uuidv4(),
    title: `Jogo Teste ${Date.now()}`,
    description: 'Descrição do jogo de teste',
    gameDate: tomorrow.toISOString().split('T')[0],
    startTime: '18:00',
    endTime: '20:00',
    arenaId: arenaId,
    status: 1
  };
  
  const response = await apiRequest('post', '/game', gameData, true);
  
  if (response.success) {
    gameId = response.data.id || gameData.id;
  }
  
  return logResult('Criar jogo', response.success, response.success ? `ID: ${gameId}` : response.data.message);
};

// Teste 8: Obter jogo criado
const testGetGame = async () => {
  console.log(`\n${colors.yellow}=== Teste de Obtenção de Jogo ===${colors.reset}`);
  
  if (!authToken || !gameId) {
    return logResult('Obter jogo', false, 'Token ou ID do jogo não disponível');
  }
  
  const response = await apiRequest('get', `/game/${gameId}`, null, true);
  
  return logResult('Obter jogo', response.success && response.data.id === gameId);
};

// Teste 9: Criar um treinamento
const testCreateTraining = async () => {
  console.log(`\n${colors.yellow}=== Teste de Criação de Treinamento ===${colors.reset}`);
  
  if (!authToken || !arenaId) {
    return logResult('Criar treinamento', false, 'Token ou ID da arena não disponível');
  }
  
  const nextWeek = new Date();
  nextWeek.setDate(nextWeek.getDate() + 7);
  
  const trainingData = {
    id: uuidv4(),
    title: `Treinamento Teste ${Date.now()}`,
    description: 'Descrição do treinamento de teste',
    trainingDate: nextWeek.toISOString().split('T')[0],
    startTime: '09:00',
    endTime: '11:00',
    arenaId: arenaId,
    status: 1
  };
  
  const response = await apiRequest('post', '/training', trainingData, true);
  
  if (response.success) {
    trainingId = response.data.id || trainingData.id;
  }
  
  return logResult('Criar treinamento', response.success, response.success ? `ID: ${trainingId}` : response.data.message);
};

// Teste 10: Obter treinamento criado
const testGetTraining = async () => {
  console.log(`\n${colors.yellow}=== Teste de Obtenção de Treinamento ===${colors.reset}`);
  
  if (!authToken || !trainingId) {
    return logResult('Obter treinamento', false, 'Token ou ID do treinamento não disponível');
  }
  
  const response = await apiRequest('get', `/training/${trainingId}`, null, true);
  
  return logResult('Obter treinamento', response.success && response.data.id === trainingId);
};

// Teste 11: Logout
const testLogout = async () => {
  console.log(`\n${colors.yellow}=== Teste de Logout ===${colors.reset}`);
  
  if (!authToken) {
    return logResult('Logout', false, 'Token não disponível');
  }
  
  const response = await apiRequest('post', '/logout', null, true, true);
  
  // Após o logout, o token deve ser invalidado
  const testInvalidToken = await apiRequest('get', '/user/profile', null, true, true);
  const tokenInvalidado = !testInvalidToken.success && testInvalidToken.status === 403;
  
  return logResult('Logout', response.success && tokenInvalidado);
};

// Função principal para executar todos os testes
const runAllTests = async () => {
  console.log(`${colors.yellow}=== Iniciando testes da API Beach Tênis ===${colors.reset}`);
  console.log(`Data e hora: ${new Date().toLocaleString()}`);
  console.log(`API URL: ${API_URL}`);
  
  const results = [];
  
  // Executar testes em sequência
  results.push(await testApiStatus());
  results.push(await testRegisterUser());
  results.push(await testLogin());
  results.push(await testRefreshToken());
  results.push(await testCreateArena());
  results.push(await testGetArena());
  results.push(await testCreateGame());
  results.push(await testGetGame());
  results.push(await testCreateTraining());
  results.push(await testGetTraining());
  results.push(await testLogout());
  
  // Resumo dos resultados
  const totalTests = results.length;
  const passedTests = results.filter(result => result).length;
  const failedTests = totalTests - passedTests;
  
  console.log(`\n${colors.yellow}=== Resumo dos Testes ===${colors.reset}`);
  console.log(`Total de testes: ${totalTests}`);
  console.log(`Testes bem-sucedidos: ${colors.green}${passedTests}${colors.reset}`);
  console.log(`Testes falhos: ${failedTests > 0 ? colors.red + failedTests + colors.reset : failedTests}`);
  console.log(`Taxa de sucesso: ${Math.round((passedTests / totalTests) * 100)}%`);
  
  if (failedTests === 0) {
    console.log(`\n${colors.green}Todos os testes foram bem-sucedidos!${colors.reset}`);
  } else {
    console.log(`\n${colors.red}Alguns testes falharam. Verifique os logs acima para mais detalhes.${colors.reset}`);
  }
};

// Executar todos os testes
runAllTests().catch(error => {
  console.error(`${colors.red}Erro ao executar testes:${colors.reset}`, error);
});
