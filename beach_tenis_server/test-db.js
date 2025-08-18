// Script para testar a criação das tabelas com problemas
const sequelize = require('./config/database');
const { TipoEndereco, TipoUsuario, Endereco, UsuarioTipo } = require('./models/index');

async function testTables() {
  try {
    console.log('Testando conexão com o banco de dados...');
    await sequelize.authenticate();
    console.log('✅ Conexão estabelecida com sucesso!');
    
    console.log('\nVerificando tabela TipoEndereco...');
    const tipoEnderecoExists = await sequelize.getQueryInterface().tableExists('tipos_endereco');
    console.log(`Tabela TipoEndereco ${tipoEnderecoExists ? 'existe' : 'não existe'}`);
    
    console.log('\nVerificando tabela TipoUsuario...');
    const tipoUsuarioExists = await sequelize.getQueryInterface().tableExists('tipos_usuario');
    console.log(`Tabela TipoUsuario ${tipoUsuarioExists ? 'existe' : 'não existe'}`);
    
    console.log('\nVerificando tabela Endereco...');
    const enderecoExists = await sequelize.getQueryInterface().tableExists('enderecos');
    console.log(`Tabela Endereco ${enderecoExists ? 'existe' : 'não existe'}`);
    
    console.log('\nVerificando tabela UsuarioTipo...');
    const usuarioTipoExists = await sequelize.getQueryInterface().tableExists('usuarios_tipos');
    console.log(`Tabela UsuarioTipo ${usuarioTipoExists ? 'existe' : 'não existe'}`);
    
    // Tentar criar as tabelas na ordem correta
    console.log('\nTentando criar tabelas na ordem correta...');
    
    if (!tipoEnderecoExists) {
      console.log('Criando tabela TipoEndereco...');
      await TipoEndereco.sync();
      console.log('✅ Tabela TipoEndereco criada com sucesso!');
    }
    
    if (!tipoUsuarioExists) {
      console.log('Criando tabela TipoUsuario...');
      await TipoUsuario.sync();
      console.log('✅ Tabela TipoUsuario criada com sucesso!');
    }
    
    if (!enderecoExists) {
      console.log('Criando tabela Endereco...');
      await Endereco.sync();
      console.log('✅ Tabela Endereco criada com sucesso!');
    }
    
    if (!usuarioTipoExists) {
      console.log('Criando tabela UsuarioTipo...');
      await UsuarioTipo.sync();
      console.log('✅ Tabela UsuarioTipo criada com sucesso!');
    }
    
    console.log('\n✅ Teste concluído com sucesso!');
  } catch (error) {
    console.error('\n❌ Erro durante o teste:', error);
  } finally {
    process.exit(0);
  }
}

testTables();
