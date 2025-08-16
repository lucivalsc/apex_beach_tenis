const express = require('express');
const router = express.Router();
const { v4: uuidv4 } = require('uuid');
const { query } = require('../config/database');
const { User } = require('../models/user');
const LoginModel = require('../models/loginModel');
const LoginSocialModel = require('../models/loginSocialModel');
const TokenModel = require('../models/tokenModel');
const jwt = require('jsonwebtoken');
const crypto = require('crypto');
const { authenticateToken } = require('../middleware/authMiddleware');

// Armazenamento de tokens inválidos (para logout)
const invalidatedTokens = new Set();

// Gerar token JWT
const generateToken = (user) => {
  return jwt.sign(
    { id: user.id, email: user.email, userType: user.userType }, 
    process.env.JWT_SECRET || 'beach_tenis_secret_key', 
    { expiresIn: '24h' }
  );
};

// Gerar refresh token
const generateRefreshToken = () => {
  return crypto.randomBytes(40).toString('hex');
};

/**
 * @route GET /api/user
 * @desc Consulta todos os usuários
 * @access Privado
 */
router.get('/', authenticateToken, async (req, res) => {
  try {
    const users = await query('SELECT * FROM users WHERE status = 1');
    
    // Remove senha dos resultados
    const usersWithoutPassword = users.map(user => {
      const { password, ...userWithoutPassword } = user;
      return userWithoutPassword;
    });
    
    res.json(usersWithoutPassword);
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao listar os usuários.' });
  }
});

/**
 * @route GET /api/user/:userId
 * @desc Consulta usuário por ID
 * @access Privado
 */
router.get('/:userId', authenticateToken, async (req, res) => {
  try {
    const [user] = await query('SELECT * FROM users WHERE id = ? AND status = 1', [req.params.userId]);
    
    if (!user) {
      return res.status(404).json({ message: 'Usuário não encontrado.' });
    }
    
    // Remove senha do resultado
    const { password, ...userWithoutPassword } = user;
    
    res.json(userWithoutPassword);
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao buscar o usuário.' });
  }
});

/**
 * @route POST /api/user/create
 * @desc Cria um novo usuário
 * @access Público
 */
router.post('/create', async (req, res) => {
  try {
    const userData = req.body;
    
    // Verifica se o email já existe
    const [existingUser] = await query('SELECT * FROM users WHERE email = ?', [userData.email]);
    const userExiste = existingUser !== undefined;
    
    // Cria uma instância do modelo User
    const user = new User();
    Object.assign(user, userData);
    
    // Valida o modelo
    const validation = user.isModelValid(userExiste);
    if (!validation.valid) {
      return res.status(400).json({ message: validation.erro });
    }
    
    // Criptografa a senha
    user.encryptPassword();
    
    // Gera um ID único
    user.id = uuidv4();
    
    // Insere o usuário no banco de dados
    await query(
      `INSERT INTO users (
        id, name, birthDate, sex, email, cpf, rg, telephone, yesWhatsapp, 
        photograph, idArena, instagram, facebook, address, idProfessional, 
        userType, provider, idUserProvider, photoUrlProvider, password, 
        creationDate, changeDate, status
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW(), ?)`,
      [
        user.id, user.name, user.birthDate, user.sex, user.email, user.cpf, user.rg, 
        user.telephone, user.yesWhatsapp, user.photograph, user.idArena, user.instagram, 
        user.facebook, user.address, user.idProfessional, user.userType, user.provider, 
        user.idUserProvider, user.photoUrlProvider, user.password, user.status
      ]
    );
    
    // Remove senha do resultado
    const { password, ...userWithoutPassword } = user;
    
    res.status(201).json({ 
      message: 'Usuário criado com sucesso.', 
      user: userWithoutPassword 
    });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao criar o usuário.' });
  }
});

/**
 * @route POST /api/user/create/facebook
 * @desc Cria um novo usuário com Facebook
 * @access Público
 */
