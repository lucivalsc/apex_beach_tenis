const crypto = require('crypto');

/**
 * Modelo para login com email e senha
 */
class LoginModel {
  constructor() {
    this.email = '';
    this.password = '';
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
   * Valida o modelo de login
   * @returns {Object} Resultado da validação
   */
  isValid() {
    if (!this.email) {
      return { valid: false, message: 'Email é obrigatório' };
    }

    // Validação básica de formato de email
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(this.email)) {
      return { valid: false, message: 'Endereço de email inválido' };
    }

    if (!this.password) {
      return { valid: false, message: 'Senha é obrigatória' };
    }

    return { valid: true };
  }
}

module.exports = LoginModel;
