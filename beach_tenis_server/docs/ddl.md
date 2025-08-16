# Schema de Banco de Dados - App 40x40 Beach Tennis

## 🗄️ Estrutura Completa de Banco de Dados

### Visão Geral

- **Suporte Multi-tenant**: Diferentes tipos de usuários
- **Flexibilidade**: Expansão para novos perfis
- **Integridade**: Relacionamentos bem definidos
- **Performance**: Índices otimizados
- **Auditoria**: Logs de alterações

---

## 📊 DDL MySQL

```sql
-- ============================================
-- SCHEMA 40X40 BEACH TENNIS - MySQL
-- ============================================

-- Configurações iniciais
SET foreign_key_checks = 0;
SET sql_mode = 'STRICT_TRANS_TABLES,NO_ZERO_DATE,NO_ZERO_IN_DATE,ERROR_FOR_DIVISION_BY_ZERO';

-- ============================================
-- TABELAS DE CONFIGURAÇÃO E SISTEMA
-- ============================================

-- Tipos de assinatura disponíveis
CREATE TABLE tipos_assinatura (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL UNIQUE,
    descricao TEXT,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Pacotes de pagamento
CREATE TABLE pacotes_pagamento (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo_assinatura_id INT NOT NULL,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    valor DECIMAL(10,2) NOT NULL,
    periodicidade ENUM('MENSAL', 'TRIMESTRAL', 'SEMESTRAL', 'ANUAL') NOT NULL,
    quantidade_alunos INT NULL, -- Só para arenas
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tipo_assinatura_id) REFERENCES tipos_assinatura(id)
);

-- Configurações do sistema
CREATE TABLE configuracoes_sistema (
    id INT AUTO_INCREMENT PRIMARY KEY,
    chave VARCHAR(100) NOT NULL UNIQUE,
    valor TEXT,
    descricao VARCHAR(255),
    tipo ENUM('STRING', 'INTEGER', 'BOOLEAN', 'JSON') DEFAULT 'STRING',
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- TABELA PRINCIPAL DE USUÁRIOS
-- ============================================

CREATE TABLE usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    tipo_principal ENUM('ARENA', 'ATLETA', 'ALUNO', 'PROFESSOR', 'PROFISSIONAL_TECNICO', 'ADMIN') NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    email_verificado BOOLEAN DEFAULT FALSE,
    ultimo_login TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    INDEX idx_email (email),
    INDEX idx_tipo (tipo_principal),
    INDEX idx_ativo (ativo)
);

-- ============================================
-- PERFIS ESPECÍFICOS POR TIPO DE USUÁRIO
-- ============================================

-- Perfil Arena
CREATE TABLE arenas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    cnpj VARCHAR(18) UNIQUE,
    endereco TEXT,
    latitude DECIMAL(10, 8) NULL,
    longitude DECIMAL(11, 8) NULL,
    telefone VARCHAR(20),
    whatsapp BOOLEAN DEFAULT FALSE,
    instagram VARCHAR(100),
    facebook VARCHAR(100),
    status_assinatura ENUM('ATIVO', 'INATIVO', 'SUSPENSO', 'CANCELADO') DEFAULT 'ATIVO',
    data_vencimento DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_cnpj (cnpj),
    INDEX idx_status (status_assinatura)
);

-- Perfil Atleta
CREATE TABLE atletas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    data_nascimento DATE,
    sexo ENUM('MASCULINO', 'FEMININO', 'OUTRO'),
    cidade VARCHAR(100),
    telefone VARCHAR(20),
    whatsapp BOOLEAN DEFAULT FALSE,
    instagram VARCHAR(100),
    facebook VARCHAR(100),
    status_assinatura ENUM('ATIVO', 'INATIVO', 'SUSPENSO', 'CANCELADO') DEFAULT 'ATIVO',
    data_vencimento DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_cpf (cpf),
    INDEX idx_nome (nome),
    INDEX idx_status (status_assinatura)
);

-- Perfil Professor
CREATE TABLE professores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    data_nascimento DATE,
    sexo ENUM('MASCULINO', 'FEMININO', 'OUTRO'),
    telefone VARCHAR(20),
    whatsapp BOOLEAN DEFAULT FALSE,
    instagram VARCHAR(100),
    facebook VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_cpf (cpf),
    INDEX idx_nome (nome),
    INDEX idx_ativo (ativo)
);

-- Perfil Aluno
CREATE TABLE alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    data_nascimento DATE,
    sexo ENUM('MASCULINO', 'FEMININO', 'OUTRO'),
    cidade VARCHAR(100),
    telefone VARCHAR(20),
    whatsapp BOOLEAN DEFAULT FALSE,
    instagram VARCHAR(100),
    facebook VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_cpf (cpf),
    INDEX idx_nome (nome),
    INDEX idx_ativo (ativo)
);

-- Perfil Profissional Técnico
CREATE TABLE profissionais_tecnicos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL UNIQUE,
    nome VARCHAR(255) NOT NULL,
    cpf VARCHAR(14) UNIQUE,
    data_nascimento DATE,
    sexo ENUM('MASCULINO', 'FEMININO', 'OUTRO'),
    telefone VARCHAR(20),
    whatsapp BOOLEAN DEFAULT FALSE,
    instagram VARCHAR(100),
    facebook VARCHAR(100),
    especialidades JSON,
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_cpf (cpf),
    INDEX idx_nome (nome),
    INDEX idx_ativo (ativo)
);

-- ============================================
-- RELACIONAMENTOS ENTRE PERFIS
-- ============================================

-- Professores vinculados a arenas
CREATE TABLE arena_professores (
    id INT AUTO_INCREMENT PRIMARY KEY,
    arena_id INT NOT NULL,
    professor_id INT NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    data_vinculo DATE DEFAULT (CURRENT_DATE),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (arena_id) REFERENCES arenas(id) ON DELETE CASCADE,
    FOREIGN KEY (professor_id) REFERENCES professores(id) ON DELETE CASCADE,
    UNIQUE KEY unique_arena_professor (arena_id, professor_id),
    INDEX idx_arena (arena_id),
    INDEX idx_professor (professor_id)
);

-- Alunos vinculados a arenas
CREATE TABLE arena_alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    arena_id INT NOT NULL,
    aluno_id INT NOT NULL,
    ativo BOOLEAN DEFAULT TRUE,
    data_vinculo DATE DEFAULT (CURRENT_DATE),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (arena_id) REFERENCES arenas(id) ON DELETE CASCADE,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id) ON DELETE CASCADE,
    UNIQUE KEY unique_arena_aluno (arena_id, aluno_id),
    INDEX idx_arena (arena_id),
    INDEX idx_aluno (aluno_id)
);

-- Conexões entre atletas (rede social)
CREATE TABLE conexoes_atletas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    atleta_origem_id INT NOT NULL,
    atleta_destino_id INT NOT NULL,
    status ENUM('PENDENTE', 'ACEITO', 'BLOQUEADO') DEFAULT 'PENDENTE',
    data_solicitacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_resposta TIMESTAMP NULL,
    
    FOREIGN KEY (atleta_origem_id) REFERENCES atletas(id) ON DELETE CASCADE,
    FOREIGN KEY (atleta_destino_id) REFERENCES atletas(id) ON DELETE CASCADE,
    UNIQUE KEY unique_conexao (atleta_origem_id, atleta_destino_id),
    INDEX idx_origem (atleta_origem_id),
    INDEX idx_destino (atleta_destino_id),
    INDEX idx_status (status)
);

-- Profissionais técnicos vinculados a atletas
CREATE TABLE profissional_atletas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    profissional_id INT NOT NULL,
    atleta_id INT NOT NULL,
    status ENUM('PENDENTE', 'ACEITO', 'CANCELADO') DEFAULT 'PENDENTE',
    data_solicitacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_resposta TIMESTAMP NULL,
    
    FOREIGN KEY (profissional_id) REFERENCES profissionais_tecnicos(id) ON DELETE CASCADE,
    FOREIGN KEY (atleta_id) REFERENCES atletas(id) ON DELETE CASCADE,
    UNIQUE KEY unique_prof_atleta (profissional_id, atleta_id),
    INDEX idx_profissional (profissional_id),
    INDEX idx_atleta (atleta_id)
);

-- ============================================
-- SISTEMA DE PAGAMENTOS E ASSINATURAS
-- ============================================

-- Assinaturas ativas
CREATE TABLE assinaturas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    pacote_id INT NOT NULL,
    status ENUM('ATIVA', 'CANCELADA', 'SUSPENSA', 'VENCIDA') DEFAULT 'ATIVA',
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    renovacao_automatica BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (pacote_id) REFERENCES pacotes_pagamento(id),
    INDEX idx_usuario (usuario_id),
    INDEX idx_status (status),
    INDEX idx_vencimento (data_fim)
);

-- Histórico de pagamentos
CREATE TABLE pagamentos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    assinatura_id INT NOT NULL,
    valor DECIMAL(10,2) NOT NULL,
    metodo_pagamento ENUM('CARTAO_CREDITO', 'PIX', 'BOLETO') NOT NULL,
    status ENUM('PENDENTE', 'PROCESSANDO', 'APROVADO', 'RECUSADO', 'CANCELADO') DEFAULT 'PENDENTE',
    referencia_externa VARCHAR(255), -- ID do gateway de pagamento
    dados_pagamento JSON, -- Informações específicas do método
    data_vencimento DATE,
    data_pagamento TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (assinatura_id) REFERENCES assinaturas(id) ON DELETE CASCADE,
    INDEX idx_assinatura (assinatura_id),
    INDEX idx_status (status),
    INDEX idx_referencia (referencia_externa)
);

-- ============================================
-- SISTEMA DE TREINOS E AVALIAÇÕES
-- ============================================

-- Tipos de golpes cadastrados
CREATE TABLE golpes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL UNIQUE,
    descricao TEXT,
    categoria VARCHAR(50),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Itens de treino disponíveis
CREATE TABLE itens_treino (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    categoria VARCHAR(100),
    dificuldade ENUM('INICIANTE', 'INTERMEDIARIO', 'AVANCADO') DEFAULT 'INICIANTE',
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    INDEX idx_categoria (categoria),
    INDEX idx_dificuldade (dificuldade)
);

-- Itens de avaliação
CREATE TABLE itens_avaliacao (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(255) NOT NULL,
    descricao TEXT,
    categoria VARCHAR(100),
    ativo BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Treinos configurados
CREATE TABLE treinos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    professor_id INT NOT NULL,
    aluno_id INT NOT NULL,
    arena_id INT NOT NULL,
    data_treino DATE NOT NULL,
    observacoes TEXT,
    status ENUM('AGENDADO', 'EXECUTADO', 'CANCELADO') DEFAULT 'AGENDADO',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (professor_id) REFERENCES professores(id),
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (arena_id) REFERENCES arenas(id),
    INDEX idx_professor (professor_id),
    INDEX idx_aluno (aluno_id),
    INDEX idx_data (data_treino)
);

-- Itens específicos de cada treino
CREATE TABLE treino_itens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    treino_id INT NOT NULL,
    item_treino_id INT NOT NULL,
    quantidade_prevista INT NOT NULL,
    quantidade_executada INT NULL,
    acertos INT NULL,
    observacoes TEXT,
    
    FOREIGN KEY (treino_id) REFERENCES treinos(id) ON DELETE CASCADE,
    FOREIGN KEY (item_treino_id) REFERENCES itens_treino(id),
    INDEX idx_treino (treino_id)
);

-- Avaliações configuradas
CREATE TABLE avaliacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    professor_id INT NOT NULL,
    aluno_id INT NOT NULL,
    arena_id INT NOT NULL,
    data_avaliacao DATE NOT NULL,
    resultado ENUM('APROVADO', 'REPROVADO', 'PENDENTE') DEFAULT 'PENDENTE',
    observacoes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (professor_id) REFERENCES professores(id),
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (arena_id) REFERENCES arenas(id),
    INDEX idx_professor (professor_id),
    INDEX idx_aluno (aluno_id),
    INDEX idx_data (data_avaliacao)
);

-- Itens específicos de cada avaliação
CREATE TABLE avaliacao_itens (
    id INT AUTO_INCREMENT PRIMARY KEY,
    avaliacao_id INT NOT NULL,
    item_avaliacao_id INT NOT NULL,
    quantidade_prevista INT NOT NULL,
    quantidade_executada INT NULL,
    acertos INT NULL,
    observacoes TEXT,
    
    FOREIGN KEY (avaliacao_id) REFERENCES avaliacoes(id) ON DELETE CASCADE,
    FOREIGN KEY (item_avaliacao_id) REFERENCES itens_avaliacao(id),
    INDEX idx_avaliacao (avaliacao_id)
);

-- ============================================
-- SISTEMA DE JOGOS E PARTIDAS
-- ============================================

-- Jogos registrados
CREATE TABLE jogos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    tipo ENUM('SIMPLES', 'DUPLAS') NOT NULL,
    data_jogo DATE NOT NULL,
    horario_inicio TIME,
    horario_fim TIME,
    local VARCHAR(255),
    arena_id INT NULL, -- Se vinculado a uma arena
    profissional_tecnico_id INT NULL, -- Se tem PT responsável
    status ENUM('AGENDADO', 'EM_ANDAMENTO', 'FINALIZADO', 'CANCELADO') DEFAULT 'AGENDADO',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    
    FOREIGN KEY (arena_id) REFERENCES arenas(id),
    FOREIGN KEY (profissional_tecnico_id) REFERENCES profissionais_tecnicos(id),
    INDEX idx_data (data_jogo),
    INDEX idx_status (status),
    INDEX idx_tipo (tipo)
);

-- Participantes dos jogos
CREATE TABLE jogo_participantes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    jogo_id INT NOT NULL,
    atleta_id INT NOT NULL,
    dupla ENUM('A', 'B') NOT NULL, -- Dupla A ou B
    posicao TINYINT NOT NULL, -- 1 ou 2 dentro da dupla
    
    FOREIGN KEY (jogo_id) REFERENCES jogos(id) ON DELETE CASCADE,
    FOREIGN KEY (atleta_id) REFERENCES atletas(id),
    UNIQUE KEY unique_jogo_atleta (jogo_id, atleta_id),
    INDEX idx_jogo (jogo_id),
    INDEX idx_atleta (atleta_id)
);

-- Sets dos jogos
CREATE TABLE jogo_sets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    jogo_id INT NOT NULL,
    numero_set TINYINT NOT NULL,
    games_dupla_a TINYINT DEFAULT 0,
    games_dupla_b TINYINT DEFAULT 0,
    tiebreak BOOLEAN DEFAULT FALSE,
    pontos_tiebreak_a TINYINT DEFAULT 0,
    pontos_tiebreak_b TINYINT DEFAULT 0,
    vencedor_dupla ENUM('A', 'B') NULL,
    finalizado BOOLEAN DEFAULT FALSE,
    
    FOREIGN KEY (jogo_id) REFERENCES jogos(id) ON DELETE CASCADE,
    UNIQUE KEY unique_jogo_set (jogo_id, numero_set),
    INDEX idx_jogo (jogo_id)
);

-- Games dos sets
CREATE TABLE jogo_games (
    id INT AUTO_INCREMENT PRIMARY KEY,
    set_id INT NOT NULL,
    numero_game TINYINT NOT NULL,
    pontos_dupla_a TINYINT DEFAULT 0,
    pontos_dupla_b TINYINT DEFAULT 0,
    vencedor_dupla ENUM('A', 'B') NULL,
    finalizado BOOLEAN DEFAULT FALSE,
    
    FOREIGN KEY (set_id) REFERENCES jogo_sets(id) ON DELETE CASCADE,
    UNIQUE KEY unique_set_game (set_id, numero_game),
    INDEX idx_set (set_id)
);

-- Pontos individuais (jogadas)
CREATE TABLE jogo_pontos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    game_id INT NOT NULL,
    numero_ponto TINYINT NOT NULL,
    atleta_sacador_id INT NOT NULL,
    vencedor_dupla ENUM('A', 'B') NULL,
    finalizado BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (game_id) REFERENCES jogo_games(id) ON DELETE CASCADE,
    FOREIGN KEY (atleta_sacador_id) REFERENCES atletas(id),
    INDEX idx_game (game_id)
);

-- Jogadas dentro de cada ponto
CREATE TABLE jogo_jogadas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ponto_id INT NOT NULL,
    sequencia TINYINT NOT NULL,
    atleta_id INT NOT NULL,
    golpe_id INT NOT NULL,
    tipo_jogada ENUM('SAQUE', 'DEVOLUCAO', 'ATAQUE', 'DEFESA', 'FINALIZACAO') NOT NULL,
    lado_quadra ENUM('DIREITA', 'ESQUERDA') NULL,
    resultado ENUM('SUCESSO', 'ERRO_FORA', 'ERRO_REDE', 'WINNER') NULL,
    finalizou_ponto BOOLEAN DEFAULT FALSE,
    observacoes TEXT,
    
    FOREIGN KEY (ponto_id) REFERENCES jogo_pontos(id) ON DELETE CASCADE,
    FOREIGN KEY (atleta_id) REFERENCES atletas(id),
    FOREIGN KEY (golpe_id) REFERENCES golpes(id),
    INDEX idx_ponto (ponto_id),
    INDEX idx_atleta (atleta_id)
);

-- ============================================
-- SISTEMA DE NOTIFICAÇÕES
-- ============================================

CREATE TABLE notificacoes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NOT NULL,
    tipo ENUM('SOLICITACAO_AMIGO', 'SOLICITACAO_JOGO', 'SOLICITACAO_PT', 'PAGAMENTO', 'TREINO', 'GERAL') NOT NULL,
    titulo VARCHAR(255) NOT NULL,
    mensagem TEXT NOT NULL,
    dados_extras JSON NULL,
    lida BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    INDEX idx_usuario (usuario_id),
    INDEX idx_tipo (tipo),
    INDEX idx_lida (lida),
    INDEX idx_created (created_at)
);

-- ============================================
-- SISTEMA DE AUDITORIA
-- ============================================

CREATE TABLE logs_sistema (
    id INT AUTO_INCREMENT PRIMARY KEY,
    usuario_id INT NULL,
    acao VARCHAR(100) NOT NULL,
    tabela_afetada VARCHAR(100),
    registro_id INT NULL,
    dados_anteriores JSON NULL,
    dados_novos JSON NULL,
    ip_address VARCHAR(45),
    user_agent TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL,
    INDEX idx_usuario (usuario_id),
    INDEX idx_acao (acao),
    INDEX idx_tabela (tabela_afetada),
    INDEX idx_created (created_at)
);

-- ============================================
-- ÍNDICES ADICIONAIS PARA PERFORMANCE
-- ============================================

-- Índices compostos para queries frequentes
CREATE INDEX idx_treinos_periodo ON treinos(data_treino, professor_id, aluno_id);
CREATE INDEX idx_avaliacoes_periodo ON avaliacoes(data_avaliacao, professor_id, aluno_id);
CREATE INDEX idx_jogos_periodo ON jogos(data_jogo, status);
CREATE INDEX idx_pagamentos_periodo ON pagamentos(created_at, status);

-- ============================================
-- DADOS INICIAIS
-- ============================================

-- Tipos de assinatura
INSERT INTO tipos_assinatura (nome, descricao) VALUES
('ARENA', 'Assinatura para gestão de arenas esportivas'),
('ATLETA', 'Assinatura para atletas profissionais'),
('ALUNO', 'Assinatura para alunos em formação'),
('PROFESSOR', 'Assinatura para professores/instrutores'),
('PROFISSIONAL_TECNICO', 'Assinatura para analistas técnicos');

-- Pacotes básicos
INSERT INTO pacotes_pagamento (tipo_assinatura_id, nome, valor, periodicidade) VALUES
(1, 'Arena Básica', 199.90, 'MENSAL'),
(1, 'Arena Premium', 399.90, 'MENSAL'),
(2, 'Atleta Individual', 49.90, 'MENSAL'),
(2, 'Atleta Pro', 89.90, 'MENSAL'),
(5, 'Profissional Técnico', 79.90, 'MENSAL');

-- Golpes básicos
INSERT INTO golpes (nome, descricao, categoria) VALUES
('Forehand', 'Golpe de direita', 'FUNDO'),
('Backhand', 'Golpe de esquerda', 'FUNDO'),
('Saque', 'Saque inicial', 'SAQUE'),
('Smash', 'Golpe de ataque', 'ATAQUE'),
('Lob', 'Golpe alto', 'DEFESA'),
('Volley', 'Golpe de rede', 'REDE'),
('Drop Shot', 'Deixadinha', 'FINALIZACAO'),
('Bandeja', 'Golpe alto de rede', 'REDE'),
('Víbora', 'Golpe diagonal', 'ATAQUE'),
('Bajada', 'Golpe para baixo', 'ATAQUE');

-- Itens de treino básicos
INSERT INTO itens_treino (nome, categoria, dificuldade) VALUES
('Saque por baixo', 'SAQUE', 'INICIANTE'),
('Saque slice', 'SAQUE', 'INTERMEDIARIO'),
('Devolução cruzada', 'DEVOLUCAO', 'INICIANTE'),
('Forehand paralela', 'FUNDO', 'INTERMEDIARIO'),
('Backhand cruzada', 'FUNDO', 'INTERMEDIARIO'),
('Volley de direita', 'REDE', 'AVANCADO'),
('Smash potência', 'ATAQUE', 'AVANCADO');

-- Configurações do sistema
INSERT INTO configuracoes_sistema (chave, valor, descricao, tipo) VALUES
('app_version', '1.0.0', 'Versão atual do aplicativo', 'STRING'),
('maintenance_mode', 'false', 'Modo manutenção ativo', 'BOOLEAN'),
('max_file_size', '10485760', 'Tamanho máximo de arquivo (bytes)', 'INTEGER'),
('payment_gateway', '{"provider": "stripe", "test_mode": true}', 'Configurações do gateway de pagamento', 'JSON');

SET foreign_key_checks = 1;
```