router.post('/create/facebook', async (req, res) => {
  try {
    const userData = req.body;
    
    // Verifica se o email já existe
    const [existingUser] = await query('SELECT * FROM users WHERE email = ?', [userData.email]);
    const userExiste = existingUser !== undefined;
    
    // Cria uma instância do modelo User
    const user = new User();
    Object.assign(user, userData);
    
    // Define o provedor como Facebook
    user.setProvider(2); // 2 = Facebook
    
    // Valida o modelo
    const validation = user.isModelValid(userExiste, 2);
    if (!validation.valid) {
      return res.status(400).json({ message: validation.erro });
    }
    
    // Gera um ID único
    user.id = uuidv4();
    
    // Insere o usuário no banco de dados
    await query(
      `INSERT INTO users (
        id, name, birthDate, sex, email, cpf, rg, telephone, yesWhatsapp, 
        photograph, idArena, instagram, facebook, address, idProfessional, 
        userType, provider, idUserProvider, photoUrlProvider, password, 
        creationDate, changeDate, status
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW(), ?)`,
      [
        user.id, user.name, user.birthDate, user.sex, user.email, user.cpf, user.rg, 
        user.telephone, user.yesWhatsapp, user.photograph, user.idArena, user.instagram, 
        user.facebook, user.address, user.idProfessional, user.userType, user.provider, 
        user.idUserProvider, user.photoUrlProvider, user.password, user.status
      ]
    );
    
    // Remove senha do resultado
    const { password, ...userWithoutPassword } = user;
    
    res.status(201).json({ 
      message: 'Usuário criado com sucesso.', 
      user: userWithoutPassword 
    });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao criar o usuário.' });
  }
});

/**
 * @route POST /api/user/create/google
 * @desc Cria um novo usuário com Google
 * @access Público
 */
router.post('/create/google', async (req, res) => {
  try {
    const userData = req.body;
    
    // Verifica se o email já existe
    const [existingUser] = await query('SELECT * FROM users WHERE email = ?', [userData.email]);
    const userExiste = existingUser !== undefined;
    
    // Cria uma instância do modelo User
    const user = new User();
    Object.assign(user, userData);
    
    // Define o provedor como Google
    user.setProvider(1); // 1 = Google
    
    // Valida o modelo
    const validation = user.isModelValid(userExiste, 1);
    if (!validation.valid) {
      return res.status(400).json({ message: validation.erro });
    }
    
    // Gera um ID único
    user.id = uuidv4();
    
    // Insere o usuário no banco de dados
    await query(
      `INSERT INTO users (
        id, name, birthDate, sex, email, cpf, rg, telephone, yesWhatsapp, 
        photograph, idArena, instagram, facebook, address, idProfessional, 
        userType, provider, idUserProvider, photoUrlProvider, password, 
        creationDate, changeDate, status
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW(), ?)`,
      [
        user.id, user.name, user.birthDate, user.sex, user.email, user.cpf, user.rg, 
        user.telephone, user.yesWhatsapp, user.photograph, user.idArena, user.instagram, 
        user.facebook, user.address, user.idProfessional, user.userType, user.provider, 
        user.idUserProvider, user.photoUrlProvider, user.password, user.status
      ]
    );
    
    // Remove senha do resultado
    const { password, ...userWithoutPassword } = user;
    
    res.status(201).json({ 
      message: 'Usuário criado com sucesso.', 
      user: userWithoutPassword 
    });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao criar o usuário.' });
  }
});

/**
 * @route PUT /api/user/:userId
 * @desc Atualiza um usuário
 * @access Privado
 */
