const express = require('express');
const router = express.Router();
const { v4: uuidv4 } = require('uuid');
const { query } = require('../config/database');
const { Game } = require('../models/game');
const jwt = require('jsonwebtoken');
const { authenticateToken } = require('../middleware/authMiddleware');

/**
 * @route GET /api/game
 * @desc Consulta todos os jogos
 * @access Privado
 */
router.get('/', authenticateToken, async (req, res) => {
  try {
    const games = await query('SELECT * FROM games WHERE status = 1');
    
    // Para cada jogo, busca os jogadores
    for (const game of games) {
      const players = await query(
        'SELECT u.* FROM game_players gp JOIN users u ON gp.userId = u.id WHERE gp.gameId = ?',
        [game.id]
      );
      
      // Remove senhas dos jogadores
      game.players = players.map(player => {
        const { password, ...playerWithoutPassword } = player;
        return playerWithoutPassword;
      });
    }
    
    res.json(games);
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao listar os jogos.' });
  }
});

/**
 * @route GET /api/game/:gameId
 * @desc Consulta jogo por ID
 * @access Privado
 */
router.get('/:gameId', authenticateToken, async (req, res) => {
  try {
    const [game] = await query('SELECT * FROM games WHERE id = ? AND status = 1', [req.params.gameId]);
    
    if (!game) {
      return res.status(404).json({ message: 'Jogo não encontrado.' });
    }
    
    // Busca os jogadores do jogo
    const players = await query(
      'SELECT u.* FROM game_players gp JOIN users u ON gp.userId = u.id WHERE gp.gameId = ?',
      [game.id]
    );
    
    // Remove senhas dos jogadores
    game.players = players.map(player => {
      const { password, ...playerWithoutPassword } = player;
      return playerWithoutPassword;
    });
    
    res.json(game);
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao buscar o jogo.' });
  }
});

/**
 * @route POST /api/game
 * @desc Cria um novo jogo
 * @access Privado
 */
router.post('/', authenticateToken, async (req, res) => {
  try {
    const gameData = req.body;
    const players = gameData.players || [];
    
    // Verifica se a arena existe
    if (gameData.idArena) {
      const [arena] = await query('SELECT * FROM arenas WHERE id = ? AND status = 1', [gameData.idArena]);
      if (!arena) {
        return res.status(400).json({ message: 'Arena não encontrada.' });
      }
    }
    
    // Cria uma instância do modelo Game
    const game = new Game();
    Object.assign(game, gameData);
    
    // Validações básicas
    if (!game.title) {
      return res.status(400).json({ message: 'Título é obrigatório.' });
    }
    
    if (!game.date || !game.startTime || !game.endTime) {
      return res.status(400).json({ message: 'Data e horários são obrigatórios.' });
    }
    
    if (!game.idArena) {
      return res.status(400).json({ message: 'Arena é obrigatória.' });
    }
    
    // Gera um ID único
    game.id = uuidv4();
    
    // Insere o jogo no banco de dados
    await query(
      `INSERT INTO games (
        id, title, description, date, startTime, endTime, idArena, 
        maxPlayers, price, creationDate, changeDate, status
      ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, NOW(), NOW(), ?)`,
      [
        game.id, game.title, game.description, game.date, game.startTime, 
        game.endTime, game.idArena, game.maxPlayers, game.price, game.status
      ]
    );
    
    // Adiciona os jogadores ao jogo
    if (players.length > 0) {
      for (const playerId of players) {
        // Verifica se o jogador existe
        const [player] = await query('SELECT * FROM users WHERE id = ? AND status = 1', [playerId]);
        if (player) {
          await query(
            'INSERT INTO game_players (gameId, userId, creationDate) VALUES (?, ?, NOW())',
            [game.id, playerId]
          );
        }
      }
    }
    
    res.status(201).json({ 
      message: 'Jogo criado com sucesso.', 
      game 
    });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao criar o jogo.' });
  }
});

/**
 * @route PUT /api/game/:gameId
 * @desc Atualiza um jogo
 * @access Privado
 */
