const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { Usuario } = require('../models');
const authenticateToken = require('../middleware/authMiddleware').authenticateToken;

// Chave secreta para JWT - Em produção, use variáveis de ambiente
const JWT_SECRET = 'beach_tennis_secret_key_2025';


// Middleware para validação de dados
const { body, validationResult } = require('express-validator');

// Rota para login
router.post('/login', [
  body('email').isEmail().withMessage('Email inválido'),
  body('senha').notEmpty().withMessage('Senha é obrigatória')
], async (req, res) => {
  try {
    // Verificar erros de validação
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        errors: errors.array()
      });
    }

    const { email, senha } = req.body;

    // Buscar usuário pelo email
    const usuario = await Usuario.findOne({ where: { email } });
    if (!usuario) {
      return res.status(401).json({
        success: false,
        message: 'Credenciais inválidas'
      });
    }

    // Verificar senha usando bcrypt
    const senhaValida = await bcrypt.compare(senha, usuario.password_hash);
    if (!senhaValida) {
      return res.status(401).json({
        success: false,
        message: 'Credenciais inválidas'
      });
    }

    // Atualizar último login
    usuario.ultimo_login = new Date();
    await usuario.save();

    // Gerar JWT token
    const token = jwt.sign(
      { 
        id: usuario.id,
        email: usuario.email,
        tipo: usuario.tipo_principal 
      }, 
      JWT_SECRET, 
      { expiresIn: '24h' }
    );

    res.json({
      success: true,
      token,
      usuario: {
        id: usuario.id,
        nome: usuario.nome,
        email: usuario.email,
        tipo: usuario.tipo
      }
    });
  } catch (error) {
    console.error('Erro no login:', error);
    res.status(500).json({
      success: false,
      message: 'Erro ao processar login'
    });
  }
});

// Rota para registro de novo usuário
router.post('/registro', [
  body('nome').notEmpty().withMessage('Nome é obrigatório'),
  body('email').isEmail().withMessage('Email inválido'),
  body('senha').isLength({ min: 6 }).withMessage('Senha deve ter pelo menos 6 caracteres'),
  body('tipo').isIn(['ADMIN', 'ARENA', 'PROFESSOR', 'ATLETA', 'ALUNO', 'PROFISSIONAL_TECNICO'])
    .withMessage('Tipo de usuário inválido')
], async (req, res) => {
  try {
    // Verificar erros de validação
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        errors: errors.array()
      });
    }

    const { nome, email, senha, tipo } = req.body;

    // Verificar se o email já está em uso
    const usuarioExistente = await Usuario.findOne({ where: { email } });
    if (usuarioExistente) {
      return res.status(400).json({
        success: false,
        message: 'Email já está em uso'
      });
    }

    // Criptografar a senha
    const saltRounds = 10;
    const password_hash = await bcrypt.hash(senha, saltRounds);

    // Criar novo usuário
    const novoUsuario = await Usuario.create({
      email,
      password_hash,
      tipo_principal: tipo, // Mapear o tipo para tipo_principal
      ativo: true
    });

    res.status(201).json({
      success: true,
      message: 'Usuário registrado com sucesso',
      usuario: {
        id: novoUsuario.id,
        email: novoUsuario.email,
        tipo: novoUsuario.tipo_principal,
        ativo: novoUsuario.ativo
      }
    });
  } catch (error) {
    console.error('Erro no registro:', error);
    res.status(500).json({
      success: false,
      message: 'Erro ao processar registro'
    });
  }
});

// Rota para obter perfil do usuário (protegida)
router.get('/perfil', authenticateToken, async (req, res) => {
  try {
    // O middleware de autenticação já deve ter adicionado o usuário à requisição
    const usuario = await Usuario.findByPk(req.usuario.id, {
      attributes: { exclude: ['senha'] } // Não retornar a senha
    });

    if (!usuario) {
      return res.status(404).json({
        success: false,
        message: 'Usuário não encontrado'
      });
    }

    res.json({
      success: true,
      usuario
    });
  } catch (error) {
    console.error('Erro ao obter perfil:', error);
    res.status(500).json({
      success: false,
      message: 'Erro ao obter perfil'
    });
  }
});

// Rota para atualizar perfil (protegida)
router.put('/perfil', authenticateToken, [
  body('nome').optional().notEmpty().withMessage('Nome não pode ser vazio'),
  body('email').optional().isEmail().withMessage('Email inválido')
], async (req, res) => {
  try {
    // Verificar erros de validação
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        errors: errors.array()
      });
    }

    const { nome, email } = req.body;
    const usuarioId = req.usuario.id;

    // Verificar se o email já está em uso por outro usuário
    if (email) {
      const emailExistente = await Usuario.findOne({
        where: {
          email,
          id: { [Op.ne]: usuarioId } // Não incluir o próprio usuário na verificação
        }
      });

      if (emailExistente) {
        return res.status(400).json({
          success: false,
          message: 'Email já está em uso'
        });
      }
    }

    // Atualizar usuário
    const usuario = await Usuario.findByPk(usuarioId);
    if (!usuario) {
      return res.status(404).json({
        success: false,
        message: 'Usuário não encontrado'
      });
    }

    // Atualizar apenas os campos fornecidos
    if (nome) usuario.nome = nome;
    if (email) usuario.email = email;

    await usuario.save();

    res.json({
      success: true,
      message: 'Perfil atualizado com sucesso',
      usuario: {
        id: usuario.id,
        nome: usuario.nome,
        email: usuario.email,
        tipo: usuario.tipo
      }
    });
  } catch (error) {
    console.error('Erro ao atualizar perfil:', error);
    res.status(500).json({
      success: false,
      message: 'Erro ao atualizar perfil'
    });
  }
});

// Rota para alterar senha (protegida)
router.put('/senha', authenticateToken, [
  body('senhaAtual').notEmpty().withMessage('Senha atual é obrigatória'),
  body('novaSenha').isLength({ min: 6 }).withMessage('Nova senha deve ter pelo menos 6 caracteres')
], async (req, res) => {
  try {
    // Verificar erros de validação
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({
        success: false,
        errors: errors.array()
      });
    }

    const { senhaAtual, novaSenha } = req.body;
    const usuarioId = req.usuario.id;

    // Buscar usuário
    const usuario = await Usuario.findByPk(usuarioId);
    if (!usuario) {
      return res.status(404).json({
        success: false,
        message: 'Usuário não encontrado'
      });
    }

    // Verificar senha atual usando bcrypt
    const senhaValida = await bcrypt.compare(senhaAtual, usuario.password_hash);
    if (!senhaValida) {
      return res.status(401).json({
        success: false,
        message: 'Senha atual incorreta'
      });
    }

    // Atualizar senha com criptografia
    const saltRounds = 10;
    const password_hash = await bcrypt.hash(novaSenha, saltRounds);
    usuario.password_hash = password_hash;
    await usuario.save();

    res.json({
      success: true,
      message: 'Senha alterada com sucesso'
    });
  } catch (error) {
    console.error('Erro ao alterar senha:', error);
    res.status(500).json({
      success: false,
      message: 'Erro ao alterar senha'
    });
  }
});

module.exports = router;
