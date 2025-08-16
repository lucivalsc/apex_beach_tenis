/**
 * Configuração do JWT
 */
class JwtConfig {
  constructor() {
    this.secret = process.env.JWT_SECRET || 'beach_tenis_secret_key';
    this.issuer = process.env.JWT_ISSUER || 'beach_tenis_api';
    this.audience = process.env.JWT_AUDIENCE || 'beach_tenis_client';
  }
}

module.exports = JwtConfig;