router.put('/:gameId', authenticateToken, async (req, res) => {
  try {
    const gameId = req.params.gameId;
    const gameData = req.body;
    const players = gameData.players || [];
    
    // Verifica se o jogo existe
    const [existingGame] = await query('SELECT * FROM games WHERE id = ?', [gameId]);
    
    if (!existingGame) {
      return res.status(404).json({ message: 'Jogo não encontrado.' });
    }
    
    // Verifica se a arena existe
    if (gameData.idArena) {
      const [arena] = await query('SELECT * FROM arenas WHERE id = ? AND status = 1', [gameData.idArena]);
      if (!arena) {
        return res.status(400).json({ message: 'Arena não encontrada.' });
      }
    }
    
    // Cria uma instância do modelo Game
    const game = new Game();
    Object.assign(game, { ...existingGame, ...gameData });
    
    // Validações básicas
    if (!game.title) {
      return res.status(400).json({ message: 'Título é obrigatório.' });
    }
    
    if (!game.date || !game.startTime || !game.endTime) {
      return res.status(400).json({ message: 'Data e horários são obrigatórios.' });
    }
    
    if (!game.idArena) {
      return res.status(400).json({ message: 'Arena é obrigatória.' });
    }
    
    // Atualiza a data de alteração
    game.alterChangeDate();
    
    // Atualiza o jogo no banco de dados
    await query(
      `UPDATE games SET 
        title = ?, description = ?, date = ?, startTime = ?, endTime = ?, 
        idArena = ?, maxPlayers = ?, price = ?, changeDate = NOW(), status = ?
      WHERE id = ?`,
      [
        game.title, game.description, game.date, game.startTime, game.endTime, 
        game.idArena, game.maxPlayers, game.price, game.status, gameId
      ]
    );
    
    // Atualiza os jogadores do jogo
    if (players.length > 0) {
      // Remove jogadores atuais
      await query('DELETE FROM game_players WHERE gameId = ?', [gameId]);
      
      // Adiciona os novos jogadores
      for (const playerId of players) {
        // Verifica se o jogador existe
        const [player] = await query('SELECT * FROM users WHERE id = ? AND status = 1', [playerId]);
        if (player) {
          await query(
            'INSERT INTO game_players (gameId, userId, creationDate) VALUES (?, ?, NOW())',
            [gameId, playerId]
          );
        }
      }
    }
    
    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao atualizar o jogo.' });
  }
});

/**
 * @route DELETE /api/game/:gameId
 * @desc Desativa um jogo
 * @access Privado
 */
router.delete('/:gameId', authenticateToken, async (req, res) => {
  try {
    const gameId = req.params.gameId;
    
    // Verifica se o jogo existe
    const [existingGame] = await query('SELECT * FROM games WHERE id = ?', [gameId]);
    
    if (!existingGame) {
      return res.status(404).json({ message: 'Jogo não encontrado.' });
    }
    
    // Desativa o jogo (altera o status para 2 = Desativado)
    await query(
      'UPDATE games SET status = 2, changeDate = NOW() WHERE id = ?',
      [gameId]
    );
    
    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao desativar o jogo.' });
  }
});

/**
 * @route POST /api/game/:gameId/player/:playerId
 * @desc Adiciona um jogador ao jogo
 * @access Privado
 */
router.post('/:gameId/player/:playerId', authenticateToken, async (req, res) => {
  try {
    const gameId = req.params.gameId;
    const playerId = req.params.playerId;
    
    // Verifica se o jogo existe
    const [game] = await query('SELECT * FROM games WHERE id = ? AND status = 1', [gameId]);
    if (!game) {
      return res.status(404).json({ message: 'Jogo não encontrado.' });
    }
    
    // Verifica se o jogador existe
    const [player] = await query('SELECT * FROM users WHERE id = ? AND status = 1', [playerId]);
    if (!player) {
      return res.status(404).json({ message: 'Jogador não encontrado.' });
    }
    
    // Verifica se o jogador já está no jogo
    const [existingPlayer] = await query(
      'SELECT * FROM game_players WHERE gameId = ? AND userId = ?',
      [gameId, playerId]
    );
    
    if (existingPlayer) {
      return res.status(400).json({ message: 'Jogador já está no jogo.' });
    }
    
    // Verifica se o jogo já está cheio
    const [{ count }] = await query(
      'SELECT COUNT(*) as count FROM game_players WHERE gameId = ?',
      [gameId]
    );
    
    if (count >= game.maxPlayers) {
      return res.status(400).json({ message: 'Jogo já está com o número máximo de jogadores.' });
    }
    
    // Adiciona o jogador ao jogo
    await query(
      'INSERT INTO game_players (gameId, userId, creationDate) VALUES (?, ?, NOW())',
      [gameId, playerId]
    );
    
    res.status(201).json({ message: 'Jogador adicionado ao jogo com sucesso.' });
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao adicionar o jogador ao jogo.' });
  }
});

/**
 * @route DELETE /api/game/:gameId/player/:playerId
 * @desc Remove um jogador do jogo
 * @access Privado
 */
router.delete('/:gameId/player/:playerId', authenticateToken, async (req, res) => {
  try {
    const gameId = req.params.gameId;
    const playerId = req.params.playerId;
    
    // Verifica se o jogo existe
    const [game] = await query('SELECT * FROM games WHERE id = ? AND status = 1', [gameId]);
    if (!game) {
      return res.status(404).json({ message: 'Jogo não encontrado.' });
    }
    
    // Verifica se o jogador está no jogo
    const [existingPlayer] = await query(
      'SELECT * FROM game_players WHERE gameId = ? AND userId = ?',
      [gameId, playerId]
    );
    
    if (!existingPlayer) {
      return res.status(404).json({ message: 'Jogador não está no jogo.' });
    }
    
    // Remove o jogador do jogo
    await query(
      'DELETE FROM game_players WHERE gameId = ? AND userId = ?',
      [gameId, playerId]
    );
    
    res.status(204).send();
  } catch (error) {
    console.error(error);
    res.status(400).json({ message: 'Ocorreu um erro ao remover o jogador do jogo.' });
  }
});

module.exports = router;
