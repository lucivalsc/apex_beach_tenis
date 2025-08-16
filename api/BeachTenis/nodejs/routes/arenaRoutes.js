const express = require('express');
const router = express.Router();
const { v4: uuidv4 } = require('uuid');
const { query } = require('../config/database');
const { Arena } = require('../models/arena');
const jwt = require('jsonwebtoken');
const { authenticateToken } = require('../middleware/authMiddleware');

/**
 * @route GET /api/arena
 * @desc Consulta todas as arenas
 * @access Privado
 */
router.get('/', authenticateToken, async (req, res) => {
  try {
    const arenas = await query('SELECT * FROM arenas WHERE status = 1');
    res.json(arenas);
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao listar as arenas.' });
  }
});

/**
 * @route GET /api/arena/:arenaId
 * @desc Consulta arena por ID
 * @access Privado
 */
router.get('/:arenaId', authenticateToken, async (req, res) => {
  try {
    const [arena] = await query('SELECT * FROM arenas WHERE id = ? AND status = 1', [req.params.arenaId]);
    
    if (!arena) {
      return res.status(404).json({ message: 'Arena não encontrada.' });
    }
    
    res.json(arena);
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao buscar a arena.' });
  }
});

/**
 * @route POST /api/arena
 * @desc Cria uma nova arena
 * @access Privado
 */
router.post('/', authenticateToken, async (req, res) => {
  try {
    const arenaData = req.body;
    
    // Verifica se o email já existe
    if (arenaData.email) {
      const [existingArena] = await query('SELECT * FROM arenas WHERE email = ?', [arenaData.email]);
      if (existingArena) {
        return res.status(400).json({ message: 'Já existe uma arena cadastrada com esse e-mail.' });
      }
    }
    
    // Cria uma instância do modelo Arena
    const arena = new Arena();
    Object.assign(arena, arenaData);
    
    // Valida os dados básicos
    if (!arena.name || arena.name.length < 4 || arena.name.length > 30) {
      return res.status(400).json({ message: 'O nome deve ter entre 4 e 30 caracteres.' });
    }
    
    // Gera um ID único
    arena.id = uuidv4();
    
    // Insere a arena no banco de dados
    await query(
      `INSERT INTO arenas (
        id, name, address, cnpj, telephone, yesWhatsapp, email, 
        instagram, facebook, photograph, creationDate, changeDate, status
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW(), ?)`,
      [
        arena.id, arena.name, arena.address, arena.cnpj, arena.telephone, 
        arena.yesWhatsapp, arena.email, arena.instagram, arena.facebook, 
        arena.photograph, arena.status
      ]
    );
    
    res.status(201).json({ 
      message: 'Arena criada com sucesso.', 
      arena 
    });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao criar a arena.' });
  }
});

/**
 * @route PUT /api/arena/:arenaId
 * @desc Atualiza uma arena
 * @access Privado
 */
router.put('/:arenaId', authenticateToken, async (req, res) => {
  try {
    const arenaId = req.params.arenaId;
    const arenaData = req.body;
    
    // Verifica se a arena existe
    const [existingArena] = await query('SELECT * FROM arenas WHERE id = ?', [arenaId]);
    
    if (!existingArena) {
      return res.status(404).json({ message: 'Arena não encontrada.' });
    }
    
    // Cria uma instância do modelo Arena
    const arena = new Arena();
    Object.assign(arena, { ...existingArena, ...arenaData });
    
    // Valida os dados básicos
    if (!arena.name || arena.name.length < 4 || arena.name.length > 30) {
      return res.status(400).json({ message: 'O nome deve ter entre 4 e 30 caracteres.' });
    }
    
    // Atualiza a data de alteração
    arena.alterChangeDate();
    
    // Atualiza a arena no banco de dados
    await query(
      `UPDATE arenas SET 
        name = ?, address = ?, cnpj = ?, telephone = ?, yesWhatsapp = ?, 
        email = ?, instagram = ?, facebook = ?, photograph = ?, 
        changeDate = NOW(), status = ?
      WHERE id = ?`,
      [
        arena.name, arena.address, arena.cnpj, arena.telephone, 
        arena.yesWhatsapp, arena.email, arena.instagram, arena.facebook, 
        arena.photograph, arena.status, arenaId
      ]
    );
    
    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao atualizar a arena.' });
  }
});

/**
 * @route DELETE /api/arena/:arenaId
 * @desc Desativa uma arena
 * @access Privado
 */
router.delete('/:arenaId', authenticateToken, async (req, res) => {
  try {
    const arenaId = req.params.arenaId;
    
    // Verifica se a arena existe
    const [existingArena] = await query('SELECT * FROM arenas WHERE id = ?', [arenaId]);
    
    if (!existingArena) {
      return res.status(404).json({ message: 'Arena não encontrada.' });
    }
    
    // Desativa a arena (altera o status para 2 = Desativado)
    await query(
      'UPDATE arenas SET status = 2, changeDate = NOW() WHERE id = ?',
      [arenaId]
    );
    
    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao desativar a arena.' });
  }
});

module.exports = router;