router.put('/:userId', authenticateToken, async (req, res) => {
  try {
    const userId = req.params.userId;
    const userData = req.body;
    
    // Verifica se o usuário existe
    const [existingUser] = await query('SELECT * FROM users WHERE id = ?', [userId]);
    
    if (!existingUser) {
      return res.status(404).json({ message: 'Usuário não encontrado.' });
    }
    
    // Cria uma instância do modelo User
    const user = new User();
    Object.assign(user, { ...existingUser, ...userData });
    
    // Valida o modelo
    const validation = user.isModelValid(false, user.provider);
    if (!validation.valid) {
      return res.status(400).json({ message: validation.erro });
    }
    
    // Atualiza a data de alteração
    user.alterChangeDate();
    
    // Atualiza o usuário no banco de dados
    await query(
      `UPDATE users SET 
        name = ?, birthDate = ?, sex = ?, email = ?, cpf = ?, rg = ?, 
        telephone = ?, yesWhatsapp = ?, photograph = ?, idArena = ?, 
        instagram = ?, facebook = ?, address = ?, idProfessional = ?, 
        userType = ?, provider = ?, idUserProvider = ?, photoUrlProvider = ?, 
        password = ?, changeDate = NOW(), status = ?
      WHERE id = ?`,
      [
        user.name, user.birthDate, user.sex, user.email, user.cpf, user.rg, 
        user.telephone, user.yesWhatsapp, user.photograph, user.idArena, 
        user.instagram, user.facebook, user.address, user.idProfessional, 
        user.userType, user.provider, user.idUserProvider, user.photoUrlProvider, 
        user.password, user.status, userId
      ]
    );
    
    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao atualizar o usuário.' });
  }
});

/**
 * @route DELETE /api/user/:userId
 * @desc Desativa um usuário
 * @access Privado
 */
router.delete('/:userId', authenticateToken, async (req, res) => {
  try {
    const userId = req.params.userId;
    
    // Verifica se o usuário existe
    const [existingUser] = await query('SELECT * FROM users WHERE id = ?', [userId]);
    
    if (!existingUser) {
      return res.status(404).json({ message: 'Usuário não encontrado.' });
    }
    
    // Desativa o usuário (altera o status para 2 = Desativado)
    await query(
      'UPDATE users SET status = 2, changeDate = NOW() WHERE id = ?',
      [userId]
    );
    
    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao desativar o usuário.' });
  }
});

/**
 * @route POST /api/user/login
 * @desc Autentica um usuário
 * @access Público
 */
router.post('/login', async (req, res) => {
  try {
    // Cria e valida o modelo de login
    const loginModel = new LoginModel();
    loginModel.email = req.body.email;
    loginModel.password = req.body.password;
    
    const validation = loginModel.isValid();
    if (!validation.valid) {
      return res.status(400).json({ message: validation.message });
    }
    
    // Criptografa a senha para comparação
    loginModel.encryptPassword();
    
    // Busca o usuário pelo email
    const [user] = await query('SELECT * FROM users WHERE email = ? AND status = 1', [loginModel.email]);
    
    if (!user) {
      return res.status(401).json({ message: 'Usuário ou senha inválidos.' });
    }
    
    // Verifica se a senha está correta
    if (user.password !== loginModel.password) {
      return res.status(401).json({ message: 'Usuário ou senha inválidos.' });
    }
    
    // Gera o token JWT
    const token = generateToken(user);
    const refreshToken = generateRefreshToken();
    
    res.json({
      token,
      refreshToken,
      expiresIn: '24h'
    });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao processar a solicitação de login.' });
  }
});

/**
 * @route POST /api/user/login/google
 * @desc Autentica um usuário com Google
 * @access Público
 */
router.post('/login/google', async (req, res) => {
  try {
    // Cria e valida o modelo de login social
    const loginSocialModel = new LoginSocialModel();
    loginSocialModel.email = req.body.email;
    loginSocialModel.idProvider = req.body.idProvider;
    
    const validation = loginSocialModel.isValid();
    if (!validation.valid) {
      return res.status(400).json({ message: validation.message });
    }
    
    // Busca o usuário pelo email e provedor
    const [user] = await query(
      'SELECT * FROM users WHERE email = ? AND provider = 1 AND idUserProvider = ? AND status = 1', 
      [loginSocialModel.email, loginSocialModel.idProvider]
    );
    
    if (!user) {
      return res.status(401).json({ message: 'Usuário inválido.' });
    }
    
    // Gera o token JWT
    const token = generateToken(user);
    const refreshToken = generateRefreshToken();
    
    res.json({
      token,
      refreshToken,
      expiresIn: '24h'
    });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao processar a solicitação de login.' });
  }
});

