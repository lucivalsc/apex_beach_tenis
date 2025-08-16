const BaseEntity = require('./baseEntity');
const crypto = require('crypto');

/**
 * Modelo de Usuário
 */
class User extends BaseEntity {
  constructor() {
    super();
    this.name = '';
    this.birthDate = new Date();
    this.sex = '';
    this.email = '';
    this.cpf = '';
    this.rg = '';
    this.telephone = '';
    this.yesWhatsapp = true;
    this.photograph = '';
    this.idArena = 0;
    this.instagram = '';
    this.facebook = '';
    this.address = '';
    this.idProfessional = 0;
    this.userType = 0; // 1 = Teacher, 2 = Student, 3 = Professional, 4 = Athlete
    this.provider = 0; // 0 = Email/Senha, 1 = Google, 2 = Facebook
    this.idUserProvider = '';
    this.photoUrlProvider = '';
    this.password = '';
  }

  /**
   * Define o provedor de autenticação
   * @param {number} provider - Provedor de autenticação
   */
  setProvider(provider) {
    this.provider = provider;
  }

  /**
   * Criptografa a senha usando SHA-256
   */
  encryptPassword() {
    if (this.password) {
      const hash = crypto.createHash('sha256');
      hash.update(this.password);
      this.password = hash.digest('base64');
    }
  }

  /**
   * Valida o modelo de usuário
   * @param {boolean} existeUser - Se já existe usuário com o mesmo email
   * @param {number} provider - Provedor de autenticação
   * @returns {boolean} - Se o modelo é válido
   */
  isModelValid(existeUser = false, provider = 0) {
    let erro = '';
    
    this.setProvider(provider);
    
    if (existeUser) {
      return { valid: false, erro: 'Já existe usuário cadastrado com esse e-mail!' };
    }
    
    if (this.provider === 0) {
      this.encryptPassword();
      
      if (!this.password) {
        return { valid: false, erro: 'Senha é obrigatória!' };
      }
    }
    
    if (this.provider > 0 && !this.idUserProvider) {
      return { 
        valid: false, 
        erro: 'Para fazer o cadastro usando uma rede social, é necessario enviar o Id cadastrado na rede social informada!' 
      };
    }
    
    return { valid: true, erro: null };
  }
}

/**
 * Modelo para MySQL
 */
const UserModel = {
  tableName: 'users',
  
  fields: {
    id: { type: 'VARCHAR(36)', primaryKey: true },
    name: { type: 'VARCHAR(30)', notNull: true },
    birthDate: { type: 'DATETIME', notNull: true },
    sex: { type: 'VARCHAR(10)' },
    email: { type: 'VARCHAR(100)' },
    cpf: { type: 'VARCHAR(11)' },
    rg: { type: 'VARCHAR(20)' },
    telephone: { type: 'VARCHAR(11)' },
    yesWhatsapp: { type: 'BOOLEAN', default: true },
    photograph: { type: 'VARCHAR(255)' },
    idArena: { type: 'INT' },
    instagram: { type: 'VARCHAR(100)' },
    facebook: { type: 'VARCHAR(100)' },
    address: { type: 'VARCHAR(255)' },
    idProfessional: { type: 'INT' },
    userType: { type: 'TINYINT' },
    provider: { type: 'TINYINT', default: 0 },
    idUserProvider: { type: 'VARCHAR(100)' },
    photoUrlProvider: { type: 'VARCHAR(255)' },
    password: { type: 'VARCHAR(255)' },
    creationDate: { type: 'DATETIME', default: 'CURRENT_TIMESTAMP' },
    changeDate: { type: 'DATETIME', default: 'CURRENT_TIMESTAMP' },
    status: { type: 'TINYINT', default: 1 }
  },
  
  createTable: `
    CREATE TABLE IF NOT EXISTS users (
      id VARCHAR(36) PRIMARY KEY,
      name VARCHAR(30) NOT NULL,
      birthDate DATETIME NOT NULL,
      sex VARCHAR(10),
      email VARCHAR(100),
      cpf VARCHAR(11),
      rg VARCHAR(20),
      telephone VARCHAR(11),
      yesWhatsapp BOOLEAN DEFAULT true,
      photograph VARCHAR(255),
      idArena INT,
      instagram VARCHAR(100),
      facebook VARCHAR(100),
      address VARCHAR(255),
      idProfessional INT,
      userType TINYINT,
      provider TINYINT DEFAULT 0,
      idUserProvider VARCHAR(100),
      photoUrlProvider VARCHAR(255),
      password VARCHAR(255),
      creationDate DATETIME DEFAULT CURRENT_TIMESTAMP,
      changeDate DATETIME DEFAULT CURRENT_TIMESTAMP,
      status TINYINT DEFAULT 1
    )
  `
};

module.exports = {
  User,
  UserModel
};
