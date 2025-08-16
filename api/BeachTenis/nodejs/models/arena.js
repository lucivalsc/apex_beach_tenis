const BaseEntity = require('./baseEntity');

/**
 * Modelo de Arena
 */
class Arena extends BaseEntity {
  constructor() {
    super();
    this.name = '';
    this.address = '';
    this.cnpj = '';
    this.telephone = '';
    this.yesWhatsapp = true;
    this.email = '';
    this.instagram = '';
    this.facebook = '';
    this.photograph = '';
  }
}

/**
 * Modelo para MySQL
 */
const ArenaModel = {
  tableName: 'arenas',
  
  fields: {
    id: { type: 'VARCHAR(36)', primaryKey: true },
    name: { type: 'VARCHAR(30)', notNull: true },
    address: { type: 'VARCHAR(255)' },
    cnpj: { type: 'VARCHAR(14)' },
    telephone: { type: 'VARCHAR(11)' },
    yesWhatsapp: { type: 'BOOLEAN', default: true },
    email: { type: 'VARCHAR(100)' },
    instagram: { type: 'VARCHAR(100)' },
    facebook: { type: 'VARCHAR(100)' },
    photograph: { type: 'VARCHAR(255)' },
    creationDate: { type: 'DATETIME', default: 'CURRENT_TIMESTAMP' },
    changeDate: { type: 'DATETIME', default: 'CURRENT_TIMESTAMP' },
    status: { type: 'TINYINT', default: 1 }
  },
  
  createTable: `
    CREATE TABLE IF NOT EXISTS arenas (
      id VARCHAR(36) PRIMARY KEY,
      name VARCHAR(30) NOT NULL,
      address VARCHAR(255),
      cnpj VARCHAR(14),
      telephone VARCHAR(11),
      yesWhatsapp BOOLEAN DEFAULT true,
      email VARCHAR(100),
      instagram VARCHAR(100),
      facebook VARCHAR(100),
      photograph VARCHAR(255),
      creationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
      changeDate DATETIME DEFAULT CURRENT_TIMESTAMP,
      status TINYINT DEFAULT 1
    )
  `
};

module.exports = {
  Arena,
  ArenaModel
};
