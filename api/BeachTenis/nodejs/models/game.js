const BaseEntity = require('./baseEntity');

/**
 * Modelo de Jogo
 */
class Game extends BaseEntity {
  constructor() {
    super();
    this.title = '';
    this.description = '';
    this.date = new Date();
    this.startTime = '';
    this.endTime = '';
    this.idArena = null;
    this.players = []; // Array de IDs de usuários
    this.maxPlayers = 4;
    this.price = 0;
  }
}

/**
 * Modelo para MySQL
 */
const GameModel = {
  tableName: 'games',
  
  fields: {
    id: { type: 'VARCHAR(36)', primaryKey: true },
    title: { type: 'VARCHAR(100)', notNull: true },
    description: { type: 'TEXT' },
    date: { type: 'DATE', notNull: true },
    startTime: { type: 'TIME', notNull: true },
    endTime: { type: 'TIME', notNull: true },
    idArena: { type: 'VARCHAR(36)', notNull: true },
    maxPlayers: { type: 'INT', default: 4 },
    price: { type: 'DECIMAL(10,2)', default: 0 },
    creationDate: { type: 'DATETIME', default: 'CURRENT_TIMESTAMP' },
    changeDate: { type: 'DATETIME', default: 'CURRENT_TIMESTAMP' },
    status: { type: 'TINYINT', default: 1 }
  },
  
  createTable: `
    CREATE TABLE IF NOT EXISTS games (
      id VARCHAR(36) PRIMARY KEY,
      title VARCHAR(100) NOT NULL,
      description TEXT,
      date DATE NOT NULL,
      startTime TIME NOT NULL,
      endTime TIME NOT NULL,
      idArena VARCHAR(36) NOT NULL,
      maxPlayers INT DEFAULT 4,
      price DECIMAL(10,2) DEFAULT 0,
      creationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
      changeDate DATETIME DEFAULT CURRENT_TIMESTAMP,
      status TINYINT DEFAULT 1,
      FOREIGN KEY (idArena) REFERENCES arenas(id)
    )
  `,
  
  // Tabela de relacionamento entre jogos e jogadores
  createPlayerRelationTable: `
    CREATE TABLE IF NOT EXISTS game_players (
      id INT AUTO_INCREMENT PRIMARY KEY,
      gameId VARCHAR(36) NOT NULL,
      userId VARCHAR(36) NOT NULL,
      creationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
      FOREIGN KEY (gameId) REFERENCES games(id),
      FOREIGN KEY (userId) REFERENCES users(id),
      UNIQUE KEY unique_game_player (gameId, userId)
    )
  `
};

module.exports = {
  Game,
  GameModel
};
