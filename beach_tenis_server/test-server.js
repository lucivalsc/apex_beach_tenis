// Script simples para testar a inicialização do servidor
const sequelize = require('./config/database');

// Testar conexão com o banco de dados
sequelize.authenticate()
  .then(() => {
    console.log('✅ Conexão com o banco de dados estabelecida com sucesso.');
    process.exit(0);
  })
  .catch(error => {
    console.error('❌ Erro ao conectar com o banco de dados:', error);
    process.exit(1);
  });