/**
 * @route POST /api/user/login/facebook
 * @desc Autentica um usuário com Facebook
 * @access Público
 */
router.post('/login/facebook', async (req, res) => {
  try {
    // Cria e valida o modelo de login social
    const loginSocialModel = new LoginSocialModel();
    loginSocialModel.email = req.body.email;
    loginSocialModel.idProvider = req.body.idProvider;
    
    const validation = loginSocialModel.isValid();
    if (!validation.valid) {
      return res.status(400).json({ message: validation.message });
    }
    
    // Busca o usuário pelo email e provedor
    const [user] = await query(
      'SELECT * FROM users WHERE email = ? AND provider = 2 AND idUserProvider = ? AND status = 1', 
      [loginSocialModel.email, loginSocialModel.idProvider]
    );
    
    if (!user) {
      return res.status(401).json({ message: 'Usuário inválido.' });
    }
    
    // Gera o token JWT
    const token = generateToken(user);
    const refreshToken = generateRefreshToken();
    
    res.json({
      token,
      refreshToken,
      expiresIn: '24h'
    });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao processar a solicitação de login.' });
  }
});

/**
 * @route POST /api/user/refresh-token
 * @desc Renova o token JWT
 * @access Público
 */
router.post('/refresh-token', async (req, res) => {
  try {
    const { accessToken, refreshToken } = req.body;
    
    // Cria e valida o modelo de token
    const tokenModel = new TokenModel();
    tokenModel.accessToken = accessToken;
    tokenModel.refreshToken = refreshToken;
    
    const validation = tokenModel.isValid();
    if (!validation.valid) {
      return res.status(400).json({ message: validation.message });
    }
    
    // Verifica se o token está na lista de tokens invalidados
    if (invalidatedTokens.has(accessToken)) {
      return res.status(401).json({ message: 'Token foi invalidado. Faça login novamente.' });
    }
    
    // Verifica o token
    let decoded;
    try {
      decoded = jwt.verify(
        accessToken, 
        process.env.JWT_SECRET || 'beach_tenis_secret_key', 
        { ignoreExpiration: true }
      );
    } catch (error) {
      return res.status(401).json({ message: 'Token inválido.' });
    }
    
    // Busca o usuário pelo email
    const [user] = await query('SELECT * FROM users WHERE email = ? AND status = 1', [decoded.email]);
    
    if (!user) {
      return res.status(401).json({ message: 'Usuário não encontrado.' });
    }
    
    // Gera novos tokens
    const newToken = generateToken(user);
    const newRefreshToken = generateRefreshToken();
    
    // Adiciona o token antigo à lista de tokens invalidados
    invalidatedTokens.add(accessToken);
    
    // Limita o tamanho da lista de tokens invalidados
    if (invalidatedTokens.size > 1000) {
      const iterator = invalidatedTokens.values();
      invalidatedTokens.delete(iterator.next().value);
    }
    
    res.json({
      token: newToken,
      refreshToken: newRefreshToken,
      expiresIn: '24h'
    });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao processar a solicitação de refresh token.' });
  }
});

/**
 * @route POST /api/user/logout
 * @desc Realiza o logout do usuário invalidando o token
 * @access Privado
 */
router.post('/logout', authenticateToken, (req, res) => {
  try {
    const authHeader = req.headers['authorization'];
    const token = authHeader && authHeader.split(' ')[1];
    
    if (token) {
      // Adiciona o token à lista de tokens invalidados
      invalidatedTokens.add(token);
      
      // Limita o tamanho da lista de tokens invalidados
      if (invalidatedTokens.size > 1000) {
        const iterator = invalidatedTokens.values();
        invalidatedTokens.delete(iterator.next().value);
      }
    }
    
    res.status(200).json({ message: 'Logout realizado com sucesso.' });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao processar a solicitação de logout.' });
  }
});

module.exports = router;
