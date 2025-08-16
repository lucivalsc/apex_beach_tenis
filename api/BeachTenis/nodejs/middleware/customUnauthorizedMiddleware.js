/**
 * Middleware personalizado para tratamento de erros de autenticação
 * Intercepta erros 401 e 403 e retorna respostas padronizadas
 */
const customUnauthorizedMiddleware = (req, res, next) => {
  // Armazena o método original de envio de resposta
  const originalSend = res.send;
  
  // Sobrescreve o método send para interceptar respostas de erro
  res.send = function(body) {
    // Verifica se é uma resposta de erro de autenticação
    if (res.statusCode === 401) {
      return originalSend.call(this, JSON.stringify({
        message: 'Não autorizado. Autenticação necessária.',
        statusCode: 401
      }));
    }
    
    if (res.statusCode === 403) {
      return originalSend.call(this, JSON.stringify({
        message: 'Acesso proibido. Você não tem permissão para acessar este recurso.',
        statusCode: 403
      }));
    }
    
    // Para outros casos, mantém o comportamento original
    return originalSend.call(this, body);
  };
  
  next();
};

module.exports = customUnauthorizedMiddleware;
