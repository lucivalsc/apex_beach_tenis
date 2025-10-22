const express = require('express');
const router = express.Router();
const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { body, validationResult } = require('express-validator');
const models = require('../models');
const { Usuario } = models;
const sequelize = require('../config/database');
const { authenticateToken } = require('../middleware/authMiddleware');

// Chave secreta para JWT - Em produção, use variáveis de ambiente
const JWT_SECRET = 'beach_tennis_secret_key_2025';

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

    // Buscar usuário pelo email com tipos, endereços e tipo de sexo associados
    const usuario = await Usuario.findOne({ 
      where: { email },
      include: [
        {
          model: models.UsuarioTipo,
          as: 'tipos',
          include: [{
            model: models.TipoUsuario,
            as: 'tipo_usuario'
          }]
        },
        {
          model: models.Endereco,
          as: 'enderecos',
          include: [{
            model: models.TipoEndereco,
            as: 'tipo_endereco'
          }]
        },
        {
          model: models.TipoSexo,
          as: 'tipoSexo'
        }
      ]
    });
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

    // console.log('Usuário logado:', usuario);
    // console.log('Token gerado:', token);

    res.json({
      success: true,
      token,
      usuario: {
        id: usuario.id, 
        nome: usuario.nome,
        telefone: usuario.telefone,
        instagram: usuario.instagram,
        facebook: usuario.facebook,
        linkedin: usuario.linkedin,
        email: usuario.email,
        tipo_usuario_id: usuario.tipo_usuario_id,
        tipo_sexo_id: usuario.tipo_sexo_id,
        // Incluir dados do tipo de sexo
        tipo_sexo: usuario.tipoSexo ? {
          id: usuario.tipoSexo.id,
          nome: usuario.tipoSexo.nome,
          codigo: usuario.tipoSexo.codigo
        } : null,
        ativo: usuario.ativo,
        ultimo_login: usuario.ultimo_login,
        createdAt: usuario.createdAt,
        updatedAt: usuario.updatedAt,
        // Incluir tipos de usuário associados
        tipos: usuario.tipos ? usuario.tipos.map(tipo => ({
          id: tipo.id,
          tipo_usuario_id: tipo.tipo_usuario_id,
          nome_tipo: tipo.tipo_usuario ? tipo.tipo_usuario.nome : null,
          codigo_tipo: tipo.tipo_usuario ? tipo.tipo_usuario.codigo : null,
          principal: tipo.principal,
          ativo: tipo.ativo
        })) : [],
        // Incluir endereços associados
        enderecos: usuario.enderecos ? usuario.enderecos.map(endereco => ({
          id: endereco.id,
          cep: endereco.cep,
          logradouro: endereco.logradouro,
          numero: endereco.numero,
          complemento: endereco.complemento,
          bairro: endereco.bairro,
          cidade: endereco.cidade,
          estado: endereco.estado,
          pais: endereco.pais,
          principal: endereco.principal,
          tipo_endereco_id: endereco.tipo_endereco_id,
          nome_tipo: endereco.tipo_endereco ? endereco.tipo_endereco.nome : null,
          ativo: endereco.ativo
        })) : []
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
  body('nome').optional(),
  body('email').isEmail().withMessage('Email inválido'),
  body('senha').isLength({ min: 6 }).withMessage('Senha deve ter pelo menos 6 caracteres'),
  body('tipo_usuario_id').isInt().withMessage('ID do tipo de usuário inválido'),
  body('tipo_sexo_id').isInt().withMessage('ID do tipo de sexo inválido'),
  body('endereco.cep').optional().isString().withMessage('CEP inválido'),
  body('endereco.logradouro').optional().isString().withMessage('Logradouro inválido'),
  body('endereco.numero').optional().isString().withMessage('Número inválido'),
  body('endereco.bairro').optional().isString().withMessage('Bairro inválido'),
  body('endereco.cidade').optional().isString().withMessage('Cidade inválida'),
  body('endereco.estado').optional().isString().isLength({ min: 2, max: 2 }).withMessage('Estado inválido'),
  body('endereco.tipo_endereco_id').optional().isInt().withMessage('Tipo de endereço inválido')
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

    const { 
      nome, 
      email, 
      senha, 
      tipo_usuario_id,
      tipo_sexo_id,
      telefone, 
      instagram, 
      facebook, 
      linkedin,
      ativo,
      email_verificado,
      endereco
    } = req.body;

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

    // Criar novo usuário com os campos obrigatórios
    const dadosUsuario = {
      email,
      password_hash,
      tipo_usuario_id,
      tipo_sexo_id,
      ativo: ativo !== undefined ? ativo : true,
      email_verificado: email_verificado !== undefined ? email_verificado : false
    };
    
    // Adicionar campos opcionais apenas se foram fornecidos
    if (nome !== undefined) dadosUsuario.nome = nome;
    if (telefone !== undefined) dadosUsuario.telefone = telefone;
    if (instagram !== undefined) dadosUsuario.instagram = instagram;
    if (facebook !== undefined) dadosUsuario.facebook = facebook;
    if (linkedin !== undefined) dadosUsuario.linkedin = linkedin;
    
    // Iniciar uma transação para garantir que todas as operações sejam atômicas
    const t = await sequelize.transaction();
    
    try {
      // Criar o usuário com os dados fornecidos
      const novoUsuario = await Usuario.create(dadosUsuario, { transaction: t });
      
      // Criar o registro de UsuarioTipo para associar o usuário ao tipo
      await models.UsuarioTipo.create({
        usuario_id: novoUsuario.id,
        tipo_usuario_id: tipo_usuario_id,
        principal: true,
        ativo: true,
        createdAt: new Date(),
        updatedAt: new Date()
      }, { transaction: t });
      
      // Se foram fornecidos dados de endereço, criar o endereço
      let novoEndereco = null;
      if (endereco && Object.keys(endereco).length > 0) {
        // Verificar se temos os campos mínimos necessários
        if (endereco.cep && endereco.logradouro && endereco.numero && endereco.bairro && 
            endereco.cidade && endereco.estado && endereco.tipo_endereco_id) {
          
          novoEndereco = await models.Endereco.create({
            usuario_id: novoUsuario.id,
            cep: endereco.cep,
            logradouro: endereco.logradouro,
            numero: endereco.numero,
            complemento: endereco.complemento || null,
            bairro: endereco.bairro,
            cidade: endereco.cidade,
            estado: endereco.estado,
            pais: endereco.pais || 'Brasil',
            principal: endereco.principal !== undefined ? endereco.principal : true,
            tipo_endereco_id: endereco.tipo_endereco_id,
            ativo: endereco.ativo !== undefined ? endereco.ativo : true,
            createdAt: new Date(),
            updatedAt: new Date()
          }, { transaction: t });
        }
      }
      
      // Confirmar a transação
      await t.commit();
      
      // Retornar o usuário criado com informações de endereço e tipo
      res.status(201).json({
        success: true,
        message: 'Usuário registrado com sucesso',
        usuario: {
          id: novoUsuario.id,
          nome: novoUsuario.nome,
          email: novoUsuario.email,
          tipo_usuario_id: novoUsuario.tipo_usuario_id,
          tipo_sexo_id: novoUsuario.tipo_sexo_id,
          ativo: novoUsuario.ativo,
          telefone: novoUsuario.telefone,
          instagram: novoUsuario.instagram,
          facebook: novoUsuario.facebook,
          linkedin: novoUsuario.linkedin,
          createdAt: novoUsuario.createdAt,
          updatedAt: novoUsuario.updatedAt
        },
        endereco: novoEndereco
      });
    } catch (error) {
      // Em caso de erro, reverter a transação
      await t.rollback();
      console.error('Erro no registro:', error);
      res.status(500).json({
        success: false,
        message: 'Erro ao processar registro',
        error: error.message
      });
    }
  } catch (error) {
    console.error('Erro no registro (fora da transação):', error);
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
