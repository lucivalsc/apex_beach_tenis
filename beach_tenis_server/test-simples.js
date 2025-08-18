// Script simples para testar a criação de um registro em TipoEndereco
const sequelize = require('./config/database');
const { TipoEndereco } = require('./models/index');
const fs = require('fs');

async function testSimples() {
  try {
    console.log('Conectando ao banco de dados...');
    await sequelize.authenticate();
    console.log('Conexão estabelecida com sucesso!');
    
    console.log('Criando um registro de teste em TipoEndereco...');
    const tipoTeste = await TipoEndereco.create({
      nome: 'Teste',
      codigo: 'TESTE_' + Date.now(),
      descricao: 'Registro de teste',
      ativo: true
    });
    
    console.log('Registro criado com sucesso!');
    console.log('ID:', tipoTeste.id);
    console.log('Nome:', tipoTeste.nome);
    console.log('Código:', tipoTeste.codigo);
    console.log('Timestamps:', {
      createdAt: tipoTeste.created_at || tipoTeste.createdAt,
      updatedAt: tipoTeste.updated_at || tipoTeste.updated_at
    });
    
    // Salvar resultado em arquivo
    fs.writeFileSync('resultado-teste.txt', 
      `Teste realizado em: ${new Date().toISOString()}\n` +
      `ID: ${tipoTeste.id}\n` +
      `Nome: ${tipoTeste.nome}\n` +
      `Código: ${tipoTeste.codigo}\n` +
      `CreatedAt: ${tipoTeste.created_at || tipoTeste.createdAt}\n` +
      `updatedAt: ${tipoTeste.updated_at || tipoTeste.updated_at}\n` +
      `Sucesso: true\n`
    );
    
    console.log('Teste concluído com sucesso!');
    process.exit(0);
  } catch (error) {
    console.error('Erro durante o teste:', error);
    
    // Salvar erro em arquivo
    fs.writeFileSync('resultado-teste.txt', 
      `Teste realizado em: ${new Date().toISOString()}\n` +
      `Erro: ${error.message}\n` +
      (error.errors ? error.errors.map(e => `- ${e.message} (${e.path})`).join('\n') : '') +
      `\nStack: ${error.stack}\n` +
      `Sucesso: false\n`
    );
    
    process.exit(1);
  }
}

testSimples();