---

## 📱 DDL SQLite

```sql
-- ============================================
-- SCHEMA 40X40 BEACH TENNIS - SQLite
-- ============================================

-- Habilitar foreign keys
PRAGMA foreign_keys = ON;

-- ============================================
-- TABELAS DE CONFIGURAÇÃO E SISTEMA
-- ============================================

-- Tipos de assinatura disponíveis
CREATE TABLE tipos_assinatura (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL UNIQUE,
    descricao TEXT,
    ativo INTEGER DEFAULT 1,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now'))
);

-- Pacotes de pagamento
CREATE TABLE pacotes_pagamento (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo_assinatura_id INTEGER NOT NULL,
    nome TEXT NOT NULL,
    descricao TEXT,
    valor REAL NOT NULL,
    periodicidade TEXT CHECK(periodicidade IN ('MENSAL', 'TRIMESTRAL', 'SEMESTRAL', 'ANUAL')) NOT NULL,
    quantidade_alunos INTEGER,
    ativo INTEGER DEFAULT 1,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (tipo_assinatura_id) REFERENCES tipos_assinatura(id)
);

-- Configurações do sistema
CREATE TABLE configuracoes_sistema (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    chave TEXT NOT NULL UNIQUE,
    valor TEXT,
    descricao TEXT,
    tipo TEXT CHECK(tipo IN ('STRING', 'INTEGER', 'BOOLEAN', 'JSON')) DEFAULT 'STRING',
    updated_at TEXT DEFAULT (datetime('now'))
);

-- ============================================
-- TABELA PRINCIPAL DE USUÁRIOS
-- ============================================

CREATE TABLE usuarios (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    email TEXT NOT NULL UNIQUE,
    password_hash TEXT NOT NULL,
    tipo_principal TEXT CHECK(tipo_principal IN ('ARENA', 'ATLETA', 'ALUNO', 'PROFESSOR', 'PROFISSIONAL_TECNICO', 'ADMIN')) NOT NULL,
    ativo INTEGER DEFAULT 1,
    email_verificado INTEGER DEFAULT 0,
    ultimo_login TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX idx_usuarios_email ON usuarios(email);
CREATE INDEX idx_usuarios_tipo ON usuarios(tipo_principal);
CREATE INDEX idx_usuarios_ativo ON usuarios(ativo);

-- ============================================
-- PERFIS ESPECÍFICOS POR TIPO DE USUÁRIO
-- ============================================

-- Perfil Arena
CREATE TABLE arenas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL UNIQUE,
    nome TEXT NOT NULL,
    cnpj TEXT UNIQUE,
    endereco TEXT,
    latitude REAL,
    longitude REAL,
    telefone TEXT,
    whatsapp INTEGER DEFAULT 0,
    instagram TEXT,
    facebook TEXT,
    status_assinatura TEXT CHECK(status_assinatura IN ('ATIVO', 'INATIVO', 'SUSPENSO', 'CANCELADO')) DEFAULT 'ATIVO',
    data_vencimento TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE INDEX idx_arenas_cnpj ON arenas(cnpj);
CREATE INDEX idx_arenas_status ON arenas(status_assinatura);

-- Perfil Atleta
CREATE TABLE atletas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL UNIQUE,
    nome TEXT NOT NULL,
    cpf TEXT UNIQUE,
    data_nascimento TEXT,
    sexo TEXT CHECK(sexo IN ('MASCULINO', 'FEMININO', 'OUTRO')),
    cidade TEXT,
    telefone TEXT,
    whatsapp INTEGER DEFAULT 0,
    instagram TEXT,
    facebook TEXT,
    status_assinatura TEXT CHECK(status_assinatura IN ('ATIVO', 'INATIVO', 'SUSPENSO', 'CANCELADO')) DEFAULT 'ATIVO',
    data_vencimento TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE INDEX idx_atletas_cpf ON atletas(cpf);
CREATE INDEX idx_atletas_nome ON atletas(nome);
CREATE INDEX idx_atletas_status ON atletas(status_assinatura);

-- Perfil Professor
CREATE TABLE professores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL UNIQUE,
    nome TEXT NOT NULL,
    cpf TEXT UNIQUE,
    data_nascimento TEXT,
    sexo TEXT CHECK(sexo IN ('MASCULINO', 'FEMININO', 'OUTRO')),
    telefone TEXT,
    whatsapp INTEGER DEFAULT 0,
    instagram TEXT,
    facebook TEXT,
    ativo INTEGER DEFAULT 1,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE INDEX idx_professores_cpf ON professores(cpf);
CREATE INDEX idx_professores_nome ON professores(nome);
CREATE INDEX idx_professores_ativo ON professores(ativo);

-- Perfil Aluno
CREATE TABLE alunos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL UNIQUE,
    nome TEXT NOT NULL,
    cpf TEXT UNIQUE,
    data_nascimento TEXT,
    sexo TEXT CHECK(sexo IN ('MASCULINO', 'FEMININO', 'OUTRO')),
    cidade TEXT,
    telefone TEXT,
    whatsapp INTEGER DEFAULT 0,
    instagram TEXT,
    facebook TEXT,
    ativo INTEGER DEFAULT 1,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE INDEX idx_alunos_cpf ON alunos(cpf);
CREATE INDEX idx_alunos_nome ON alunos(nome);
CREATE INDEX idx_alunos_ativo ON alunos(ativo);

-- Perfil Profissional Técnico
CREATE TABLE profissionais_tecnicos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL UNIQUE,
    nome TEXT NOT NULL,
    cpf TEXT UNIQUE,
    data_nascimento TEXT,
    sexo TEXT CHECK(sexo IN ('MASCULINO', 'FEMININO', 'OUTRO')),
    telefone TEXT,
    whatsapp INTEGER DEFAULT 0,
    instagram TEXT,
    facebook TEXT,
    especialidades TEXT, -- JSON como TEXT no SQLite
    ativo INTEGER DEFAULT 1,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE INDEX idx_profissionais_cpf ON profissionais_tecnicos(cpf);
CREATE INDEX idx_profissionais_nome ON profissionais_tecnicos(nome);
CREATE INDEX idx_profissionais_ativo ON profissionais_tecnicos(ativo);

-- ============================================
-- RELACIONAMENTOS ENTRE PERFIS
-- ============================================

-- Professores vinculados a arenas
CREATE TABLE arena_professores (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    arena_id INTEGER NOT NULL,
    professor_id INTEGER NOT NULL,
    ativo INTEGER DEFAULT 1,
    data_vinculo TEXT DEFAULT (date('now')),
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (arena_id) REFERENCES arenas(id) ON DELETE CASCADE,
    FOREIGN KEY (professor_id) REFERENCES professores(id) ON DELETE CASCADE,
    UNIQUE(arena_id, professor_id)
);

CREATE INDEX idx_arena_professores_arena ON arena_professores(arena_id);
CREATE INDEX idx_arena_professores_professor ON arena_professores(professor_id);

-- Alunos vinculados a arenas
CREATE TABLE arena_alunos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    arena_id INTEGER NOT NULL,
    aluno_id INTEGER NOT NULL,
    ativo INTEGER DEFAULT 1,
    data_vinculo TEXT DEFAULT (date('now')),
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (arena_id) REFERENCES arenas(id) ON DELETE CASCADE,
    FOREIGN KEY (aluno_id) REFERENCES alunos(id) ON DELETE CASCADE,
    UNIQUE(arena_id, aluno_id)
);

CREATE INDEX idx_arena_alunos_arena ON arena_alunos(arena_id);
CREATE INDEX idx_arena_alunos_aluno ON arena_alunos(aluno_id);

-- Conexões entre atletas (rede social)
CREATE TABLE conexoes_atletas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    atleta_origem_id INTEGER NOT NULL,
    atleta_destino_id INTEGER NOT NULL,
    status TEXT CHECK(status IN ('PENDENTE', 'ACEITO', 'BLOQUEADO')) DEFAULT 'PENDENTE',
    data_solicitacao TEXT DEFAULT (datetime('now')),
    data_resposta TEXT,
    FOREIGN KEY (atleta_origem_id) REFERENCES atletas(id) ON DELETE CASCADE,
    FOREIGN KEY (atleta_destino_id) REFERENCES atletas(id) ON DELETE CASCADE,
    UNIQUE(atleta_origem_id, atleta_destino_id)
);

CREATE INDEX idx_conexoes_origem ON conexoes_atletas(atleta_origem_id);
CREATE INDEX idx_conexoes_destino ON conexoes_atletas(atleta_destino_id);
CREATE INDEX idx_conexoes_status ON conexoes_atletas(status);

-- Profissionais técnicos vinculados a atletas
CREATE TABLE profissional_atletas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    profissional_id INTEGER NOT NULL,
    atleta_id INTEGER NOT NULL,
    status TEXT CHECK(status IN ('PENDENTE', 'ACEITO', 'CANCELADO')) DEFAULT 'PENDENTE',
    data_solicitacao TEXT DEFAULT (datetime('now')),
    data_resposta TEXT,
    FOREIGN KEY (profissional_id) REFERENCES profissionais_tecnicos(id) ON DELETE CASCADE,
    FOREIGN KEY (atleta_id) REFERENCES atletas(id) ON DELETE CASCADE,
    UNIQUE(profissional_id, atleta_id)
);

CREATE INDEX idx_profissional_atletas_prof ON profissional_atletas(profissional_id);
CREATE INDEX idx_profissional_atletas_atleta ON profissional_atletas(atleta_id);

-- ============================================
-- SISTEMA DE PAGAMENTOS E ASSINATURAS
-- ============================================

-- Assinaturas ativas
CREATE TABLE assinaturas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL,
    pacote_id INTEGER NOT NULL,
    status TEXT CHECK(status IN ('ATIVA', 'CANCELADA', 'SUSPENSA', 'VENCIDA')) DEFAULT 'ATIVA',
    data_inicio TEXT NOT NULL,
    data_fim TEXT NOT NULL,
    renovacao_automatica INTEGER DEFAULT 1,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE,
    FOREIGN KEY (pacote_id) REFERENCES pacotes_pagamento(id)
);

CREATE INDEX idx_assinaturas_usuario ON assinaturas(usuario_id);
CREATE INDEX idx_assinaturas_status ON assinaturas(status);
CREATE INDEX idx_assinaturas_vencimento ON assinaturas(data_fim);

-- Histórico de pagamentos
CREATE TABLE pagamentos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    assinatura_id INTEGER NOT NULL,
    valor REAL NOT NULL,
    metodo_pagamento TEXT CHECK(metodo_pagamento IN ('CARTAO_CREDITO', 'PIX', 'BOLETO')) NOT NULL,
    status TEXT CHECK(status IN ('PENDENTE', 'PROCESSANDO', 'APROVADO', 'RECUSADO', 'CANCELADO')) DEFAULT 'PENDENTE',
    referencia_externa TEXT,
    dados_pagamento TEXT, -- JSON como TEXT
    data_vencimento TEXT,
    data_pagamento TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (assinatura_id) REFERENCES assinaturas(id) ON DELETE CASCADE
);

CREATE INDEX idx_pagamentos_assinatura ON pagamentos(assinatura_id);
CREATE INDEX idx_pagamentos_status ON pagamentos(status);
CREATE INDEX idx_pagamentos_referencia ON pagamentos(referencia_externa);

-- ============================================
-- SISTEMA DE TREINOS E AVALIAÇÕES
-- ============================================

-- Tipos de golpes cadastrados
CREATE TABLE golpes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL UNIQUE,
    descricao TEXT,
    categoria TEXT,
    ativo INTEGER DEFAULT 1,
    created_at TEXT DEFAULT (datetime('now'))
);

-- Itens de treino disponíveis
CREATE TABLE itens_treino (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT,
    categoria TEXT,
    dificuldade TEXT CHECK(dificuldade IN ('INICIANTE', 'INTERMEDIARIO', 'AVANCADO')) DEFAULT 'INICIANTE',
    ativo INTEGER DEFAULT 1,
    created_at TEXT DEFAULT (datetime('now'))
);

CREATE INDEX idx_itens_treino_categoria ON itens_treino(categoria);
CREATE INDEX idx_itens_treino_dificuldade ON itens_treino(dificuldade);

-- Itens de avaliação
CREATE TABLE itens_avaliacao (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    nome TEXT NOT NULL,
    descricao TEXT,
    categoria TEXT,
    ativo INTEGER DEFAULT 1,
    created_at TEXT DEFAULT (datetime('now'))
);

-- Treinos configurados
CREATE TABLE treinos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    professor_id INTEGER NOT NULL,
    aluno_id INTEGER NOT NULL,
    arena_id INTEGER NOT NULL,
    data_treino TEXT NOT NULL,
    observacoes TEXT,
    status TEXT CHECK(status IN ('AGENDADO', 'EXECUTADO', 'CANCELADO')) DEFAULT 'AGENDADO',
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (professor_id) REFERENCES professores(id),
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (arena_id) REFERENCES arenas(id)
);

CREATE INDEX idx_treinos_professor ON treinos(professor_id);
CREATE INDEX idx_treinos_aluno ON treinos(aluno_id);
CREATE INDEX idx_treinos_data ON treinos(data_treino);

-- Itens específicos de cada treino
CREATE TABLE treino_itens (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    treino_id INTEGER NOT NULL,
    item_treino_id INTEGER NOT NULL,
    quantidade_prevista INTEGER NOT NULL,
    quantidade_executada INTEGER,
    acertos INTEGER,
    observacoes TEXT,
    FOREIGN KEY (treino_id) REFERENCES treinos(id) ON DELETE CASCADE,
    FOREIGN KEY (item_treino_id) REFERENCES itens_treino(id)
);

CREATE INDEX idx_treino_itens_treino ON treino_itens(treino_id);

-- Avaliações configuradas
CREATE TABLE avaliacoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    professor_id INTEGER NOT NULL,
    aluno_id INTEGER NOT NULL,
    arena_id INTEGER NOT NULL,
    data_avaliacao TEXT NOT NULL,
    resultado TEXT CHECK(resultado IN ('APROVADO', 'REPROVADO', 'PENDENTE')) DEFAULT 'PENDENTE',
    observacoes TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (professor_id) REFERENCES professores(id),
    FOREIGN KEY (aluno_id) REFERENCES alunos(id),
    FOREIGN KEY (arena_id) REFERENCES arenas(id)
);

CREATE INDEX idx_avaliacoes_professor ON avaliacoes(professor_id);
CREATE INDEX idx_avaliacoes_aluno ON avaliacoes(aluno_id);
CREATE INDEX idx_avaliacoes_data ON avaliacoes(data_avaliacao);

-- Itens específicos de cada avaliação
CREATE TABLE avaliacao_itens (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    avaliacao_id INTEGER NOT NULL,
    item_avaliacao_id INTEGER NOT NULL,
    quantidade_prevista INTEGER NOT NULL,
    quantidade_executada INTEGER,
    acertos INTEGER,
    observacoes TEXT,
    FOREIGN KEY (avaliacao_id) REFERENCES avaliacoes(id) ON DELETE CASCADE,
    FOREIGN KEY (item_avaliacao_id) REFERENCES itens_avaliacao(id)
);

CREATE INDEX idx_avaliacao_itens_avaliacao ON avaliacao_itens(avaliacao_id);

-- ============================================
-- SISTEMA DE JOGOS E PARTIDAS
-- ============================================

-- Jogos registrados
CREATE TABLE jogos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    tipo TEXT CHECK(tipo IN ('SIMPLES', 'DUPLAS')) NOT NULL,
    data_jogo TEXT NOT NULL,
    horario_inicio TEXT,
    horario_fim TEXT,
    local TEXT,
    arena_id INTEGER,
    profissional_tecnico_id INTEGER,
    status TEXT CHECK(status IN ('AGENDADO', 'EM_ANDAMENTO', 'FINALIZADO', 'CANCELADO')) DEFAULT 'AGENDADO',
    created_at TEXT DEFAULT (datetime('now')),
    updated_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (arena_id) REFERENCES arenas(id),
    FOREIGN KEY (profissional_tecnico_id) REFERENCES profissionais_tecnicos(id)
);

CREATE INDEX idx_jogos_data ON jogos(data_jogo);
CREATE INDEX idx_jogos_status ON jogos(status);
CREATE INDEX idx_jogos_tipo ON jogos(tipo);

-- Participantes dos jogos
CREATE TABLE jogo_participantes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    jogo_id INTEGER NOT NULL,
    atleta_id INTEGER NOT NULL,
    dupla TEXT CHECK(dupla IN ('A', 'B')) NOT NULL,
    posicao INTEGER NOT NULL CHECK(posicao IN (1, 2)),
    FOREIGN KEY (jogo_id) REFERENCES jogos(id) ON DELETE CASCADE,
    FOREIGN KEY (atleta_id) REFERENCES atletas(id),
    UNIQUE(jogo_id, atleta_id)
);

CREATE INDEX idx_jogo_participantes_jogo ON jogo_participantes(jogo_id);
CREATE INDEX idx_jogo_participantes_atleta ON jogo_participantes(atleta_id);

-- Sets dos jogos
CREATE TABLE jogo_sets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    jogo_id INTEGER NOT NULL,
    numero_set INTEGER NOT NULL,
    games_dupla_a INTEGER DEFAULT 0,
    games_dupla_b INTEGER DEFAULT 0,
    tiebreak INTEGER DEFAULT 0,
    pontos_tiebreak_a INTEGER DEFAULT 0,
    pontos_tiebreak_b INTEGER DEFAULT 0,
    vencedor_dupla TEXT CHECK(vencedor_dupla IN ('A', 'B')),
    finalizado INTEGER DEFAULT 0,
    FOREIGN KEY (jogo_id) REFERENCES jogos(id) ON DELETE CASCADE,
    UNIQUE(jogo_id, numero_set)
);

CREATE INDEX idx_jogo_sets_jogo ON jogo_sets(jogo_id);

-- Games dos sets
CREATE TABLE jogo_games (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    set_id INTEGER NOT NULL,
    numero_game INTEGER NOT NULL,
    pontos_dupla_a INTEGER DEFAULT 0,
    pontos_dupla_b INTEGER DEFAULT 0,
    vencedor_dupla TEXT CHECK(vencedor_dupla IN ('A', 'B')),
    finalizado INTEGER DEFAULT 0,
    FOREIGN KEY (set_id) REFERENCES jogo_sets(id) ON DELETE CASCADE,
    UNIQUE(set_id, numero_game)
);

CREATE INDEX idx_jogo_games_set ON jogo_games(set_id);

-- Pontos individuais (jogadas)
CREATE TABLE jogo_pontos (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    game_id INTEGER NOT NULL,
    numero_ponto INTEGER NOT NULL,
    atleta_sacador_id INTEGER NOT NULL,
    vencedor_dupla TEXT CHECK(vencedor_dupla IN ('A', 'B')),
    finalizado INTEGER DEFAULT 0,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (game_id) REFERENCES jogo_games(id) ON DELETE CASCADE,
    FOREIGN KEY (atleta_sacador_id) REFERENCES atletas(id)
);

CREATE INDEX idx_jogo_pontos_game ON jogo_pontos(game_id);

-- Jogadas dentro de cada ponto
CREATE TABLE jogo_jogadas (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    ponto_id INTEGER NOT NULL,
    sequencia INTEGER NOT NULL,
    atleta_id INTEGER NOT NULL,
    golpe_id INTEGER NOT NULL,
    tipo_jogada TEXT CHECK(tipo_jogada IN ('SAQUE', 'DEVOLUCAO', 'ATAQUE', 'DEFESA', 'FINALIZACAO')) NOT NULL,
    lado_quadra TEXT CHECK(lado_quadra IN ('DIREITA', 'ESQUERDA')),
    resultado TEXT CHECK(resultado IN ('SUCESSO', 'ERRO_FORA', 'ERRO_REDE', 'WINNER')),
    finalizou_ponto INTEGER DEFAULT 0,
    observacoes TEXT,
    FOREIGN KEY (ponto_id) REFERENCES jogo_pontos(id) ON DELETE CASCADE,
    FOREIGN KEY (atleta_id) REFERENCES atletas(id),
    FOREIGN KEY (golpe_id) REFERENCES golpes(id)
);

CREATE INDEX idx_jogo_jogadas_ponto ON jogo_jogadas(ponto_id);
CREATE INDEX idx_jogo_jogadas_atleta ON jogo_jogadas(atleta_id);

-- ============================================
-- SISTEMA DE NOTIFICAÇÕES
-- ============================================

CREATE TABLE notificacoes (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER NOT NULL,
    tipo TEXT CHECK(tipo IN ('SOLICITACAO_AMIGO', 'SOLICITACAO_JOGO', 'SOLICITACAO_PT', 'PAGAMENTO', 'TREINO', 'GERAL')) NOT NULL,
    titulo TEXT NOT NULL,
    mensagem TEXT NOT NULL,
    dados_extras TEXT, -- JSON como TEXT
    lida INTEGER DEFAULT 0,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE CASCADE
);

CREATE INDEX idx_notificacoes_usuario ON notificacoes(usuario_id);
CREATE INDEX idx_notificacoes_tipo ON notificacoes(tipo);
CREATE INDEX idx_notificacoes_lida ON notificacoes(lida);
CREATE INDEX idx_notificacoes_created ON notificacoes(created_at);

-- ============================================
-- SISTEMA DE AUDITORIA
-- ============================================

CREATE TABLE logs_sistema (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    usuario_id INTEGER,
    acao TEXT NOT NULL,
    tabela_afetada TEXT,
    registro_id INTEGER,
    dados_anteriores TEXT, -- JSON como TEXT
    dados_novos TEXT, -- JSON como TEXT
    ip_address TEXT,
    user_agent TEXT,
    created_at TEXT DEFAULT (datetime('now')),
    FOREIGN KEY (usuario_id) REFERENCES usuarios(id) ON DELETE SET NULL
);

CREATE INDEX idx_logs_usuario ON logs_sistema(usuario_id);
CREATE INDEX idx_logs_acao ON logs_sistema(acao);
CREATE INDEX idx_logs_tabela ON logs_sistema(tabela_afetada);
CREATE INDEX idx_logs_created ON logs_sistema(created_at);

-- ============================================
-- ÍNDICES COMPOSTOS PARA PERFORMANCE
-- ============================================

CREATE INDEX idx_treinos_periodo ON treinos(data_treino, professor_id, aluno_id);
CREATE INDEX idx_avaliacoes_periodo ON avaliacoes(data_avaliacao, professor_id, aluno_id);
CREATE INDEX idx_jogos_periodo ON jogos(data_jogo, status);
CREATE INDEX idx_pagamentos_periodo ON pagamentos(created_at, status);

-- ============================================
-- TRIGGERS PARA CONTROLE DE DATA
-- ============================================

-- Trigger para atualizar updated_at automaticamente
CREATE TRIGGER update_usuarios_timestamp 
    AFTER UPDATE ON usuarios
BEGIN
    UPDATE usuarios SET updated_at = datetime('now') WHERE id = NEW.id;
END;

CREATE TRIGGER update_arenas_timestamp 
    AFTER UPDATE ON arenas
BEGIN
    UPDATE arenas SET updated_at = datetime('now') WHERE id = NEW.id;
END;

CREATE TRIGGER update_atletas_timestamp 
    AFTER UPDATE ON atletas
BEGIN
    UPDATE atletas SET updated_at = datetime('now') WHERE id = NEW.id;
END;

CREATE TRIGGER update_professores_timestamp 
    AFTER UPDATE ON professores
BEGIN
    UPDATE professores SET updated_at = datetime('now') WHERE id = NEW.id;
END;

CREATE TRIGGER update_alunos_timestamp 
    AFTER UPDATE ON alunos
BEGIN
    UPDATE alunos SET updated_at = datetime('now') WHERE id = NEW.id;
END;

CREATE TRIGGER update_profissionais_timestamp 
    AFTER UPDATE ON profissionais_tecnicos
BEGIN
    UPDATE profissionais_tecnicos SET updated_at = datetime('now') WHERE id = NEW.id;
END;

-- ============================================
-- DADOS INICIAIS
-- ============================================

-- Tipos de assinatura
INSERT INTO tipos_assinatura (nome, descricao) VALUES
('ARENA', 'Assinatura para gestão de arenas esportivas'),
('ATLETA', 'Assinatura para atletas profissionais'),
('ALUNO', 'Assinatura para alunos em formação'),
('PROFESSOR', 'Assinatura para professores/instrutores'),
('PROFISSIONAL_TECNICO', 'Assinatura para analistas técnicos');

-- Pacotes básicos
INSERT INTO pacotes_pagamento (tipo_assinatura_id, nome, valor, periodicidade) VALUES
(1, 'Arena Básica', 199.90, 'MENSAL'),
(1, 'Arena Premium', 399.90, 'MENSAL'),
(2, 'Atleta Individual', 49.90, 'MENSAL'),
(2, 'Atleta Pro', 89.90, 'MENSAL'),
(5, 'Profissional Técnico', 79.90, 'MENSAL');

-- Golpes básicos
INSERT INTO golpes (nome, descricao, categoria) VALUES
('Forehand', 'Golpe de direita', 'FUNDO'),
('Backhand', 'Golpe de esquerda', 'FUNDO'),
('Saque', 'Saque inicial', 'SAQUE'),
('Smash', 'Golpe de ataque', 'ATAQUE'),
('Lob', 'Golpe alto', 'DEFESA'),
('Volley', 'Golpe de rede', 'REDE'),
('Drop Shot', 'Deixadinha', 'FINALIZACAO'),
('Bandeja', 'Golpe alto de rede', 'REDE'),
('Víbora', 'Golpe diagonal', 'ATAQUE'),
('Bajada', 'Golpe para baixo', 'ATAQUE');

-- Itens de treino básicos
INSERT INTO itens_treino (nome, categoria, dificuldade) VALUES
('Saque por baixo', 'SAQUE', 'INICIANTE'),
('Saque slice', 'SAQUE', 'INTERMEDIARIO'),
('Devolução cruzada', 'DEVOLUCAO', 'INICIANTE'),
('Forehand paralela', 'FUNDO', 'INTERMEDIARIO'),
('Backhand cruzada', 'FUNDO', 'INTERMEDIARIO'),
('Volley de direita', 'REDE', 'AVANCADO'),
('Smash potência', 'ATAQUE', 'AVANCADO');

-- Itens de avaliação básicos
INSERT INTO itens_avaliacao (nome, categoria) VALUES
('Precisão do saque', 'SAQUE'),
('Consistência na devolução', 'DEVOLUCAO'),
('Controle de bola', 'CONTROLE'),
('Finalização de pontos', 'ATAQUE'),
('Posicionamento em quadra', 'TATICA'),
('Movimentação lateral', 'MOVIMENTO'),
('Reação na rede', 'REDE');

-- Configurações do sistema
INSERT INTO configuracoes_sistema (chave, valor, descricao, tipo) VALUES
('app_version', '1.0.0', 'Versão atual do aplicativo', 'STRING'),
('maintenance_mode', '0', 'Modo manutenção ativo', 'BOOLEAN'),
('max_file_size', '10485760', 'Tamanho máximo de arquivo (bytes)', 'INTEGER'),
('payment_gateway', '{"provider": "stripe", "test_mode": true}', 'Configurações do gateway de pagamento', 'JSON');
```

