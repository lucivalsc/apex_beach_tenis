/**
 * Modelo para login social (Google e Facebook)
 */
class LoginSocialModel {
  constructor() {
    this.email = '';
    this.idProvider = '';
  }

  /**
   * Valida o modelo de login social
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

    if (!this.idProvider) {
      return { valid: false, message: 'Id do social é obrigatório' };
    }

    return { valid: true };
  }
}

module.exports = LoginSocialModel;
