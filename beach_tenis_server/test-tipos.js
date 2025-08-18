// Script para testar a inicialização da tabela TipoEndereco
const sequelize = require('./config/database');
const { TipoEndereco } = require('./models/index');
const fs = require('fs');
const path = require('path');

const logFile = path.join(__dirname, 'test-tipos.log');

// Função para escrever no arquivo de log
function log(message) {
  const timestamp = new Date().toISOString();
  const logMessage = `[${timestamp}] ${message}\n`;
  
  console.log(message);
  fs.appendFileSync(logFile, logMessage);
}

async function testTipoEndereco() {
  try {
    // Limpar arquivo de log anterior
    fs.writeFileSync(logFile, '');
    
    log('Testando conexão com o banco de dados...');
    await sequelize.authenticate();
    log('✅ Conexão estabelecida com sucesso!');
    
    log('\nVerificando tabela TipoEndereco...');
    const tipoEnderecoExists = await sequelize.getQueryInterface().tableExists('tipos_endereco');
    log(`Tabela TipoEndereco ${tipoEnderecoExists ? 'existe' : 'não existe'}`);
    
    // Testar a inserção de valores padrão
    log('\nTestando inserção de valores padrão em TipoEndereco...');
    try {
      await TipoEndereco.insertDefaultValues();
      log('✅ Valores padrão inseridos com sucesso!');
    } catch (error) {
      log(`❌ Erro ao inserir valores padrão: ${error.message}`);
      if (error.errors) {
        error.errors.forEach(err => {
          log(`  - ${err.message} (${err.path}: ${err.value})`);
        });
      }
    }
    
    // Verificar se os registros foram inseridos
    log('\nVerificando registros inseridos...');
    const count = await TipoEndereco.count();
    log(`Total de registros na tabela TipoEndereco: ${count}`);
    
    const residencial = await TipoEndereco.findOne({ where: { codigo: 'RESIDENCIAL' } });
    log(`Registro RESIDENCIAL: ${residencial ? 'encontrado' : 'não encontrado'}`);
    if (residencial) {
      log(`Dados do registro: ${JSON.stringify({
        id: residencial.id,
        nome: residencial.nome,
        codigo: residencial.codigo,
        created_at: residencial.created_at,
        updated_at: residencial.updated_at
      }, null, 2)}`);
    }
    
    log('\n✅ Teste concluído com sucesso!');
  } catch (error) {
    log(`\n❌ Erro durante o teste: ${error.message}`);
    if (error.stack) {
      log(`Stack: ${error.stack}`);
    }
  }
}

testTipoEndereco();