---

## 🎯 Estrutura de API Recomendada

### Endpoints Principais

#### Autenticação

```
POST   /api/auth/login
POST   /api/auth/register
POST   /api/auth/refresh
POST   /api/auth/logout
POST   /api/auth/forgot-password
POST   /api/auth/reset-password
```

#### Usuários e Perfis

```
GET    /api/users/profile
PUT    /api/users/profile
GET    /api/users/types
POST   /api/users/switch-profile

POST   /api/arenas
GET    /api/arenas/{id}
PUT    /api/arenas/{id}

POST   /api/atletas
GET    /api/atletas/{id}
PUT    /api/atletas/{id}
```

#### Relacionamentos

```
GET    /api/arenas/{id}/professores
POST   /api/arenas/{id}/professores
DELETE /api/arenas/{id}/professores/{professorId}

GET    /api/arenas/{id}/alunos
POST   /api/arenas/{id}/alunos
DELETE /api/arenas/{id}/alunos/{alunoId}

GET    /api/atletas/{id}/conexoes
POST   /api/atletas/{id}/conexoes
PUT    /api/atletas/{id}/conexoes/{conexaoId}
```

#### Treinos e Avaliações

```
GET    /api/treinos
POST   /api/treinos
GET    /api/treinos/{id}
PUT    /api/treinos/{id}
DELETE /api/treinos/{id}

GET    /api/avaliacoes
POST   /api/avaliacoes
GET    /api/avaliacoes/{id}
PUT    /api/avaliacoes/{id}
```

