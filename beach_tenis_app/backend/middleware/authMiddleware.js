// middleware/authMiddleware.js
const jwt = require('jsonwebtoken');

const authenticate = (req, res, next) => {
  const token = req.headers['authorization'];
  if (token) {
    jwt.verify(token, '123456789', (err, decoded) => {
      if (err) return res.status(403).json({ error: 'Token is not valid' });
      req.user = decoded;
      next();
    });
  } else {
    res.status(401).json({ error: 'No token provided' });
  }
};

module.exports = { authenticateToken: authenticate };
