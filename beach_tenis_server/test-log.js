// Script para testar a criação das tabelas com log em arquivo
const fs = require('fs');
const path = require('path');
const sequelize = require('./config/database');
const { TipoEndereco, TipoUsuario, Endereco, UsuarioTipo } = require('./models/index');

const logFile = path.join(__dirname, 'test-log.txt');

// Função para escrever no arquivo de log
function log(message) {
  const timestamp = new Date().toISOString();
  const logMessage = `[${timestamp}] ${message}\n`;
  
  console.log(message);
  fs.appendFileSync(logFile, logMessage);
}

async function testTables() {
  try {
    // Limpar arquivo de log anterior
    fs.writeFileSync(logFile, '');
    
    log('Testando conexão com o banco de dados...');
    await sequelize.authenticate();
    log('✅ Conexão estabelecida com sucesso!');
    
    log('\nVerificando tabela TipoEndereco...');
    const tipoEnderecoExists = await sequelize.getQueryInterface().tableExists('tipos_endereco');
    log(`Tabela TipoEndereco ${tipoEnderecoExists ? 'existe' : 'não existe'}`);
    
    log('\nVerificando tabela TipoUsuario...');
    const tipoUsuarioExists = await sequelize.getQueryInterface().tableExists('tipos_usuario');
    log(`Tabela TipoUsuario ${tipoUsuarioExists ? 'existe' : 'não existe'}`);
    
    log('\nVerificando tabela Endereco...');
    const enderecoExists = await sequelize.getQueryInterface().tableExists('enderecos');
    log(`Tabela Endereco ${enderecoExists ? 'existe' : 'não existe'}`);
    
    log('\nVerificando tabela UsuarioTipo...');
    const usuarioTipoExists = await sequelize.getQueryInterface().tableExists('usuarios_tipos');
    log(`Tabela UsuarioTipo ${usuarioTipoExists ? 'existe' : 'não existe'}`);
    
    // Tentar criar as tabelas na ordem correta
    log('\nTentando criar tabelas na ordem correta...');
    
    if (!tipoEnderecoExists) {
      log('Criando tabela TipoEndereco...');
      await TipoEndereco.sync();
      log('✅ Tabela TipoEndereco criada com sucesso!');
    }
    
    if (!tipoUsuarioExists) {
      log('Criando tabela TipoUsuario...');
      await TipoUsuario.sync();
      log('✅ Tabela TipoUsuario criada com sucesso!');
    }
    
    if (!enderecoExists) {
      log('Criando tabela Endereco...');
      await Endereco.sync();
      log('✅ Tabela Endereco criada com sucesso!');
    }
    
    if (!usuarioTipoExists) {
      log('Criando tabela UsuarioTipo...');
      await UsuarioTipo.sync();
      log('✅ Tabela UsuarioTipo criada com sucesso!');
    }
    
    log('\n✅ Teste concluído com sucesso!');
  } catch (error) {
    log('\n❌ Erro durante o teste: ' + error.message);
    if (error.parent) {
      log('Erro SQL: ' + error.parent.message);
    }
  } finally {
    log('Teste finalizado.');
  }
}

testTables();