#### Jogos e Estatísticas

```
GET    /api/jogos
POST   /api/jogos
GET    /api/jogos/{id}
PUT    /api/jogos/{id}

GET    /api/jogos/{id}/pontos
POST   /api/jogos/{id}/pontos
PUT    /api/jogos/{id}/pontos/{pontoId}

GET    /api/estatisticas/individuais
GET    /api/estatisticas/duplas
GET    /api/estatisticas/comparativas
```

#### Pagamentos

```
GET    /api/assinaturas
POST   /api/assinaturas
PUT    /api/assinaturas/{id}

GET    /api/pagamentos
POST   /api/pagamentos
GET    /api/pagamentos/{id}/status

GET    /api/pacotes
```

#### Sistema e Configurações

```
GET    /api/configuracoes
GET    /api/golpes
GET    /api/itens-treino
GET    /api/itens-avaliacao

GET    /api/notificacoes
PUT    /api/notificacoes/{id}/lida
DELETE /api/notificacoes/{id}
```

---

## 📊 Considerações de Performance

### Índices Estratégicos

- **Queries frequentes**: Índices compostos para consultas comuns
- **Relacionamentos**: Índices em foreign keys
- **Busca de texto**: Índices em campos de nome/email
- **Filtros temporais**: Índices em campos de data

### Otimizações

- **Paginação**: Implementar limit/offset em listas grandes
- **Cache**: Redis para dados frequentemente acessados
- **Soft delete**: Manter registros para auditoria
- **Particionamento**: Dividir logs por período

### Backup e Sincronização

- **SQLite local**: Cache offline para mobile
- **Sincronização**: API para upload/download de dados
- **Conflitos**: Estratégias de merge para dados conflitantes
- **Versionamento**: Controle de versão do schema

---

## 🔒 Segurança e Compliance

### Proteção de Dados

- **Criptografia**: Senhas com bcrypt
- **LGPD**: Campos para consentimento/exclusão
- **Auditoria**: Logs completos de alterações
- **Tokens**: JWT com refresh tokens

### Validações

- **CPF/CNPJ**: Validação de documentos brasileiros
- **Email**: Verificação obrigatória
- **Telefone**: Validação de formato
- **Pagamentos**: Integração segura com gateways

Este schema de banco de dados fornece uma base sólida e escalável para o aplicativo 40x40, contemplando todos os aspectos identificados na documentação das telas e considerando as necessidades específicas de um aplicativo de gestão esportiva com múltiplos perfis de usuário.
