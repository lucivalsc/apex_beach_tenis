'use strict';

/**
 * Função para inicializar todas as tabelas de tipos que substituem os enums
 * @param {Object} db - Objeto com todos os modelos do Sequelize
 */
async function initializeEnumTables(db) {
  try {
    console.log('Inicializando tabelas de tipos...');
    
    // Inicializa TipoUsuario
    if (db.TipoUsuario) {
      console.log('Inicializando TipoUsuario...');
      await db.TipoUsuario.insertDefaultValues();
    }
    
    // Inicializa TipoSexo
    if (db.TipoSexo) {
      console.log('Inicializando TipoSexo...');
      await db.TipoSexo.insertDefaultValues();
    }
    
    // Inicializa StatusAssinatura
    if (db.StatusAssinatura) {
      console.log('Inicializando StatusAssinatura...');
      await db.StatusAssinatura.insertDefaultValues();
    }
    
    // Inicializa TipoJogo
    if (db.TipoJogo) {
      console.log('Inicializando TipoJogo...');
      await db.TipoJogo.insertDefaultValues();
    }
    
    // Inicializa StatusJogo
    if (db.StatusJogo) {
      console.log('Inicializando StatusJogo...');
      await db.StatusJogo.insertDefaultValues();
    }
    
    // Inicializa StatusAvaliacao
    if (db.StatusAvaliacao) {
      console.log('Inicializando StatusAvaliacao...');
      await db.StatusAvaliacao.insertDefaultValues();
    }
    
    // Inicializa TipoEquipe
    if (db.TipoEquipe) {
      console.log('Inicializando TipoEquipe...');
      await db.TipoEquipe.insertDefaultValues();
    }
    
    // Inicializa TipoPosicao
    if (db.TipoPosicao) {
      console.log('Inicializando TipoPosicao...');
      await db.TipoPosicao.insertDefaultValues();
    }
    
    // Inicializa TipoMetodoPagamento
    if (db.TipoMetodoPagamento) {
      console.log('Inicializando TipoMetodoPagamento...');
      await db.TipoMetodoPagamento.insertDefaultValues();
    }
    
    // Inicializa StatusPagamento
    if (db.StatusPagamento) {
      console.log('Inicializando StatusPagamento...');
      await db.StatusPagamento.insertDefaultValues();
    }
    
    // Inicializa StatusTreino
    if (db.StatusTreino) {
      console.log('Inicializando StatusTreino...');
      await db.StatusTreino.insertDefaultValues();
    }
    
    // Inicializa StatusConexaoAtleta
    if (db.StatusConexaoAtleta) {
      console.log('Inicializando StatusConexaoAtleta...');
      await db.StatusConexaoAtleta.insertDefaultValues();
    }
    
    // Inicializa TipoNotificacao
    if (db.TipoNotificacao) {
      console.log('Inicializando TipoNotificacao...');
      await db.TipoNotificacao.insertDefaultValues();
    }
    
    // Inicializa TipoConfiguracao
    if (db.TipoConfiguracao) {
      console.log('Inicializando TipoConfiguracao...');
      await db.TipoConfiguracao.insertDefaultValues();
    }
    
    // Inicializa DificuldadeItemTreino
    if (db.DificuldadeItemTreino) {
      console.log('Inicializando DificuldadeItemTreino...');
      await db.DificuldadeItemTreino.insertDefaultValues();
    }
    
    // Inicializa TipoEquipeJogo
    if (db.TipoEquipeJogo) {
      console.log('Inicializando TipoEquipeJogo...');
      await db.TipoEquipeJogo.insertDefaultValues();
    }
    
    // Inicializa TipoResultadoJogada
    if (db.TipoResultadoJogada) {
      console.log('Inicializando TipoResultadoJogada...');
      await db.TipoResultadoJogada.insertDefaultValues();
    }
    
    // Inicializa TipoPonto
    if (db.TipoPonto) {
      console.log('Inicializando TipoPonto...');
      await db.TipoPonto.insertDefaultValues();
    }
    
    // Inicializa TipoLog
    if (db.TipoLog) {
      console.log('Inicializando TipoLog...');
      await db.TipoLog.insertDefaultValues();
    }
    
    // Inicializa TipoPeriodicidade
    if (db.TipoPeriodicidade) {
      console.log('Inicializando TipoPeriodicidade...');
      await db.TipoPeriodicidade.insertDefaultValues();
    }
    
    // Inicializa StatusProfissionalAtleta
    if (db.StatusProfissionalAtleta) {
      console.log('Inicializando StatusProfissionalAtleta...');
      await db.StatusProfissionalAtleta.insertDefaultValues();
    }
    
    // Inicializa TipoEndereco
    if (db.TipoEndereco) {
      console.log('Inicializando TipoEndereco...');
      await db.TipoEndereco.insertDefaultValues();
    }
    
    // Inicializa estruturas adicionais se necessário
    if (db.UsuarioTipo) {
      console.log('Verificando estrutura de UsuarioTipo...');
      // Não há valores padrão para inicializar, apenas verificamos a estrutura
    }
    
    if (db.Endereco) {
      console.log('Verificando estrutura de Endereco...');
      // Não há valores padrão para inicializar, apenas verificamos a estrutura
    }
    
    console.log('Todas as tabelas de tipos foram inicializadas com sucesso!');
  } catch (error) {
    console.error('Erro ao inicializar tabelas de tipos:', error);
    throw error;
  }
}

module.exports = initializeEnumTables;
