/**
 * Modelo para token JWT e refresh token
 */
class TokenModel {
  constructor() {
    this.accessToken = '';
    this.refreshToken = '';
  }

  /**
   * Valida o modelo de token
   * @returns {Object} Resultado da validação
   */
  isValid() {
    if (!this.accessToken) {
      return { valid: false, message: 'Token é obrigatório' };
    }

    if (!this.refreshToken) {
      return { valid: false, message: 'RefreshToken é obrigatório' };
    }

    return { valid: true };
  }
}

module.exports = TokenModel;
