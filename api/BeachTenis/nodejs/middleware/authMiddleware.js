const jwt = require('jsonwebtoken');

/**
 * Middleware de autenticação JWT
 * Verifica se o token JWT é válido e adiciona o usuário ao objeto de requisição
 */
const authenticateToken = (req, res, next) => {
  const authHeader = req.headers['authorization'];
  const token = authHeader && authHeader.split(' ')[1];
  
  if (token == null) return res.status(401).json({ message: 'Não autorizado. Token não fornecido.' });
  
  jwt.verify(token, process.env.JWT_SECRET || 'beach_tenis_secret_key', (err, user) => {
    if (err) return res.status(403).json({ message: 'Acesso proibido. Token inválido.' });
    req.user = user;
    next();
  });
};

module.exports = {
  authenticateToken
};
