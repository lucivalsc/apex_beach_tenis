# Análise Técnica Completa - Aplicativo Apex Sports - Beach Tenis

## 📱 Visão Geral do Projeto

### Identidade Visual

- **Nome**: Apex Sports - Beach Tenis - Análise de Alto Rendimento
- **Mascote**: Pato estilizado com capacete colorido e asas abertas
- **Paleta de Cores**:
  - Azul primário: `#4A90E2`
  - Azul claro: `#87CEEB`
  - Branco: `#FFFFFF`
  - Cinza claro: `#F5F5F5`
  - Verde sucesso: `#4CAF50`
  - Vermelho erro: `#F44336`
  - Amarelo aviso: `#FFC107`

### Arquitetura de Usuários

O aplicativo suporta 5 perfis distintos:

1. **Arena** - Gestão de espaços esportivos
2. **Atleta** - Jogadores profissionais
3. **Aluno** - Estudantes em formação
4. **Professor** - Instrutores especializados
5. **Profissional Técnico** - Analistas de performance

---

## 🔐 Módulo de Autenticação

### TELA 1 - Splash/Landing Page

**Descrição Geral**: Tela inicial de apresentação do aplicativo com fundo azul degradê.

**Elementos Visuais**:

- **Fundo**: Gradiente azul claro no topo transitando para azul escuro na base
- **StatusBar**: Horário "08:00" no canto superior esquerdo, ícones de conectividade (WiFi, sinal, bateria) no superior direito
- **Logo Central**:
  - Mascote do pato posicionado centralmente, ocupando aproximadamente 20% da altura da tela
  - Pato verde com capacete colorido (verde, roxo, azul) e asas brancas abertas
  - Abaixo do mascote: texto "Apex Sports - Beach Tenis" em fonte bold, cor vermelha
  - Subtítulo "ANÁLISE DE ALTO RENDIMENTO" em fonte menor, cor branca

**Elemento de Ação**:

- **Botão "Entrar"**:
  - Posicionado na parte inferior central
  - Cor de fundo azul primário (#4A90E2)
  - Texto branco, fonte média-grande
  - Bordas arredondadas
  - Largura: 80% da tela
  - Altura: Aproximadamente 50px

**Elemento Inferior**:

- **Toggle Modo Escuro**:
  - Posicionado no canto inferior
  - Switch com círculo branco
  - Texto "Modo escuro" ao lado
  - Estado atual: desabilitado (círculo à esquerda)

### TELA 1.1 - Autenticação com Abas

**Descrição Geral**: Evolução da tela anterior com sistema de abas para login e registro.

**Estrutura Superior**:

- Mantém o mesmo header e logo da tela anterior
- **Sistema de Abas**:
  - Duas abas horizontais: "Entrar" e "Registrar"
  - Aba ativa: fundo branco, texto azul
  - Aba inativa: fundo transparente, texto cinza claro
  - Largura: cada aba ocupa 50% da área disponível

#### ABA "ENTRAR" (Estado Ativo)

**Container Principal**:

- Card branco com bordas arredondadas
- Sombra sutil para elevação
- Padding interno de 20px
- Margin horizontal de 20px

**Campos do Formulário**:

1. **Campo "Usuário ou e-mail"**:
   - Ícone: Icons.person (cinza, lado esquerdo)
   - Campo de texto com borda cinza clara
   - Label flutuante
   - Fundo cinza muito claro (#F8F9FA)
   - Bordas arredondadas

2. **Campo "Senha"**:
   - Ícone: Icons.lock (cinza, lado esquerdo)
   - Ícone olho: Icons.visibility_off (cinza, lado direito)
   - Campo de texto obscuro
   - Mesma estilização do campo anterior

3. **Checkbox "Manter conectado"**:
   - Checkbox quadrado com bordas arredondadas
   - Cor azul quando selecionado
   - Texto alinhado à direita do checkbox
   - Posicionado à esquerda do container

4. **Link "Esqueci a senha"**:
   - Texto azul (#4A90E2)
   - Sublinhado
   - Posicionado à direita
   - Alinhamento: final da linha

5. **Botão "Entrar"**:
   - Cor de fundo azul primário
   - Texto branco em caixa alta
   - Largura total do container
   - Altura: 50px
   - Bordas arredondadas

**Seção de Login Social**:

6. **Botão "Login com Facebook"**:
   - Cor de fundo azul Facebook (#1877F2)
   - Ícone Facebook (Icons.facebook) à esquerda
   - Texto branco
   - Largura total
   - Altura: 45px

7. **Botão "Registre com Google"**:
   - Borda cinza, fundo branco
   - Ícone Google à esquerda (colorido)
   - Texto cinza escuro
   - Mesmas dimensões do botão Facebook

#### ABA "REGISTRAR" (Estado Inativo quando Entrar está ativo)

**Elementos quando ativada**:

1. **Campo "Nome Completo"**:
   - Ícone: Icons.person_outline
   - Mesmo estilo dos campos da aba Entrar
   - Validação visual obrigatória

2. **Campo "E-mail"**:
   - Ícone: Icons.email_outlined
   - Keyboard type: email
   - Validação de formato

3. **Campo "Telefone"**:
   - Ícone: Icons.phone_outlined
   - Máscara de formatação brasileira
   - Checkbox à direita: "É WhatsApp?"

4. **Campo "Senha"**:
   - Ícone: Icons.lock_outline
   - Indicador de força da senha (barras coloridas)
   - Requisitos mínimos exibidos abaixo

5. **Campo "Confirmar Senha"**:
   - Ícone: Icons.lock_outline
   - Validação visual de correspondência

6. **Checkboxes de Termos**:
   - "Aceito os Termos de Uso" (link azul clicável)
   - "Aceito receber comunicações por email"

7. **Botão "Registrar"**:
   - Mesmo estilo do botão Entrar
   - Habilitado apenas quando todos os campos obrigatórios preenchidos

**Footer Comum**: Mantém o toggle modo escuro

---

## 🏢 Módulo de Seleção de Perfil

### TELA 2 - Seleção de Perfil (Usuário Assinante)

**Descrição Geral**: Interface para seleção do perfil de usuário a ser administrado.

**Header**:

- Fundo azul primário
- Ícone de voltar (Icons.arrow_back) à esquerda, cor branca
- Avatar circular no centro-esquerda (foto padrão de usuário)
- Nome "Fulano de tal" ao lado do avatar, texto branco
- Ícone de menu (Icons.more_vert) à direita, cor branca

**Título Principal**:

- "Qual perfil você quer administrar?"
- Centralizado
- Cor cinza escuro
- Fonte média-grande
- Margin superior e inferior

**Grid de Perfis (2 colunas, 3 linhas)**:

**Linha 1**:

1. **Card ATLETA**:
   - Fundo azul primário (#4A90E2)
   - Ícone: Icons.sports_tennis (branco, grande)
   - Texto "ATLETA" (branco, bold)
   - Sombra elevada (8.0)
   - Bordas arredondadas
   - Estado: ATIVO/CLICÁVEL

2. **Card ALUNO**:
   - Fundo cinza (#BDBDBD)
   - Ícone: Icons.school (branco, mesmo tamanho)
   - Texto "ALUNO" (branco, bold)
   - Sombra menor (2.0)
   - Estado: BLOQUEADO

**Linha 2**:
3. **Card PROFESSOR**:

- Fundo cinza (#BDBDBD)
- Ícone: Icons.person (branco)
- Texto "PROFESSOR" (branco, bold)
- Estado: BLOQUEADO

4. **Card ARENA**:
   - Fundo azul primário (#4A90E2)
   - Ícone: Icons.stadium (branco)
   - Texto "ARENA" (branco, bold)
   - Estado: ATIVO/CLICÁVEL

**Linha 3**:
5. **Card PROFISSIONAL TÉCNICO**:

- Centralizado (colspan 2)
- Fundo azul primário (#4A90E2)
- Ícone: Icons.analytics (branco)
- Texto "PROFISSIONAL TÉCNICO" (branco, bold)
- Largura: 70% da tela
- Estado: ATIVO/CLICÁVEL

**Especificações dos Cards**:

- Proporção: 1.2:1 (largura:altura)
- Espaçamento entre cards: 12px
- Margin das bordas: 16px
- Radius das bordas: 16px

### TELA 2.1 - Seleção de Assinatura (Usuário Não Assinante)

**Descrição Geral**: Interface para usuários sem assinatura escolherem planos.

**Header**: Idêntico à TELA 2

**Título Principal**:

- "ESCOLHA SUA ASSINATURA"
- Centralizado
- Cor azul primário
- Fonte grande, bold
- Margin vertical aumentada

**Lista de Planos (Vertical)**:

#### Card ATLETA

- **Container**: Card elevado, fundo branco, margin vertical 8px
- **Header do Card**:
  - Título "ATLETA" (azul primário, grande, bold) à esquerda
  - Ícone Icons.sports_tennis (azul primário, 32px) à direita
- **Subtítulo**: "FUNCIONALIDADES" (cinza médio, pequeno, bold)
- **Descrição**:
  - "Acompanhe suas estatísticas nos jogos. Crie relacionamentos com outros atletas. Observe o desempenho das duplas que você participa. Configure seus pontos fracos e pontos fortes."
  - Cor: cinza escuro
  - Fonte: média
  - Line height: 1.4
- **Botão de Ação**:
  - Texto: "ASSINAR"
  - Fundo: azul primário
  - Largura: total do container
  - Altura: 44px
  - Bordas arredondadas

#### Card ARENA

- **Estrutura idêntica ao Atleta**
- **Título**: "ARENA"
- **Ícone**: Icons.stadium
- **Descrição**: "Concentre sua Arena você pode facilitar os professores que fazem parte dela, bem como seus alunos, dando a oportunidade de analisarem o desenvolvimento técnico dos alunos."

#### Card PROFISSIONAL TÉCNICO

- **Estrutura idêntica aos anteriores**
- **Título**: "PROFISSIONAL TÉCNICO"
- **Ícone**: Icons.analytics
- **Descrição**: "Acompanhe suas estatísticas nos jogos. Crie relacionamentos com outros atletas. Observe o desempenho das duplas que você participa. Configure seus pontos fracos e pontos fortes."

**Menu Superior Direito** (acessível via ícone ...):

- Opção: "Assinar"
- Opção: "Compartilhar"

---

## 📝 Módulo de Cadastro

### TELA 2.1.1 - Cadastro Arena

**Descrição Geral**: Formulário completo para cadastro de arena esportiva.

**Header**: Mantém padrão com título "MINHA ARENA" centralizado

**Formulário Principal**:

1. **Campo Nome**:
   - Label: "Nome"
   - Ícone prefix: Icons.business (azul primário)
   - Fundo: cinza muito claro
   - Borda: arredondada, cinza claro
   - Largura: total
   - Placeholder visual ativo

2. **Campo Endereço**:
   - Label: "Endereço"
   - Ícone prefix: Icons.location_on (azul primário)
   - Ícone suffix: Icons.map (para integração Google Maps)
   - **Funcionalidade especial**: Integração com Google Maps para seleção de endereço
   - Ao clicar, abre interface de mapa para seleção precisa

3. **Campo CNPJ**:
   - Label: "CNPJ"
   - Ícone prefix: Icons.business_center (azul primário)
   - Máscara de formatação: XX.XXX.XXX/XXXX-XX
   - Validação automática de CNPJ

4. **Seção Telefone**:
   - **Campo Telefone**: 70% da largura
     - Label: "Telefone"
     - Ícone prefix: Icons.phone (azul primário)
     - Máscara: (XX) XXXXX-XXXX
   - **Checkbox WhatsApp**: 30% da largura
     - Texto: "É WhatsApp?" (fonte pequena)
     - Checkbox azul quando selecionado
     - Alinhamento vertical centralizado

5. **Campo E-mail**:
   - Label: "E-mail"
   - Ícone prefix: Icons.email (azul primário)
   - Keyboard type: email
   - Validação de formato em tempo real

6. **Seção Redes Sociais** (2 campos lado a lado):
   - **Instagram**:
     - Label: "Instagram"
     - Ícone prefix: Icons.camera_alt (roxo/rosa)
     - Largura: 48% da tela
   - **Facebook**:
     - Label: "Facebook"
     - Ícone prefix: Icons.facebook (azul Facebook)
     - Largura: 48% da tela
   - Gap entre campos: 4%

**Botão de Ação**:

- **Botão "CADASTRAR"**:
  - Posição: centralizado na parte inferior
  - Fundo: azul primário
  - Texto: branco, caixa alta, bold
  - Largura: 90% da tela
  - Altura: 56px
  - Bordas arredondadas
  - Margin superior: 32px

### TELA 2.1.2 - Cadastro Atleta

**Descrição Geral**: Formulário para cadastro de atleta com campos específicos.

**Header**: Título "MEUS DADOS" centralizado

**Formulário Específico**:

1. **Campo Nome**:
   - Idêntico ao da Arena, mas com ícone Icons.person

2. **Seção Data e Sexo** (lado a lado):
   - **Data de Nascimento**: 60% da largura
     - Label: "Data de Nascimento"
     - Ícone prefix: Icons.calendar_today (azul primário)
     - Campo somente leitura (abre DatePicker ao clicar)
     - Formato: DD/MM/AAAA
   - **Sexo**: 35% da largura
     - Dropdown com opções: Masculino, Feminino, Outro
     - Ícone prefix: Icons.person_outline
     - Gap: 5%

3. **Seção Cidade e E-mail** (lado a lado):
   - **Cidade**: 48% da largura
     - Label: "Cidade"
     - Ícone prefix: Icons.location_city (azul primário)
   - **E-mail**: 48% da largura
     - Idêntico ao campo da Arena
     - Gap: 4%

4. **Seção Telefone**: Idêntica à da Arena

5. **Campo CPF**:
   - Label: "CPF"
   - Ícone prefix: Icons.credit_card (azul primário)
   - Máscara: XXX.XXX.XXX-XX
   - Validação automática de CPF

6. **Seção Redes Sociais**: Idêntica à da Arena

**Botão de Ação**: Mesmo padrão da Arena

---

## 💳 Módulo de Pagamento

### TELA 2.1.3 - Formas de Pagamento

**Descrição Geral**: Interface para seleção e processamento de métodos de pagamento.

**Header**: Título "FORMA DE PAGAMENTO" centralizado

**Seleção de Método** (2 cards lado a lado):

#### Card Cartão de Crédito

- **Visual**: 48% da largura da tela
- **Ícone**: Icons.credit_card (grande, azul primário)
- **Título**: "CARTÃO DE CRÉDITO" (centralizado, bold)
- **Estado**: Selecionável com borda azul quando ativo
- **Fundo**: Branco com sombra

#### Card PIX

- **Visual**: 48% da largura da tela
- **Ícone**: QR code estilizado (grande, azul primário)
- **Título**: "PIX" (centralizado, bold)
- **Estado**: Selecionável com borda azul quando ativo
- **Fundo**: Branco com sombra

**Área de Conteúdo Dinâmica**:

#### Quando Cartão de Crédito Selecionado

1. **Dropdown Pacote**:
   - Label: "Pacote"
   - Opções vindas do sistema administrativo
   - Exibição: "Nome do Pacote - R$ Valor"

2. **Campo Número do Cartão**:
   - Label: "Número do cartão (apenas números)"
   - Ícone prefix: Icons.credit_card
   - Máscara: XXXX XXXX XXXX XXXX
   - Validação de operadora (visual)

3. **Campo Nome do Titular**:
   - Label: "Nome do titular"
   - Ícone prefix: Icons.person
   - Capitalização automática

4. **Seção Código e Validade** (lado a lado):
   - **Código de Segurança**: 60% da largura
     - Label: "Código de segurança"
     - Ícone prefix: Icons.security
     - Máscara: XXX
   - **Data de Vencimento**: 35% da largura
     - Label: "CVV"
     - Ícone suffix: Icons.help_outline (info)
     - Máscara: MM/AA

5. **Campo Parcelas**:
   - Dropdown com opções de 1x a 12x
   - Cálculo automático do valor por parcela
   - Formato: "Xx de R$ XX,XX"

#### Quando PIX Selecionado

1. **Dropdown Pacote**: Idêntico ao cartão

2. **QR Code**:
   - Área central: 200x200px
   - Borda cinza clara
   - Fundo branco
   - QR code gerado dinamicamente

3. **Código PIX**:
   - Campo de texto somente leitura
   - Valor do código PIX para cópia
   - Ícone suffix: Icons.copy (para copiar)
   - Fundo cinza claro

4. **Instruções**:
   - Texto explicativo sobre como usar o PIX
   - Fonte menor, cor cinza

**Botões de Ação** (parte inferior):

- **Botão "Pagar"**:
  - Fundo azul primário
  - Largura: 45%
  - Altura: 48px
  - Posição: esquerda
- **Botão "Cancelar"**:
  - Fundo amarelo (#FFC107)
  - Largura: 45%
  - Altura: 48px
  - Posição: direita
  - Gap: 10%

---

## 🏟️ Módulo Perfil Arena

### TELA 3 - Dashboard Arena

**Descrição Geral**: Painel principal de controle para administradores de arena.

**Header**:

- Fundo azul primário
- Texto "ARENA TAL" (nome da arena) centralizado, branco, bold
- Ícone voltar à esquerda, menu à direita

**Grid Principal** (2x2):

#### Card PROFESSOR

- **Posição**: Superior esquerdo
- **Fundo**: Azul primário (#4A90E2)
- **Ícone**: Icons.person (branco, 48px)
- **Texto**: "PROFESSOR" (branco, bold)
- **Estado**: Ativo
- **Sombra**: Elevada

#### Card ALUNO

- **Posição**: Superior direito
- **Fundo**: Cinza (#BDBDBD)
- **Ícone**: Icons.school (branco, 48px)
- **Texto**: "ALUNO" (branco, bold)
- **Estado**: Ativo

#### Card EDITAR PERFIL

- **Posição**: Inferior esquerdo
- **Fundo**: Cinza (#BDBDBD)
- **Ícone**: Icons.edit (branco, 48px)
- **Texto**: "EDITAR PERFIL" (branco, bold)

#### Card ALTERNAR PERFIL

- **Posição**: Inferior direito
- **Fundo**: Azul primário (#4A90E2)
- **Ícone**: Icons.swap_horiz (branco, 48px)
- **Texto**: "ALTERNAR PERFIL" (branco, bold)

**Especificações do Grid**:

- Espaçamento: 16px entre cards
- Margin das bordas: 20px
- Aspect ratio: 1:1
- Border radius: 16px

### TELA 3.1 - Listagem de Professores

**Descrição Geral**: Lista de professores vinculados à arena com controles de gerenciamento.

**Header**: Mantém padrão "ARENA TAL"

**Seção de Controles**:

1. **Campo de Busca**:
   - Largura: 65% da tela
   - Placeholder: "Buscar professor"
   - Ícone prefix: Icons.search
   - Bordas arredondadas

2. **Toggle Filtro**:
   - Largura: 30% da tela
   - Texto: "Mostrar inativos"
   - Switch azul/cinza
   - Alinhamento: centralizado

**Título da Seção**:

- "MEUS PROFESSORES"
- Cor: azul primário
- Fonte: média, bold
- Margin vertical

**Lista de Professores**:

#### Card Professor Individual

- **Layout**: Horizontal
- **Avatar**:
  - Círculo 56x56px
  - Ícone padrão: Icons.person (se sem foto)
  - Fundo: cinza claro
  - Posição: esquerda

- **Área de Informações** (centro):
  - **Nome**: "Amigo 1" (preto, bold)
  - **Subtítulo**: "X amigos em comum" (cinza, pequeno)

- **Área de Ações** (direita):
  - **Menu Dropdown**: Icons.more_vert (cinza, 24px)

**Menu Dropdown de Ações**:

- **Desfazer amizade**: Texto vermelho, ícone Icons.person_remove
- **Adicionar jogo como parceiro**: Texto azul, ícone Icons.group_add
- **Adicionar jogo como adversário**: Texto laranja, ícone Icons.sports
- **Mandar mensagem**: Texto verde, ícone Icons.message

**Funcionalidade de Busca**:

- **Quando encontrar atleta**: Exibe lista de resultados para adicionar
- **Quando não encontrar**: Opções de compartilhamento
  - Botão "Compartilhar via WhatsApp"
  - Botão "Compartilhar via E-mail"

**Menu Superior Direito** (ícone ...):

- **Sair**: Icons.exit_to_app
- **Editar Perfil**: Icons.edit
- **Modo escuro/claro**: Icons.brightness_6
- **Alternar perfil**: Icons.swap_horiz (se houver múltiplos perfis)

---

## 📊 Módulo Estatísticas

### TELA 12 - Estatísticas Individuais

**Descrição Geral**: Dashboard completo de análise de performance do atleta.

**Header**: Padrão do atleta

**Título Principal**:

- "MINHAS ESTATÍSTICAS"
- Cor: azul primário
- Centralizado

**Seção de Filtro de Data** (opcional):

- **Campo "De"**: Date picker (45% largura)
- **Campo "Até"**: Date picker (45% largura)
- **Gap**: 10%
- **Posição**: Abaixo do título
- **Funcionalidade**: Filtra estatísticas por período

**Grid de Métricas Principais** (2x2):

#### Cards de Percentuais

1. **Saque**:
   - Valor: "15%" (azul primário, grande)
   - Label: "ÍNDICE GERAL SAQUE" (cinza, pequeno)
   - Fundo: azul claro

2. **Devolução**:
   - Valor: "85%" (azul primário, grande)
   - Label: "ÍNDICE GERAL DEVOLUÇÃO" (cinza, pequeno)
   - Fundo: azul claro

3. **Direita**:
   - Valor: "5%" (azul primário, grande)
   - Label: "ÍNDICE LADO DIREITA" (cinza, pequeno)
   - Fundo: azul claro

4. **Esquerda**:
   - Valor: "58%" (azul primário, grande)
   - Label: "ÍNDICE LADO ESQUERDA" (cinza, pequeno)
   - Fundo: azul claro

**Seção de Gráficos**:

#### Gráfico Pizza Principal

- **Dimensão**: 150x150px
- **Cores**: Azul (80%) e amarelo (20%)
- **Labels**: Percentuais visíveis
- **Posição**: Centro-esquerda

#### Gráfico de Barras

- **Título**: "RESULTADO | SETS |" (pequeno, cinza)
- **Categorias**:
  - "PRIMEIRO": 3 (verde)
  - "SEGUNDO": 2 (azul)
  - "TERCEIRO": 1 (laranja)
- **Layout**: Barras horizontais coloridas
- **Posição**: Centro-direita

#### Gráfico Donut "BOLA DE FINALIZAÇÃO"

- **Dimensão**: 120x120px
- **Segmentos**:
  - Verde: 34%
  - Amarelo: 31%
  - Vermelho: restante
- **Legend**:
  - "PRIMEIRA BOLA": 15
  - "SEGUNDA BOLA": 10
  - "TERCEIRA BOLA": 8
  - "QUARTA BOLA": 5
  - "REVIVIDA": 3
- **Posição**: Inferior esquerda

#### Gráfico Donut "GOLPE DE FINALIZAÇÃO"

- **Dimensão**: 120x120px
- **Segmentos**: Distribuição similar
- **Legend**:
  - "GOLPE 1": 50
  - "GOLPE 2": 35
  - "GOLPE 3": 20
  - "GOLPE 4": 15
  - "GOLPE 5": 12
- **Posição**: Inferior direita

**Botão de Navegação**:

- **"MINHAS DUPLAS"**:
  - Fundo: azul primário
  - Largura: 60% da tela
  - Centralizado na parte inferior
  - Altura: 44px

### TELA 12.1 - Lista de Duplas para Estatísticas

**Descrição Geral**: Seleção de parceiro para visualizar estatísticas em dupla.

**Header**: Padrão do atleta

**Título da Seção**:

- "MINHAS ESTATÍSTICAS EM DUPLAS"
- Cor: azul primário
- Centralizado

**Lista de Parceiros**:

#### Item Parceiro

- **Layout**: Horizontal
- **Avatar**: Icons.person (círculo azul, 48px)
- **Nome**: "Beltrano Lorem Ipsum" (preto, bold)
- **Ação**:
  - **Visualizar**: Icons.visibility (azul, 24px)
  - **Função**: Abre estatísticas específicas da dupla

**Padrão da Lista**:

- Scroll vertical
- Margin entre itens: 8px
- Padding horizontal: 16px

**Botão de Ação**:

- **"Novo Jogo"**:
  - Fundo: azul primário
  - Posição: inferior centralizado
  - Funcionalidade: Direciona para cadastro de jogo

### TELA 12.2 - Estatísticas da Dupla Selecionada

**Descrição Geral**: Dashboard específico de performance com parceiro selecionado.

**Header**: "ESTATÍSTICAS COM BELTRANO" (azul primário)

**Seção de Filtro de Data**: Idêntica à tela individual

**Layout de Estatísticas**:

- **Estrutura**: Idêntica à TELA 12
- **Diferença**: Dados específicos da parceria
- **Métricas**: Calculadas apenas para jogos em dupla com o parceiro selecionado

**Gráficos Específicos**:

- Todos os gráficos mantêm mesmo layout visual
- **Dados**: Filtrados para jogos da dupla específica
- **Cores**: Mantém padrão azul/amarelo/verde

**Funcionalidades Adicionais**:

- **Comparação**: Possibilidade de comparar com outras duplas
- **Histórico**: Lista de jogos específicos da dupla
- **Performance**: Evolução temporal da parceria

---

## 🎾 Regras de Pontuação Beach Tennis

### Sistema de Pontuação Detalhado

**Descrição Geral**: O aplicativo segue rigorosamente as regras oficiais do Beach Tennis.

#### Estrutura Hierárquica

1. **Ponto** (menor unidade)
2. **Game** (4 pontos)
3. **Set** (6 games)
4. **Jogo** (melhor de 3 sets)

#### Contagem de Pontos (Game)

- **1º ponto**: 15
- **2º ponto**: 30
- **3º ponto**: 40
- **4º ponto**: Game
- **Empate Apex Sports - Beach Tenis**: Próximo ponto vence (sem vantagem)

#### Contagem de Games (Set)

- **Set normal**: Primeiro a chegar a 6 games
- **Empate 5x5**: Jogo continua até 7 games
- **Empate 6x6**: Tie-break de 7 pontos diretos

#### Contagem de Sets (Jogo)

- **Melhor de 3 sets**: Primeiro a vencer 2 sets
- **Se 1x1 em sets**: 3º set de desempate
- **Set decisivo**: 10 pontos diretos (não há games)

#### Implementação no Sistema

- **Auto-cálculo**: Sistema calcula automaticamente a pontuação
- **Validações**: Não permite entradas inválidas
- **Display**: Mostra sempre o estado atual completo
- **Histórico**: Mantém registro de todos os pontos

---

## ⚙️ Módulo Administrativo Detalhado

### Painel de Administração Geral

**Descrição Geral**: Interface administrativa para gestão completa do sistema.

#### Acesso Administrativo

- **Login**: Credenciais de administrador
- **Perfil especial**: Acesso total ao sistema
- **Interface diferenciada**: Layout próprio para admin

### Administrar Arenas

**Lista de Arenas**:

- **Colunas**:
  - Nome da Arena
  - CNPJ
  - Status (Ativo/Inativo)
  - Data de cadastro
  - Última mensalidade
  - Ações

**Funcionalidades**:

1. **Gestão de Pagamentos**:
   - Visualizar histórico de mensalidades
   - Marcar como pago/pendente
   - Gerar boletos bancários (exclusivo arenas)
   - Configurar vencimentos

2. **Controle de Status**:
   - Ativar/Desativar arena
   - Bloquear acesso temporariamente
   - Histórico de alterações

3. **Cadastro**:
   - Formulário completo de arena
   - Validação de dados
   - Integração com sistemas de pagamento

### Administrar Atletas

**Lista de Atletas**:

- **Colunas**:
  - Nome
  - CPF
  - E-mail
  - Status
  - Tipo de assinatura
  - Vencimento
  - Ações

**Funcionalidades**:

1. **Gestão de Mensalidades**:
   - Controle de pagamentos
   - Alertas de vencimento
   - Bloqueio por inadimplência

2. **Controle de Acesso**:
   - Ativar/Desativar perfil
   - Histórico de acessos
   - Logs de atividade

### Administrar Profissionais Técnicos

**Lista de Profissionais**:

- **Colunas**:
  - Nome
  - Especialidade
  - Atletas vinculados
  - Status
  - Data de cadastro
  - Ações

**Funcionalidades**:

1. **Vinculações**:
   - Gerenciar atletas por profissional
   - Aprovar/negar solicitações
   - Histórico de parcerias

2. **Controle de Qualidade**:
   - Avaliar performance
   - Feedback de atletas
   - Certificações

### Gestão de Assinaturas

**Tipos de Assinatura**:

#### Arena

- **Planos**: Básico, Intermediário, Premium
- **Diferencial**: Quantidade de alunos permitida
- **Preços**: Variáveis por plano
- **Pagamento**: Cartão, PIX, Boleto

#### Atleta

- **Planos**: Individual, Pro
- **Funcionalidades**: Estatísticas, jogos, conexões
- **Preços**: Mensais ou anuais
- **Pagamento**: Cartão, PIX

#### Profissional Técnico

- **Plano único**: Acesso completo
- **Funcionalidades**: Análise de atletas
- **Cobrança**: Por atleta vinculado

**Configurações de Pacote**:

- **Nome do pacote**: Personalizável
- **Duração**: Mensal, trimestral, semestral, anual
- **Preço**: Configurável por administrador
- **Funcionalidades**: Checklist de recursos inclusos

### Administrar Termos Técnicos

#### Gestão de Golpes

- **Lista de Golpes**:
  - Backhand
  - Forehand
  - Smash
  - Lob
  - Volley
  - Drop shot
  - Bandeja
  - Víbora
  - Bajada

**Funcionalidades**:

- **Adicionar**: Novos tipos de golpe
- **Editar**: Descrições existentes
- **Remover**: Golpes não utilizados
- **Ordenar**: Por frequência de uso

#### Gestão de Itens de Treino

- **Categorias**:
  - Técnica de saque
  - Devolução
  - Jogadas de rede
  - Fundo de quadra
  - Finalização

**Campos por Item**:

- **Nome**: Descrição clara
- **Categoria**: Agrupamento
- **Dificuldade**: Iniciante/Intermediário/Avançado
- **Descrição**: Instruções detalhadas

#### Gestão de Categorias de Treino

- **Estrutura**:
  - Nome da categoria
  - Itens inclusos
  - Quantidades previstas padrão
  - Tempo estimado

**Funcionalidades**:

- **Templates**: Categorias pré-definidas
- **Personalização**: Por arena ou professor
- **Histórico**: Evolução dos treinos

### Interface Administrativa

#### Dashboard Admin

- **Métricas Gerais**:
  - Total de usuários ativos
  - Receita mensal
  - Arenas cadastradas
  - Jogos registrados no mês

- **Gráficos**:
  - Crescimento de usuários
  - Receita por tipo de assinatura
  - Uso por funcionalidade
  - Retenção de usuários

#### Relatórios

- **Financeiro**: Receitas, inadimplência, projeções
- **Uso**: Funcionalidades mais utilizadas
- **Performance**: Tempo de resposta, erros
- **Feedback**: Avaliações e sugestões

#### Configurações Globais

- **Parâmetros do sistema**
- **Integrações** (pagamento, email, SMS)
- **Backup e segurança**
- **Logs de auditoria**

---

## 🎨 Especificações Técnicas de Design Completas

### Padrões Visuais Globais

#### Tipografia Detalhada

- **Font Family**: Roboto (Android) / SF Pro (iOS)
- **Títulos H1**: 28px, bold, azul primário
- **Títulos H2**: 24px, bold, preto
- **Títulos H3**: 20px, medium, azul primário
- **Subtítulos**: 18px, medium, cinza escuro
- **Texto corpo**: 16px, regular, preto
- **Texto secundário**: 14px, regular, cinza médio
- **Labels/legendas**: 12px, medium, cinza escuro
- **Captions**: 10px, regular, cinza claro

#### Espaçamentos Padronizados

- **Tiny**: 4px
- **Small**: 8px
- **Medium**: 12px
- **Large**: 16px
- **XLarge**: 20px
- **XXLarge**: 24px
- **Huge**: 32px

#### Sistema de Grid

- **Columns**: 12 colunas
- **Gutter**: 16px
- **Margin**: 20px (mobile), 40px (tablet)
- **Container max-width**: 1200px

#### Bordas e Elevações Detalhadas

- **Radius Small**: 8px (campos, botões pequenos)
- **Radius Medium**: 12px (botões, cards pequenos)
- **Radius Large**: 16px (cards principais, modais)
- **Radius XLarge**: 24px (containers especiais)

#### Elevações (Material Design)

- **Level 0**: 0dp (elementos planos)
- **Level 1**: 2dp (cards de lista)
- **Level 2**: 4dp (cards principais)
- **Level 3**: 8dp (botões flutuantes)
- **Level 4**: 12dp (modais)
- **Level 5**: 16dp (navigation drawer)

#### Animações e Transições

- **Duration Fast**: 150ms
- **Duration Normal**: 300ms
- **Duration Slow**: 500ms
- **Curve Standard**: Cubic-bezier(0.4, 0.0, 0.2, 1)
- **Curve Enter**: Cubic-bezier(0.0, 0.0, 0.2, 1)
- **Curve Exit**: Cubic-bezier(0.4, 0.0, 1, 1)

### Estados Interativos Detalhados

#### Botões

- **Normal**: Cor sólida, elevação 2dp
- **Hover**: Elevação 4dp (web/tablet)
- **Pressed**: Opacidade 0.8, elevação 8dp
- **Disabled**: Opacidade 0.4, elevação 0dp
- **Loading**: Spinner centralizado

#### Campos de Texto

- **Normal**: Borda cinza clara
- **Focused**: Borda azul primário, elevação 1dp
- **Error**: Borda vermelha, texto de erro abaixo
- **Success**: Borda verde, ícone check
- **Disabled**: Fundo cinza claro, texto cinza

#### Cards

- **Normal**: Elevação 2dp
- **Hover**: Elevação 4dp
- **Selected**: Borda azul primário 2px
- **Loading**: Skeleton animation

### Sistema de Cores Completo

#### Azuis (Cor Primária)

- **Primary 50**: #E3F2FD
- **Primary 100**: #BBDEFB
- **Primary 200**: #90CAF9
- **Primary 300**: #64B5F6
- **Primary 400**: #42A5F5
- **Primary 500**: #4A90E2 (principal)
- **Primary 600**: #1E88E5
- **Primary 700**: #1976D2
- **Primary 800**: #1565C0
- **Primary 900**: #0D47A1

#### Cinzas (Neutros)

- **Grey 50**: #FAFAFA
- **Grey 100**: #F5F5F5
- **Grey 200**: #EEEEEE
- **Grey 300**: #E0E0E0
- **Grey 400**: #BDBDBD
- **Grey 500**: #9E9E9E
- **Grey 600**: #757575
- **Grey 700**: #616161
- **Grey 800**: #424242
- **Grey 900**: #212121

#### Cores Semânticas

- **Success**: #4CAF50
- **Warning**: #FFC107
- **Error**: #F44336
- **Info**: #2196F3

### Componentes Customizados Flutter

#### CustomCard

```dart
class CustomCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets? padding;
  final Color? backgroundColor;
  final double? elevation;
  final BorderRadius? borderRadius;
  
  const CustomCard({
    Key? key,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.elevation = 2.0,
    this.borderRadius,
  }) : super(key: key);
}
```

#### CustomButton

```dart
enum ButtonType { primary, secondary, outlined, text }
enum ButtonSize { small, medium, large }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final IconData? icon;
  final bool loading;
  
  const CustomButton({
    Key? key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.icon,
    this.loading = false,
  }) : super(key: key);
}
```

#### CustomTextField

```dart
class CustomTextField extends StatelessWidget {
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;
  
  const CustomTextField({
    Key? key,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  }) : super(key: key);
}
```

---

## 📱 Especificações de Responsividade Completas

### Breakpoints Detalhados

- **XSmall**: 320px - 479px (smartphones pequenos)
- **Small**: 480px - 767px (smartphones grandes)
- **Medium**: 768px - 1023px (tablets)
- **Large**: 1024px - 1439px (tablets grandes/laptops)
- **XLarge**: 1440px+ (desktops)

### Adaptações por Breakpoint

#### XSmall (320px - 479px)

- **Grid**: 1 coluna para todos os grids
- **Padding**: 12px nas bordas
- **Font sizes**: Redução de 2px em todos os tamanhos
- **Botões**: Altura mínima 48px
- **Cards**: Margin vertical 8px

#### Small (480px - 767px)

- **Grid**: Mantém 2x2 quando possível
- **Padding**: 16px nas bordas
- **Font sizes**: Tamanhos padrão
- **Modais**: 95% da largura da tela

#### Medium (768px - 1023px)

- **Grid**: 2x2 com espaçamentos maiores
- **Padding**: 24px nas bordas
- **Modais**: 80% da largura da tela
- **Sidebar**: Possível em landscape

#### Large+ (1024px+)

- **Grid**: Pode expandir para 3 colunas
- **Layout**: Otimizado para mouse/trackpad
- **Hover states**: Totalmente ativo
- **Modais**: 60% da largura máxima

### Orientação da Tela

#### Portrait (Padrão)

- **Layout**: Vertical otimizado
- **Navegação**: Bottom navigation
- **Grids**: 2 colunas máximo

#### Landscape

- **Layout**: Horizontal aproveitado
- **Navegação**: Pode mudar para drawer
- **Grids**: Até 3-4 colunas
- **Modais**: Largura reduzida, altura aproveitada

---

## 🔧 Arquitetura Técnica Detalhada

### Estrutura de Pastas Completa

```
lib/
├── app/
│   ├── app.dart
│   └── routes/
├── core/
│   ├── constants/
│   │   ├── colors.dart
│   │   ├── strings.dart
│   │   ├── dimensions.dart
│   │   └── api_endpoints.dart
│   ├── theme/
│   │   ├── app_theme.dart
│   │   ├── custom_colors.dart
│   │   └── text_styles.dart
│   ├── utils/
│   │   ├── validators.dart
│   │   ├── formatters.dart
│   │   ├── helpers.dart
│   │   └── extensions.dart
│   ├── errors/
│   │   ├── failures.dart
│   │   └── exceptions.dart
│   └── network/
│       ├── api_client.dart
│       └── network_info.dart
├── features/
│   ├── auth/
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   ├── arena/
│   ├── atleta/
│   ├── professor/
│   ├── aluno/
│   ├── profissional_tecnico/
│   ├── jogos/
│   ├── estatisticas/
│   ├── pagamentos/
│   └── admin/
├── shared/
│   ├── widgets/
│   │   ├── buttons/
│   │   ├── cards/
│   │   ├── forms/
│   │   ├── navigation/
│   │   └── indicators/
│   ├── models/
│   ├── services/
│   └── providers/
└── main.dart
```

### Packages Flutter Essenciais

```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  flutter_bloc: ^8.1.3
  provider: ^6.0.5
  
  # Network
  dio: ^5.3.2
  connectivity_plus: ^4.0.2
  
  # Local Storage
  hive: ^2.2.3
  hive_flutter: ^1.1.0
  shared_preferences: ^2.2.2
  
  # UI/UX
  fl_chart: ^0.63.0
  cached_network_image: ^3.3.0
  shimmer: ^3.0.0
  lottie: ^2.7.0
  
  # Forms
  reactive_forms: ^14.1.0
  mask_text_input_formatter: ^2.5.0
  
  # Maps & Location
  google_maps_flutter: ^2.5.0
  geolocator: ^9.0.2
  
  # QR Code
  qr_flutter: ^4.1.0
  qr_code_scanner: ^1.0.1
  
  # Payments
  flutter_stripe: ^9.4.0
  
  # Utils
  intl: ^0.18.1
  url_launcher: ^6.2.1
  share_plus: ^7.2.1
  permission_handler: ^11.0.1

dev_dependencies:
  flutter_test:
    sdk: flutter
  build_runner: ^2.4.7
  hive_generator: ^2.0.1
  json_annotation: ^4.8.1
  json_serializable: ^6.7.1
```

### Padrão de Arquitetura (Clean Architecture + BLoC)

#### Camada de Apresentação

- **Pages**: Telas principais
- **Widgets**: Componentes reutilizáveis
- **BLoCs**: Gerenciamento de estado
- **Models**: Modelos de UI

#### Camada de Domínio

- **Entities**: Entidades de negócio
- **Use Cases**: Casos de uso
- **Repositories**: Interfaces dos repositórios

#### Camada de Dados

- **Models**: Modelos de dados
- **Data Sources**: APIs, cache local
- **Repositories**: Implementações concretas

### Exemplo de Implementação

#### BLoC para Autenticação

```dart
// Auth Events
abstract class AuthEvent extends Equatable {
  const AuthEvent();
}

class LoginRequested extends AuthEvent {
  final String email;
  final String password;
  
  const LoginRequested({required this.email, required this.password});
  
  @override
  List<Object> get props => [email, password];
}

// Auth States
abstract class AuthState extends Equatable {
  const AuthState();
}

class AuthInitial extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthLoading extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSuccess extends AuthState {
  final User user;
  
  const AuthSuccess({required this.user});
  
  @override
  List<Object> get props => [user];
}

class AuthFailure extends AuthState {
  final String message;
  
  const AuthFailure({required this.message});
  
  @override
  List<Object> get props => [message];
}

// Auth BLoC
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;
  
  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }
  
  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    
    try {
      final user = await authRepository.login(
        email: event.email,
        password: event.password,
      );
      emit(AuthSuccess(user: user));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }
}
```

Este documento agora está completo com todas as especificações técnicas necessárias para o desenvolvimento do aplicativo Apex Sports - Beach Tenis, cobrindo desde os detalhes visuais mais específicos até a arquitetura técnica recomendada.

---

## 📊 Módulo Estatísticas

### TELA 12 - Estatísticas Individuais

**Descrição Geral**: Dashboard completo de análise de performance do atleta.

**Header**: Padrão do atleta

**Título Principal**:

- "MINHAS ESTATÍSTICAS"
- Cor: azul primário
- Centralizado

**Seção de Filtro de Data** (opcional):

- **Campo "De"**: Date picker (45% largura)
- **Campo "Até"**: Date picker (45% largura)
- **Gap**: 10%
- **Posição**: Abaixo do título
- **Funcionalidade**: Filtra estatísticas por período

**Grid de Métricas Principais** (2x2):

#### Cards de Percentuais

1. **Saque**:
   - Valor: "15%" (azul primário, grande)
   - Label: "ÍNDICE GERAL SAQUE" (cinza, pequeno)
   - Fundo: azul claro

2. **Devolução**:
   - Valor: "85%" (azul primário, grande)
   - Label: "ÍNDICE GERAL DEVOLUÇÃO" (cinza, pequeno)
   - Fundo: azul claro

3. **Direita**:
   - Valor: "5%" (azul primário, grande)
   - Label: "ÍNDICE LADO DIREITA" (cinza, pequeno)
   - Fundo: azul claro

4. **Esquerda**:
   - Valor: "58%" (azul primário, grande)
   - Label: "ÍNDICE LADO ESQUERDA" (cinza, pequeno)
   - Fundo: azul claro

**Seção de Gráficos**:

#### Gráfico Pizza Principal

- **Dimensão**: 150x150px
- **Cores**: Azul (80%) e amarelo (20%)
- **Labels**: Percentuais visíveis
- **Posição**: Centro-esquerda

#### Gráfico de Barras

- **Título**: "RESULTADO | SETS |" (pequeno, cinza)
- **Categorias**:
  - "PRIMEIRO": 3 (verde)
  - "SEGUNDO": 2 (azul)
  - "TERCEIRO": 1 (laranja)
- **Layout**: Barras horizontais coloridas
- **Posição**: Centro-direita

#### Gráfico Donut "BOLA DE FINALIZAÇÃO"

- **Dimensão**: 120x120px
- **Segmentos**:
  - Verde: 34%
  - Amarelo: 31%
  - Vermelho: restante
- **Legend**:
  - "PRIMEIRA BOLA": 15
  - "SEGUNDA BOLA": 10
  - "TERCEIRA BOLA": 8
  - "QUARTA BOLA": 5
  - "REVIVIDA": 3
- **Posição**: Inferior esquerda

#### Gráfico Donut "GOLPE DE FINALIZAÇÃO"

- **Dimensão**: 120x120px
- **Segmentos**: Distribuição similar
- **Legend**:
  - "GOLPE 1": 50
  - "GOLPE 2": 35
  - "GOLPE 3": 20
  - "GOLPE 4": 15
  - "GOLPE 5": 12
- **Posição**: Inferior direita

**Botão de Navegação**:

- **"MINHAS DUPLAS"**:
  - Fundo: azul primário
  - Largura: 60% da tela
  - Centralizado na parte inferior
  - Altura: 44px

### TELA 12.1 - Lista de Duplas para Estatísticas

**Descrição Geral**: Seleção de parceiro para visualizar estatísticas em dupla.

**Header**: Padrão do atleta

**Título da Seção**:

- "MINHAS ESTATÍSTICAS EM DUPLAS"
- Cor: azul primário
- Centralizado

**Lista de Parceiros**:

#### Item Parceiro

- **Layout**: Horizontal
- **Avatar**: Icons.person (círculo azul, 48px)
- **Nome**: "Beltrano Lorem Ipsum" (preto, bold)
- **Ação**:
  - **Visualizar**: Icons.visibility (azul, 24px)
  - **Função**: Abre estatísticas específicas da dupla

**Padrão da Lista**:

- Scroll vertical
- Margin entre itens: 8px
- Padding horizontal: 16px

**Botão de Ação**:

- **"Novo Jogo"**:
  - Fundo: azul primário
  - Posição: inferior centralizado
  - Funcionalidade: Direciona para cadastro de jogo

### TELA 12.2 - Estatísticas da Dupla Selecionada

**Descrição Geral**: Dashboard específico de performance com parceiro selecionado.

**Header**: "ESTATÍSTICAS COM BELTRANO" (azul primário)

**Seção de Filtro de Data**: Idêntica à tela individual

**Layout de Estatísticas**:

- **Estrutura**: Idêntica à TELA 12
- **Diferença**: Dados específicos da parceria
- **Métricas**: Calculadas apenas para jogos em dupla com o parceiro selecionado

**Gráficos Específicos**:

- Todos os gráficos mantêm mesmo layout visual
- **Dados**: Filtrados para jogos da dupla específica
- **Cores**: Mantém padrão azul/amarelo/verde

**Funcionalidades Adicionais**:

- **Comparação**: Possibilidade de comparar com outras duplas
- **Histórico**: Lista de jogos específicos da dupla
- **Performance**: Evolução temporal da parceria

---

## ⚙️ Módulo Administrativo

### Funcionalidades Administrativas (Resumo)

**Descrição Geral**: Painel de controle para administradores do sistema.

#### Administrar Arenas

- **Lista**: Arenas ativas e inativas
- **Funcionalidades**:
  - Gestão de pagamentos/mensalidades
  - Ativar/Desativar arena
  - Cadastrar pagamento por boleto (exclusivo para arenas)
  - Cadastrar nova arena

#### Administrar Atletas

- **Lista**: Atletas ativos e inativos
- **Funcionalidades**:
  - Gestão de pagamentos/mensalidades
  - Ativar/Desativar atleta
  - Cadastrar novo atleta

#### Administrar Profissionais Técnicos

- **Lista**: Profissionais ativos e inativos
- **Funcionalidades**:
  - Ativar/Desativar profissional
  - Cadastrar novo profissional técnico

#### Gestão de Assinaturas

- **Tipos**: Arena, Atleta, outros
- **Pacotes**: Mensal, trimestral, semestral, anual
- **Configurações Específicas**:
  - Pacotes Arena: quantidade de alunos permitida
  - Preços e condições por tipo

#### Administrar Termos Técnicos

- **Golpes**: Backhand, smash, lob, volley, etc.
- **Itens de Treino**: Descrições de exercícios
- **Categorias de Treino**: Agrupamentos com quantidades previstas

---

## 🎨 Especificações Técnicas de Design

### Padrões Visuais Globais

#### Tipografia

- **Títulos principais**: 24px, bold, azul primário
- **Títulos secundários**: 18px, bold, preto
- **Texto normal**: 16px, regular, preto
- **Texto pequeno**: 14px, regular, cinza médio
- **Labels**: 12px, medium, cinza escuro

#### Espaçamentos

- **Margin entre seções**: 24px
- **Padding interno de cards**: 16px
- **Gap entre elementos**: 12px
- **Margin das bordas da tela**: 20px

#### Bordas e Elevações

- **Cards principais**: Border radius 16px, elevação 4.0
- **Botões**: Border radius 12px
- **Campos de texto**: Border radius 8px
- **Modais**: Border radius 16px, elevação 8.0

#### Estados Interativos

- **Botão pressionado**: Opacidade 0.7
- **Campo focado**: Borda azul primário, espessura 2px
- **Item selecionado**: Fundo azul claro com 10% opacidade
- **Hover (web)**: Elevação aumentada para 6.0

#### Ícones

- **Tamanho padrão**: 24px
- **Ícones grandes** (grid): 48px
- **Ícones pequenos** (listas): 20px
- **Cor padrão**: Cinza médio #757575
- **Cor ativa**: Azul primário #4A90E2

#### Sistema de Cores por Estado

- **Sucesso**: Verde #4CAF50
- **Erro**: Vermelho #F44336
- **Aviso**: Amarelo #FFC107
- **Info**: Azul #2196F3
- **Neutro**: Cinza #9E9E9E

### Comportamentos Específicos

#### Loading States

- **Skeleton screens** para listas
- **Progress indicators** para operações longas
- **Shimmer effect** para cards carregando

#### Error States

- **Messages**: Texto explicativo claro
- **Actions**: Botões para retry ou voltar
- **Visual**: Ícone de erro + texto

#### Empty States

- **Ilustração**: Ícone representativo grande
- **Texto**: Explicação do estado vazio
- **Ação**: Botão para primeira ação relevante

#### Validações de Formulário

- **Real-time**: Validação durante digitação
- **Visual**: Bordas vermelhas + texto de erro
- **Sucesso**: Bordas verdes + ícone check

---

## 📱 Considerações de Responsividade

### Breakpoints

- **Mobile**: 320px - 767px
- **Tablet**: 768px - 1023px
- **Desktop** (se aplicável): 1024px+

### Adaptações Mobile

- **Grid 2x2**: Mantém proporção em telas pequenas
- **Texto**: Redução automática em telas < 350px
- **Botões**: Altura mínima 44px para touch
- **Espaçamentos**: Redução proporcional em telas pequenas

### Orientação

- **Portrait**: Layout padrão otimizado
- **Landscape**: Ajustes em modais e grids
- **Auto-rotation**: Suporte completo

---

## 🔧 Especificações Técnicas Flutter

### Packages Recomendados

- **Material Design**: material.dart
- **Gráficos**: fl_chart
- **Formulários**: reactive_forms
- **HTTP**: dio
- **Cache**: hive
- **Maps**: google_maps_flutter
- **QR Code**: qr_flutter
- **Máscaras**: mask_text_input_formatter
- **Imagens**: cached_network_image
- **Estado**: bloc/provider

### Estrutura de Pastas Sugerida

```
lib/
  ├── core/
  │   ├── constants/
  │   ├── theme/
  │   └── utils/
  ├── features/
  │   ├── auth/
  │   ├── arena/
  │   ├── atleta/
  │   ├── professor/
  │   ├── aluno/
  │   ├── profissional_tecnico/
  │   ├── jogos/
  │   └── estatisticas/
  ├── shared/
  │   ├── widgets/
  │   ├── models/
  │   └── services/
  └── main.dart
```

### Componentes Reutilizáveis

- **CustomCard**: Card padrão do app
- **CustomButton**: Botão com estilos predefinidos
- **CustomTextField**: Campo de texto padronizado
- **LoadingWidget**: Indicador de loading
- **EmptyStateWidget**: Tela de estado vazio
- **ErrorWidget**: Tela de erro
- **StatCard**: Card de estatística
- **PlayerAvatar**: Avatar de jogador
- **ProgressBar**: Barra de progresso customizada

Este documento fornece uma base técnica completa para o desenvolvimento do aplicativo Apex Sports - Beach Tenis, cobrindo todos os aspectos visuais, funcionais e técnicos identificados na análise do material fornecido.ações** (centro):

- **Nome**: "Fulano Silva dos Santos" (bold, preto)
- **Subtítulo**: Informações adicionais se disponível

- **Área de Ações** (direita):
  - **Ícone Editar**: Icons.edit (azul primário, 24px)
  - **Ícone Status Ativo**: Icons.check (verde, 24px)
  - **Ícone Status Inativo**: Icons.close (vermelho, 24px)
  - Disposição: horizontal com gap de 8px

**Estados Visuais**:

- **Professor Ativo**:
  - Fundo do card: branco
  - Borda esquerda: verde (4px)
  - Ícone status: check verde
- **Professor Inativo**:
  - Fundo do card: cinza muito claro
  - Texto: cinza médio
  - Ícone status: X vermelho

### TELA 3.2 - Cadastro de Professor

**Descrição Geral**: Modal para cadastro/edição de professor.

**Overlay**: Fundo escuro semitransparente (60% opacidade)

**Modal Container**:

- Fundo: branco
- Largura: 90% da tela
- Height: auto (baseado no conteúdo)
- Border radius: 16px
- Posição: centralizado

**Header do Modal**:

- Título: "CADASTRAR PROFESSOR" (azul primário, centralizado, bold)
- Subtítulo: "Digite o Nome (Instruções abaixo)" (cinza, menor)

**Campos do Formulário**:

1. **Data de Nascimento**:
   - Ícone prefix: Icons.calendar_today (azul)
   - Campo date picker
   - Formato: DD/MM/AAAA

2. **Sexo**:
   - Dropdown: Masculino, Feminino, Outro
   - Ícone prefix: Icons.person_outline

3. **CPF**:
   - Máscara: XXX.XXX.XXX-XX
   - Ícone prefix: Icons.credit_card
   - Validação automática

4. **E-mail**:
   - Keyboard type: email
   - Ícone prefix: Icons.email
   - Validação de formato

5. **Telefone**:
   - Máscara: (XX) XXXXX-XXXX
   - Checkbox "É WhatsApp?" à direita
   - Ícone prefix: Icons.phone

6. **Instagram**:
   - Campo opcional
   - Ícone prefix: Icons.camera_alt (roxo)

7. **Facebook**:
   - Campo opcional
   - Ícone prefix: Icons.facebook (azul)

**Botões de Ação**:

- **Botão "Salvar"**:
  - Fundo: azul primário
  - Texto: branco
  - Largura: 45%
  - Posição: esquerda
- **Botão "Cancelar"**:
  - Fundo: amarelo
  - Texto: branco
  - Largura: 45%
  - Posição: direita

**Nota Explicativa** (rodapé do modal):

- Texto pequeno, cinza
- Explicação sobre criação automática de usuário
- "O usuário do professor será criado automaticamente após o cadastro do mesmo, utilizando como parâmetros iniciais: - usuário: CPF - senha: CPF"

### TELA 3.3 - Listagem de Alunos

**Descrição Geral**: Interface idêntica à listagem de professores, mas para alunos.

**Diferenças Específicas**:

- Título da seção: "MEUS ALUNOS"
- Placeholder da busca: "Buscar aluno"
- Toggle: "Mostrar inativos" (funcionalidade idêntica)
- Cards mantêm mesmo layout e funcionalidades
- Modal de cadastro com título "CADASTRAR ALUNO"

---

## 👨‍🏫 Módulo Perfil Professor

### TELA 4 - Dashboard Professor

**Descrição Geral**: Painel principal para professores gerenciarem treinos e avaliações.

**Header**:

- Fundo azul primário
- Texto "PROF.: FULANO DE TAL" (branco, bold)
- Layout idêntico aos outros headers

**Grid Principal** (2x2):

#### Card MEUS TREINOS

- **Posição**: Superior esquerdo
- **Fundo**: Azul primário
- **Ícone**: Icons.fitness_center (branco, 48px)
- **Texto**: "MEUS TREINOS" (branco, bold)

#### Card ARENAS

- **Posição**: Superior direito
- **Fundo**: Cinza
- **Ícone**: Icons.stadium (branco, 48px)
- **Texto**: "ARENAS" (branco, bold)

#### Card AVALIAÇÕES

- **Posição**: Inferior esquerdo
- **Fundo**: Cinza
- **Ícone**: Icons.assessment (branco, 48px)
- **Texto**: "AVALIAÇÕES" (branco, bold)

#### Card EDITAR PERFIL

- **Posição**: Inferior direito
- **Fundo**: Azul primário
- **Ícone**: Icons.edit (branco, 48px)
- **Texto**: "EDITAR PERFIL" (branco, bold)

### TELA 4.1 - Seleção de Arena (Professor)

**Descrição Geral**: Interface para professor selecionar arena para administrar treinos/avaliações.

**Header**: Mantém padrão do professor

**Título Explicativo**:

- "Selecione a Arena que você quer administrar os treinos e avaliações"
- Cor: cinza escuro
- Fonte: média
- Centralizado
- Margin vertical: 20px

**Lista de Arenas**:

#### Card Arena Individual

- **Layout**: Vertical
- **Container**: Card branco com sombra, margin vertical 12px

- **Área Superior**:
  - **Nome**: "Arena 01" (azul primário, bold, grande)
  - **Ícone**: Icons.stadium (azul primário, 32px) à direita

- **Área de Descrição**:
  - Texto: "Abaixo você tem a estatística do percentual de treinos executados"
  - Cor: cinza médio
  - Fonte: pequena

- **Área de Progresso**:
  - Barra de progresso horizontal
  - Cor: azul primário
  - Percentual: variável por arena (ex: 75%)
  - Indicador numérico ao lado da barra

- **Padding**: 16px em todos os lados
- **Border radius**: 12px

**Padrão para Múltiplas Arenas**:

- Arena 02, Arena 03, Arena 04 seguem mesmo layout
- Percentuais variam conforme dados reais
- Scroll vertical se necessário

### TELA 4.2 - Lista de Avaliações

**Descrição Geral**: Interface para visualizar e gerenciar avaliações configuradas pelo professor.

**Header**: Mantém padrão do professor

**Seção de Controles**:

1. **Dropdown Seleção de Arena**:
   - Largura: 45% da tela
   - Label: "Selecionar a Arena"
   - Ícone dropdown: Icons.expand_more
   - Fundo: branco com borda

2. **Campo de Busca**:
   - Largura: 45% da tela
   - Placeholder: "Buscar aluno"
   - Ícone prefix: Icons.search
   - Gap: 10% entre dropdown e busca

3. **Botão Adicionar**:
   - Ícone: Icons.add (azul primário)
   - Formato: circular (FAB)
   - Posição: canto superior direito
   - Ação: abre modal de nova avaliação

**Título da Seção**:

- "AVALIAÇÕES CONFIGURADAS"
- Cor: azul primário
- Fonte: média, bold
- Margin vertical: 16px

**Lista de Avaliações**:

#### Item de Avaliação Individual

- **Layout**: Horizontal em linha
- **Fundo**: Branco alternando com cinza muito claro

**Estrutura da Linha**:

1. **Coluna Data** (20% da largura):
   - Formato: "26/10/2023"
   - Cor: cinza escuro
   - Fonte: pequena

2. **Coluna Aluno** (50% da largura):
   - Nome: "Fulano Silva dos Santos"
   - Cor: preto
   - Fonte: média

3. **Coluna Ações** (30% da largura):
   - **Ícone Visualizar**: Icons.visibility (azul, 20px)
   - **Ícone Editar**: Icons.edit (azul, 20px)
   - **Ícone Status**:
     - Icons.check (verde) = avaliação concluída
     - Icons.remove (amarelo) = pendente de preenchimento
   - Gap: 8px entre ícones

**Estados Visuais**:

- **Avaliação Concluída**:
  - Ícone check verde
  - Texto normal
- **Avaliação Pendente**:
  - Ícone traço amarelo
  - Texto levemente acinzentado

### TELA 4.3 - Cadastrar Avaliação

**Descrição Geral**: Modal para configuração de nova avaliação para aluno.

**Overlay**: Fundo escuro semitransparente

**Modal Container**:

- Fundo: branco
- Largura: 95% da tela
- Height: 80% da tela
- Border radius: 16px
- Scroll vertical interno

**Header do Modal**:

- Título: "CADASTRAR AVALIAÇÃO" (azul primário, centralizado, bold)
- Subtítulo: "Digite o Nome do aluno (Instruções abaixo)" (cinza, pequeno)

**Campo Principal**:

1. **Busca de Aluno**:
   - Campo de texto com autocomplete
   - Ícone prefix: Icons.person_search
   - Placeholder: "Digite o nome do aluno"
   - Busca automática entre alunos vinculados às arenas do professor

**Seções de Itens** (expandíveis):

#### ITEM 1

- **Header da Seção**:
  - Ícone: Icons.expand_more/Icons.expand_less (azul)
  - Título: "ITEM 1" (bold, azul)
  - Estado: expandido/colapsado

- **Conteúdo (quando expandido)**:
  1. **Dropdown Seleção**:
     - Label: "Selecione o item"
     - Opções vindas do cadastro administrativo
  
  2. **Campo Previsto**:
     - Label: "Previsto"
     - Tipo: numérico
     - Descrição: quantidade de execuções previstas
  
  3. **Campo Executado**:
     - Label: "Executado"
     - Tipo: numérico
     - Descrição: quantidade realizada
  
  4. **Campo Acertos**:
     - Label: "Acertos"
     - Tipo: numérico
     - Validação: não pode ser maior que "Executado"

#### ITEM 2, ITEM 3... (estrutura idêntica)

- Mesma estrutura do ITEM 1
- Numeração sequencial
- Possibilidade de adicionar mais itens

**Botão Adicionar Item**:

- Texto: "+ ADICIONAR MAIS ITEM +"
- Cor: azul primário
- Fundo: transparente
- Centralizado

**Campo Final**:

- **Dropdown Resultado da Avaliação**:
  - Opções: "Aprovado", "Reprovado"
  - Cor verde para aprovado, vermelha para reprovado

**Botões de Ação**:

- **Salvar**: Fundo azul, texto branco, 45% largura
- **Cancelar**: Fundo amarelo, texto branco, 45% largura

**Nota Explicativa** (rodapé):

- Texto pequeno explicando que apenas o professor que marcar pode preencher
- Cor: cinza claro

### TELA 4.4 - Lista de Treinos

**Descrição Geral**: Interface idêntica à lista de avaliações, mas para treinos.

**Diferenças Específicas**:

- Título: "TREINOS CONFIGURADOS"
- Funcionalidades idênticas à avaliação
- Tanto professor quanto aluno podem preencher (diferencial importante)

### TELA 4.5 - Cadastrar Treino

**Descrição Geral**: Modal idêntico ao cadastro de avaliação.

**Diferenças Específicas**:

- Título: "CADASTRAR TREINO"
- Nota explicativa menciona que tanto professor quanto aluno podem preencher
- Estrutura de itens idêntica
- Não há campo "Resultado da Avaliação" (específico para avaliações)

---

## 🎓 Módulo Perfil Aluno

### TELA 5 - Dashboard Aluno

**Descrição Geral**: Painel principal para alunos acompanharem seu progresso.

**Header**:

- Fundo azul primário
- Texto "ALUNO: FULANO DE TAL" (branco, bold)
- Layout padrão

**Grid Principal** (2x2):

#### Card MEUS TREINOS

- **Posição**: Superior esquerdo
- **Fundo**: Azul primário
- **Ícone**: Icons.fitness_center (branco, 48px)
- **Texto**: "MEUS TREINOS" (branco, bold)

#### Card MINHAS ESTATÍSTICAS

- **Posição**: Superior direito
- **Fundo**: Cinza
- **Ícone**: Icons.bar_chart (branco, 48px)
- **Texto**: "MINHAS ESTATÍSTICAS" (branco, bold)

#### Card MINHAS AVALIAÇÕES

- **Posição**: Inferior esquerdo
- **Fundo**: Cinza
- **Ícone**: Icons.assessment (branco, 48px)
- **Texto**: "MINHAS AVALIAÇÕES" (branco, bold)

#### Card EDITAR PERFIL

- **Posição**: Inferior direito
- **Fundo**: Azul primário
- **Ícone**: Icons.edit (branco, 48px)
- **Texto**: "EDITAR PERFIL" (branco, bold)

### TELA 5.1 - Estatísticas do Aluno

**Descrição Geral**: Dashboard visual com estatísticas de treinos do aluno.

**Header**: Mantém padrão do aluno

**Título da Seção**:

- "MINHAS ESTATÍSTICAS"
- Cor: azul primário
- Centralizado
- Margin vertical: 20px

**Lista de Treinos com Progresso**:

#### Card Treino Individual

- **Layout**: Horizontal
- **Container**: Card branco, margin vertical 8px

**Estrutura do Card**:

1. **Área do Ícone** (15% largura):
   - Ícone: Icons.fitness_center (azul primário, 32px)
   - Fundo: círculo azul claro

2. **Área de Informações** (60% largura):
   - **Título**: "Treino 1" (bold, preto)
   - **Subtítulo**: "Abaixo você tem a estatística do percentual de acertos do treino 1" (cinza, pequeno)

3. **Área de Progresso** (25% largura):
   - **Barra de Progresso**: horizontal, azul primário
   - **Indicador Numérico**: percentual (ex: "75%")
   - **Ícone Medal**: Icons.emoji_events (dourado, pequeno)

**Padrão para Múltiplos Treinos**:

- Treino 2, Treino 3, Treino 4
- Percentuais variam conforme performance
- Scroll vertical quando necessário

### TELA 5.2 - Lista de Avaliações do Aluno

**Descrição Geral**: Visualização das avaliações feitas pelo aluno (somente leitura).

**Header**: Mantém padrão do aluno

**Título da Seção**:

- "MINHAS AVALIAÇÕES"
- Cor: azul primário
- Centralizado

**Lista de Avaliações**:

#### Item de Avaliação

- **Layout**: Horizontal, estrutura similar ao professor
- **Colunas**:
  1. **Data**: "26/10/2023" (20% largura)
  2. **Professor**: "Fulano Silva dos Santos" (50% largura)
  3. **Ações**: apenas visualização (30% largura)

**Ações Disponíveis**:

- **Ícone Visualizar**: Icons.visibility (azul, 20px)
- **Ícone Status**:
  - Icons.check (verde) = preenchida
  - Icons.remove (amarelo) = pendente

**Nota Importante**: Aluno NÃO pode editar, apenas visualizar

### TELA 5.3 - Detalhamento da Avaliação (Aluno)

**Descrição Geral**: Modal de visualização detalhada da avaliação (read-only).

**Modal Container**:

- Fundo: branco
- Largura: 95% da tela
- Scroll vertical

**Header do Modal**:

- Título: "AVALIAÇÃO DE XX/XX/XXXX" (azul primário)
- Informação do professor responsável

**Seções de Itens** (não editáveis):

#### Estrutura Visual

- **ITEM 1**: Label em cinza
- **Campos de Dados**:
  - Previsto: valor numérico (campo disabled)
  - Executado: valor numérico (campo disabled)
  - Acertos: valor numérico (campo disabled)
- **Visual**: Campos com fundo cinza claro, texto cinza escuro

**Resultado da Avaliação**:

- **Badge "APROVADO"**:
  - Fundo verde
  - Texto branco
  - Centralizado
- **Badge "REPROVADO"**:
  - Fundo vermelho
  - Texto branco
  - Centralizado

**Botão de Ação**:

- **Fechar**: Fundo cinza, largura total

### TELA 5.4 - Lista de Treinos do Aluno

**Descrição Geral**: Lista de treinos onde aluno pode preencher resultados.

**Diferenças da Lista de Avaliações**:

- Título: "MEUS TREINOS"
- **Ícone Editar**: Icons.edit (azul) disponível para aluno
- Aluno pode modificar apenas campo "Êxito"

### TELA 5.5 - Edição de Treino (Aluno)

**Descrição Geral**: Modal para aluno preencher resultados de treino.

**Header do Modal**:

- Título: "TREINO DIA 26/10/2023"
- Subtítulo: "Professor FULANO SILVA DOS SANTOS"

**Estrutura dos Itens**:

#### Item de Treino

- **Nome do Item**: "Item de treino 1" (readonly)
- **Campo Previsto**: valor numérico (readonly, fundo cinza)
- **Campo Êxito**: valor numérico (editável, fundo branco)
- **Descrição**: "Previsto: 20, Êxito: 10" como referência visual

**Campos Editáveis pelo Aluno**:

- Apenas coluna "Êxito"
- Validação: não pode ser maior que "Previsto"
- Feedback visual quando inválido

**Botões de Ação**:

- **Salvar**: Fundo azul primário
- **Fechar**: Fundo amarelo

---

## 👨‍💼 Módulo Profissional Técnico

### TELA 6 - Dashboard Profissional Técnico

**Descrição Geral**: Painel para profissionais técnicos gerenciarem jogos de atletas.

**Header**:

- Fundo azul primário
- Texto "FULANO DE TAL" (branco, bold)
- **Notificações**: Badge vermelho com número no canto superior direito

**Seção de Solicitações**:

- **Título**: "NOVAS SOLICITAÇÕES" (azul primário, bold)
- **Lista de Solicitações**:

#### Item de Solicitação

- **Layout**: Horizontal
- **Avatar**: Icons.person (círculo azul claro)
- **Nome**: "Fulano Campos Silva" (preto, bold)
- **Ações**:
  - **Aceitar**: Icons.check (verde, 24px)
  - **Recusar**: Icons.close (vermelho, 24px)
- **Gap**: 12px entre ações

**Grid Principal** (2x2):

#### Card ATLETAS

- **Fundo**: Azul primário
- **Ícone**: Icons.sports (branco, 48px)
- **Texto**: "ATLETAS" (branco, bold)

#### Card ADICIONAR JOGO

- **Fundo**: Cinza
- **Ícone**: Icons.add (branco, 48px)
- **Texto**: "ADICIONAR JOGO" (branco, bold)

#### Card EDITAR PERFIL

- **Fundo**: Cinza
- **Ícone**: Icons.edit (branco, 48px)
- **Texto**: "EDITAR PERFIL" (branco, bold)

#### Card ALTERNAR PERFIL

- **Fundo**: Azul primário
- **Ícone**: Icons.swap_horiz (branco, 48px)
- **Texto**: "ALTERNAR PERFIL" (branco, bold)

### TELA 6.1 - Lista de Atletas (Profissional Técnico)

**Descrição Geral**: Lista de atletas que o profissional técnico tem permissão para administrar.

**Header**: Mantém padrão com notificações

**Título da Seção**:

- "MEUS ATLETAS"
- Cor: azul primário
- Centralizado

**Lista de Atletas**:

#### Item Atleta

- **Layout**: Horizontal
- **Avatar**: Icons.person (círculo azul claro, 48px)
- **Nome**: "Fulano Silva dos Santos" (preto, bold)
- **Ações** (lado direito):
  - **Visualizar Jogos**: Icons.visibility (azul, 24px)
  - **Adicionar Jogo**: Icons.add (azul, 24px)
  - **Cancelar Administração**: Icons.close (vermelho, 24px)
- **Gap**: 8px entre ações

**Nota Explicativa** (rodapé):

- Texto pequeno: "Ao clicar no X é desvinculado um novo jogo para o atleta em questão que ele pode administrar ou já administrou"

### TELA 6.2 - Jogos do Atleta

**Descrição Geral**: Lista de jogos específicos de um atleta selecionado.

**Header**: "ATLETA FULANO SILVA DOS SANTOS" (azul primário)

**Lista de Jogos**:

#### Item Jogo

- **Layout**: Horizontal em linha
- **Colunas**:
  1. **Data**: "26/10/2023" (20% largura)
  2. **Adversários**: "Fulano/Beltrano x Ciclano..." (50% largura)
  3. **Ações**: (30% largura)
     - **Editar**: Icons.edit (azul, 20px)
     - **Visualizar**: Icons.visibility (azul, 20px)
     - **Status**: Icons.check (verde) ou Icons.remove (amarelo)

**Botão de Ação Principal**:

- **"Novo Jogo"**:
  - Fundo azul primário
  - Posição: parte inferior centralizada
  - Largura: 60% da tela
  - Altura: 48px

**Estados Visuais**:

- **Jogo Preenchido**: Check verde, fundo normal
- **Jogo Pendente**: Traço amarelo, texto levemente acinzentado

---

## 🏆 Módulo Perfil Atleta

### TELA 7 - Dashboard Atleta

**Descrição Geral**: Painel principal para atletas gerenciarem jogos e conexões.

**Header**:

- Fundo azul primário
- Texto "FULANO DE TAL" (branco, bold)
- **Dupla notificação**:
  - Badge vermelho (solicitações de jogos)
  - Badge azul (solicitações de amigos)

**Seção de Solicitações de Jogos**:

- **Título**: "SOLICITAÇÕES DE JOGOS" (azul primário, bold)
- **Layout**: Similar ao profissional técnico
- **Ações**: aceitar/recusar solicitações

**Grid Principal** (2x2):

#### Card MINHAS ESTATÍSTICAS

- **Fundo**: Azul primário
- **Ícone**: Icons.bar_chart (branco, 48px)
- **Texto**: "MINHAS ESTATÍSTICAS" (branco, bold)

#### Card ADICIONAR JOGO

- **Fundo**: Cinza
- **Ícone**: Icons.add (branco, 48px)
- **Texto**: "ADICIONAR JOGO" (branco, bold)

#### Card LISTAR JOGOS

- **Fundo**: Cinza
- **Ícone**: Icons.list (branco, 48px)
- **Texto**: "LISTAR JOGOS" (branco, bold)

#### Card ALTERNAR PERFIL

- **Fundo**: Azul primário
- **Ícone**: Icons.swap_horiz (branco, 48px)
- **Texto**: "ALTERNAR PERFIL" (branco, bold)

### TELA 7.1 - Lista de Jogos do Atleta

**Descrição Geral**: Lista completa de jogos do atleta com filtros.

**Header**: Mantém padrão do atleta com notificações

**Seção de Controles**:

- **Campo Busca**: "Buscar atletas" (para filtrar jogos)
- **Largura**: 80% da tela
- **Ícone**: Icons.search

**Título da Seção**:

- "MEUS JOGOS"
- Cor: azul primário
- Centralizado

**Lista de Jogos**:

#### Item Jogo

- **Layout**: Horizontal
- **Estrutura**:
  1. **Data**: "26/10/2023" (15% largura)
  2. **Adversários**: "Fulano/Beltrano x Ciclano..." (55% largura)
  3. **Ações**: (30% largura)

**Ações Disponíveis**:

- **Visualizar**: Icons.visibility (azul, 20px)
- **Editar**: Icons.edit (azul, 20px) - apenas se atleta criou o jogo
- **Status**: Icons.check (verde) ou Icons.remove (amarelo)

**Botão de Ação Principal**:

- **"Novo Jogo"**:
  - Fundo azul primário
  - Posição: inferior centralizado
  - Largura: 50% da tela

**Funcionalidade Especial**:

- **Se logado como atleta**: busca filtra seus próprios jogos
- **Se logado como profissional técnico**: busca lista jogos de atletas específicos

---

## 🎮 Módulo Cadastro de Jogo

### TELA 8 - Modo de Jogo

**Descrição Geral**: Seleção do tipo de jogo a ser cadastrado.

**Header**: Padrão do usuário logado

**Título Principal**:

- "MODO DE JOGO"
- Cor: azul primário
- Centralizado
- Fonte: grande, bold

**Seleção de Modo** (2 cards lado a lado):

#### Card SIMPLES

- **Largura**: 45% da tela
- **Fundo**: Azul primário
- **Ícone**: Icons.person (branco, 64px)
- **Texto**: "SIMPLES" (branco, bold, grande)
- **Estado**: Selecionável
- **Border radius**: 16px

#### Card DUPLAS

- **Largura**: 45% da tela
- **Fundo**: Cinza
- **Ícone**: Icons.group (branco, 64px)
- **Texto**: "DUPLAS" (branco, bold, grande)
- **Estado**: Selecionável
- **Border radius**: 16px

**Gap**: 10% entre os cards

### TELA 8.1 - Cadastro Jogo Simples

**Descrição Geral**: Formulário para cadastro de jogo individual.

**Header**: "CADASTRO DE JOGO" (azul primário)

**Campos do Formulário**:

1. **Data do Jogo**:
   - Ícone prefix: Icons.calendar_today
   - Campo date picker
   - Largura: 48% da tela

2. **Local**:
   - Campo de texto
   - Possibilidade de vincular arena existente
   - Largura: 48% da tela
   - Gap: 4%

3. **Seção Horários** (lado a lado):
   - **Início**: time picker (48% largura)
   - **Término**: time picker (48% largura)
   - **Campos opcionais**: marcação visual

4. **Buscar Atleta 1**:
   - Campo de busca com autocomplete
   - Ícone prefix: Icons.person_search
   - **Se profissional técnico**: busca apenas atletas com permissão
   - **Se atleta**: campo readonly com próprio nome

5. **Buscar Atleta 2**:
   - Campo de busca para adversário
   - Ícone "X" para remover seleção
   - Funcionalidade: se não encontrado, opção de convidar

6. **Adicionar Profissional Técnico**:
   - Campo opcional
   - Busca entre profissionais técnicos cadastrados

**Funcionalidade de Convite**:

- **Se atleta não encontrado**:
  - Modal para inserir email/celular
  - Opção de salvar convite para histórico
  - Envio por WhatsApp/email

**Botões de Ação**:

- **Salvar**: Fundo azul primário (45% largura)
- **Cancelar**: Fundo amarelo (45% largura)

### TELA 8.2 - Cadastro Jogo Duplas

**Descrição Geral**: Formulário expandido para jogos de duplas.

**Campos Adicionais** (além dos do jogo simples):

3. **Buscar Atleta 3**:
   - Terceiro jogador da dupla
   - Mesma funcionalidade de busca

4. **Buscar Atleta 4**:
   - Quarto jogador da dupla
   - Ícone "X" para remoção

**Layout Visual**:

- Campos organizados para mostrar claramente as duplas
- **Dupla 1**: Atleta 1 + Atleta 2
- **vs**
- **Dupla 2**: Atleta 3 + Atleta 4

**Validações**:

- Todos os 4 atletas devem ser diferentes
- Pelo menos 3 atletas obrigatórios para salvar

---

## 🎯 Módulo Desenvolvimento do Jogo

### TELA 9 - Cadastro do Ponto

**Descrição Geral**: Interface para registrar primeiro ponto/saque do jogo.

**Header**: "CADASTRO DE JOGO" (azul primário)

**Placar Superior**:

- Display simples: "0 0 0 0 0" (sets e games zerados)
- Fundo: cinza claro
- Posição: parte superior centralizada

**Modal Cadastro de Ponto**:

- **Overlay**: Fundo escuro semitransparente
- **Container**: Branco, 90% da largura, centralizado

**Seção SAQUE**:

- **Título**: "SAQUE" (azul primário, bold)

**Dropdowns do Saque**:

1. **Quem sacou?**: Lista dos jogadores do jogo
2. **Estilo do saque?**: Opções predefinidas (slice, potência, etc.)
3. **De onde sacou?**: Posições da quadra
4. **Aonde sacou?**: Destinos do saque

**Checkboxes de Resultado**:

- **"Finalizou o ponto?"**:
  - Se SIM: ponto atribuído ao sacador
  - Se NÃO: habilita "Adicionar Jogada"
- **"Foi fora/rede?"**:
  - Se SIM: ponto para o adversário
  - Lógica: fora/rede inverte o ponto

**Botão Condicional**:

- **Se finalizou**: "Próximo Ponto"
- **Se não finalizou**: "ADICIONAR JOGADA" (destaque azul)

**Botões de Ação**:

- **Salvar**: Registra o ponto
- **Cancelar**: Volta à tela anterior

### TELA 9.1 - Adicionando Jogadas

**Descrição Geral**: Continuação do ponto com múltiplas jogadas.

**Lista de Jogadas** (parte superior):

- **Histórico do Ponto**:
  - "Saque - Fulano - Saque"
  - "Bola 1 - Ciclano - Devolução"
  - "Bola 2 - Beltrano - Curta"
- **Layout**: Lista vertical, texto pequeno

**Modal JOGADA** (similar ao saque):

- **Título**: "JOGADA" (azul primário)

**Dropdowns da Jogada**:

1. **Quem finalizou?**: Jogador atual
2. **Qual jogada finalizou?**: Tipo de jogada
3. **Qual golpe?**: Backhand, smash, lob, etc.
4. **Tempo?**: Timing da jogada

**Checkboxes**: Idênticos ao saque

- Finalizou o ponto?
- Foi fora/rede?

**Botão Dinâmico**:

- **"Terminar"**: Se ponto finalizado
- **"+ ADICIONAR MAIS ITEM +"**: Se continua

### TELA 9.2 - Placar do Jogo

**Descrição Geral**: Visualização completa do desenvolvimento do jogo.

**Header**: "PLACAR DO JOGO" (azul primário)

**Display Principal do Placar**:

```
Fulano/Beltrano     [6] [1] [5] [30]
Ciclano/Adriano     [4] [1] [0] [15]
```

- **Colunas**: SET 1, SET 2, Games atuais, Pontos atuais
- **Cores**: Azul para quem está ganhando
- **Fonte**: Grande e bold para legibilidade

**Lista de Pontos** (histórico):

#### Item de Ponto

- **Layout**: Horizontal
- **Estrutura**:
  - **Set/Game**: "SET 1 - G1" (15% largura)
  - **Descrição**: "15X0 - Fulano/Beltrano x Ciclano..." (65% largura)
  - **Ações**: Icons.visibility, Icons.edit (20% largura)

**Estados dos Pontos**:

- **Ponto Completo**: Fundo branco, texto normal
- **Ponto em Andamento**: Fundo amarelo claro

**Botão de Ação Principal**:

- **"ADICIONAR PONTO +"**:
  - Fundo azul primário
  - Largura: 80% da tela
  - Centralizado na parte inferior
  - Ícone: Icons.add

**Funcionalidades Especiais**:

- **Auto-cálculo**: Pontuação automática conforme regras do Beach Tennis
- **Validações**: Não permite pontuações inválidas
- **Finalização automática**: Detecta fim de sets e jogos

---

# Módulo Conexões e Estatísticas - Apex Sports - Beach Tenis

## 🤝 Módulo Conexões/Amigos

### TELA 11 - Lista de Amigos

**Descrição Geral**: Interface para gerenciar rede de contatos do atleta com funcionalidades sociais completas.

**Header**:

- Fundo azul primário (#4A90E2)
- Ícone voltar (Icons.arrow_back) à esquerda, cor branca
- Avatar circular do usuário (56x56px)
- Nome "FULANO DE TAL" ao lado do avatar, texto branco, bold
- **Dupla notificação no canto direito**:
  - Badge vermelho com número (solicitações de jogos)
  - Badge azul com número (solicitações de amigos)
- Ícone menu (Icons.more_vert) à direita

**Seção de Busca e Adição**:

- **Campo de Busca**:
  - Largura: 85% da tela
  - Placeholder: "Buscar atletas"
  - Ícone prefix: Icons.search (cinza médio)
  - Fundo: branco
  - Borda: cinza clara, arredondada (12px)
  - Height: 48px

- **Botão Adicionar Amigo**:
  - Ícone: Icons.add (azul primário)
  - Formato: circular (FloatingActionButton pequeno)
  - Tamanho: 48x48px
  - Posição: lado direito da busca
  - Elevação: 4.0
  - Cor de fundo: branca
  - Gap da busca: 12px

**Título da Seção**:

- "MEUS AMIGOS" (azul primário, bold, 18px)
- **Contador**: "564 Amigos" (cinza médio, 14px)
- Alinhamento: esquerda
- Margin vertical: 16px

**Lista de Amigos**:

#### Card Amigo Individual

- **Container**: Card branco com elevação 2.0
- **Layout**: Horizontal
- **Padding**: 16px
- **Margin vertical**: 8px
- **Border radius**: 12px

**Estrutura do Card**:

1. **Área do Avatar** (15% largura):
   - **Avatar**: Círculo 56x56px
   - **Imagem padrão**: Icons.person se sem foto
   - **Fundo**: azul claro (#E3F2FD)
   - **Cor do ícone**: azul primário

2. **Área de Informações** (70% largura):
   - **Nome Principal**: "Amigo 1" (preto, bold, 16px)
   - **Subtítulo**: "X amigos em comum" (cinza médio, 14px)
   - **Padding left**: 12px do avatar

3. **Área de Ações** (15% largura):
   - **Menu Dropdown**: Icons.more_vert (cinza, 24px)
   - **Posição**: centralizado verticalmente
   - **Toque**: área mínima 44x44px

**Menu Dropdown de Ações**:

- **Container**: Fundo branco, elevação 8.0
- **Border radius**: 8px
- **Padding**: 8px vertical

**Opções do Menu**:

1. **Desfazer amizade**:
   - Ícone: Icons.person_remove (vermelho, 20px)
   - Texto: "Desfazer amizade" (vermelho, 14px)
   - Padding: 12px horizontal, 8px vertical

2. **Adicionar jogo como parceiro**:
   - Ícone: Icons.group_add (azul, 20px)
   - Texto: "Adicionar jogo como parceiro" (azul, 14px)
   - Padding: 12px horizontal, 8px vertical

3. **Adicionar jogo como adversário**:
   - Ícone: Icons.sports (laranja, 20px)
   - Texto: "Adicionar jogo como adversário" (laranja, 14px)
   - Padding: 12px horizontal, 8px vertical

4. **Mandar mensagem**:
   - Ícone: Icons.message (verde, 20px)
   - Texto: "Mandar mensagem" (verde, 14px)
   - Padding: 12px horizontal, 8px vertical

**Divisores**: Linha cinza clara (1px) entre opções

### Funcionalidades da Busca de Amigos

#### Quando Atleta é Encontrado

- **Lista de Resultados**:
  - Layout similar aos amigos existentes
  - **Botão de Ação**: "Adicionar" (azul primário)
  - **Informações**: Nome, foto, atletas em comum

#### Quando Atleta NÃO é Encontrado

- **Card de Estado Vazio**:
  - Ícone: Icons.person_search (cinza, 64px)
  - Título: "Atleta não encontrado"
  - Subtítulo: "Convide seus amigos para se juntarem ao Apex Sports - Beach Tenis"

**Opções de Compartilhamento**:

1. **Botão WhatsApp**:
   - Ícone: Icons.message (verde WhatsApp)
   - Texto: "Compartilhar via WhatsApp"
   - Largura: 48% da tela
   - Height: 48px
   - Fundo: verde claro

2. **Botão E-mail**:
   - Ícone: Icons.email (azul)
   - Texto: "Compartilhar via E-mail"
   - Largura: 48% da tela
   - Height: 48px
   - Fundo: azul claro
   - Gap: 4% entre botões

### Menu Superior Direito (ícone ⋮)

**Container do Menu**:

- Fundo: branco
- Elevação: 8.0
- Border radius: 8px
- Largura: 200px

**Opções do Menu Global**:

1. **Sair**:
   - Ícone: Icons.exit_to_app (vermelho, 20px)
   - Texto: "Sair" (vermelho, 14px)

2. **Editar Perfil**:
   - Ícone: Icons.edit (azul, 20px)
   - Texto: "Editar Perfil" (preto, 14px)

3. **Modo escuro/claro**:
   - Ícone: Icons.brightness_6 (cinza, 20px)
   - Texto: "Modo escuro" (preto, 14px)
   - Toggle switch à direita

4. **Alternar perfil**:
   - Ícone: Icons.swap_horiz (azul, 20px)
   - Texto: "Alternar perfil" (preto, 14px)
   - **Condicional**: Só aparece se usuário tem múltiplos perfis

### Estados da Lista

#### Estado Carregando

- **Skeleton Cards**: 5-6 placeholders
- **Shimmer effect**: Animação suave
- **Cores**: Cinza claro alternando

#### Estado Vazio

- **Ícone**: Icons.people_outline (cinza, 80px)
- **Título**: "Nenhum amigo ainda"
- **Subtítulo**: "Comece adicionando seus primeiros amigos"
- **Botão**: "Buscar Amigos" (azul primário)

#### Estado de Erro

- **Ícone**: Icons.error_outline (vermelho, 64px)
- **Título**: "Erro ao carregar amigos"
- **Botão**: "Tentar novamente" (azul primário)

---

## 📊 Módulo Estatísticas

### TELA 12 - Estatísticas Individuais

**Descrição Geral**: Dashboard completo de análise de performance do atleta com gráficos e métricas detalhadas.

**Header**:

- Fundo azul primário
- Texto "FULANO DE TAL" (branco, bold)
- Layout padrão do atleta
- Notificações (badges) no canto direito

**Título Principal**:

- "MINHAS ESTATÍSTICAS"
- Cor: azul primário (#4A90E2)
- Fonte: 24px, bold
- Alinhamento: centralizado
- Margin vertical: 20px

**Seção de Filtro de Data** (opcional):

- **Container**: Card branco, elevação 2.0
- **Padding**: 16px
- **Border radius**: 12px
- **Margin bottom**: 20px

**Campos de Data**:

1. **Campo "De"**:
   - Largura: 45% da tela
   - Label: "Data inicial"
   - Ícone: Icons.calendar_today
   - Date picker ao clicar

2. **Campo "Até"**:
   - Largura: 45% da tela
   - Label: "Data final"
   - Ícone: Icons.calendar_today
   - Gap: 10% entre campos

**Botão Filtrar**:

- Texto: "Aplicar Filtro"
- Fundo: azul primário
- Largura: 100%
- Height: 44px
- Margin top: 12px

### Grid de Métricas Principais (2x2)

**Container do Grid**:

- Spacing: 12px entre cards
- Margin horizontal: 16px

#### Card 1 - Saque

- **Fundo**: Azul claro (#E3F2FD)
- **Valor**: "15%" (azul primário, 32px, bold)
- **Label**: "ÍNDICE GERAL SAQUE" (cinza escuro, 12px, bold)
- **Ícone decorativo**: Icons.sports_tennis (azul claro, 24px, canto superior direito)
- **Padding**: 16px
- **Border radius**: 12px

#### Card 2 - Devolução

- **Fundo**: Azul claro (#E3F2FD)
- **Valor**: "85%" (azul primário, 32px, bold)
- **Label**: "ÍNDICE GERAL DEVOLUÇÃO" (cinza escuro, 12px, bold)
- **Ícone decorativo**: Icons.undo (azul claro, 24px)

#### Card 3 - Direita

- **Fundo**: Azul claro (#E3F2FD)
- **Valor**: "5%" (azul primário, 32px, bold)
- **Label**: "ÍNDICE LADO DIREITA" (cinza escuro, 12px, bold)
- **Ícone decorativo**: Icons.trending_up (azul claro, 24px)

#### Card 4 - Esquerda

- **Fundo**: Azul claro (#E3F2FD)
- **Valor**: "58%" (azul primário, 32px, bold)
- **Label**: "ÍNDICE LADO ESQUERDA" (cinza escuro, 12px, bold)
- **Ícone decorativo**: Icons.trending_down (azul claro, 24px)

### Seção de Gráficos

**Container Principal**:

- **Margin top**: 24px
- **Padding horizontal**: 16px

#### Gráfico Pizza Principal

- **Posição**: Centro-esquerda
- **Dimensão**: 150x150px
- **Cores**:
  - Azul primário: 80%
  - Amarelo: 20%
- **Labels**: Percentuais visíveis no centro
- **Título**: "DESEMPENHO GERAL" (cinza, 14px, bold)
- **Legend**:
  - Azul: "Vitórias"
  - Amarelo: "Derrotas"

#### Gráfico de Barras Horizontais

- **Posição**: Centro-direita
- **Dimensão**: 200x120px
- **Título**: "RESULTADO | SETS |" (cinza, 12px)

**Dados das Barras**:

- **PRIMEIRO**: 3 vitórias (verde #4CAF50)
- **SEGUNDO**: 2 vitórias (azul #2196F3)
- **TERCEIRO**: 1 vitória (laranja #FF9800)

**Especificações das Barras**:

- Height: 20px cada
- Border radius: 4px
- Spacing: 8px entre barras
- Labels à esquerda (12px, cinza)
- Valores à direita (12px, bold)

#### Gráfico Donut "BOLA DE FINALIZAÇÃO"

- **Posição**: Inferior esquerda
- **Dimensão**: 120x120px
- **Título**: "BOLA DE FINALIZAÇÃO" (cinza, 12px, bold)

**Segmentos do Donut**:

- Verde (34%): Primeira bola
- Amarelo (31%): Segunda bola
- Laranja (20%): Terceira bola
- Vermelho (15%): Outras

**Legend Lateral**:

- **PRIMEIRA BOLA**: 15 (verde, 10px)
- **SEGUNDA BOLA**: 10 (amarelo, 10px)
- **TERCEIRA BOLA**: 8 (laranja, 10px)
- **QUARTA BOLA**: 5 (vermelho, 10px)
- **REVIVIDA**: 3 (cinza, 10px)

#### Gráfico Donut "GOLPE DE FINALIZAÇÃO"

- **Posição**: Inferior direita
- **Dimensão**: 120x120px
- **Título**: "GOLPE DE FINALIZAÇÃO" (cinza, 12px, bold)

**Segmentos e Legend**:

- **GOLPE 1**: 50 finalizações (azul)
- **GOLPE 2**: 35 finalizações (verde)
- **GOLPE 3**: 20 finalizações (amarelo)
- **GOLPE 4**: 15 finalizações (laranja)
- **GOLPE 5**: 12 finalizações (vermelho)

### Botão de Navegação

**"MINHAS DUPLAS"**:

- **Posição**: Centralizado na parte inferior
- **Fundo**: Azul primário
- **Largura**: 60% da tela
- **Height**: 48px
- **Border radius**: 24px
- **Texto**: Branco, 16px, bold
- **Ícone**: Icons.group (branco, 20px) à esquerda
- **Margin top**: 32px
- **Elevação**: 4.0

### TELA 12.1 - Lista de Duplas para Estatísticas

**Descrição Geral**: Interface para seleção de parceiro específico para análise de estatísticas em dupla.

**Header**:

- Padrão do atleta
- Título específico na AppBar

**Título da Seção**:

- "MINHAS ESTATÍSTICAS EM DUPLAS"
- Cor: azul primário
- Fonte: 20px, bold
- Alinhamento: centralizado
- Margin vertical: 20px

**Subtítulo Explicativo**:

- "Selecione um parceiro para ver as estatísticas específicas da dupla"
- Cor: cinza médio
- Fonte: 14px
- Alinhamento: centralizado
- Margin bottom: 24px

### Lista de Parceiros

#### Item Parceiro Individual

- **Container**: Card branco
- **Layout**: Horizontal
- **Padding**: 16px
- **Margin vertical**: 8px
- **Border radius**: 12px
- **Elevação**: 2.0

**Estrutura do Card**:

1. **Avatar do Parceiro** (20% largura):
   - Círculo: 48x48px
   - Ícone padrão: Icons.person
   - Fundo: azul claro
   - Border: 2px azul primário

2. **Informações** (60% largura):
   - **Nome**: "Beltrano Lorem Ipsum" (preto, bold, 16px)
   - **Subtítulo**: "12 jogos juntos" (cinza médio, 14px)
   - **Última partida**: "Última: 15/03/2024" (cinza claro, 12px)

3. **Ação** (20% largura):
   - **Botão Visualizar**:
     - Ícone: Icons.visibility (azul primário, 24px)
     - Fundo: azul claro (10% opacidade)
     - Formato: circular, 40x40px
     - Centralizado verticalmente

**Indicadores de Performance**:

- **Badge de Vitórias**:
  - Formato: pequeno circle
  - Cor: verde se > 50% vitórias, vermelho se < 50%
  - Posição: canto superior direito do avatar
  - Tamanho: 12x12px

### Estados da Lista

#### Estado com Dados

- **Scroll vertical**: Lista completa de parceiros
- **Ordenação**: Por número de jogos (decrescente)
- **Separadores**: Linha cinza clara entre itens

#### Estado Vazio

- **Ícone**: Icons.group_outlined (cinza, 80px)
- **Título**: "Nenhuma dupla encontrada"
- **Subtítulo**: "Você ainda não jogou em dupla com ninguém"
- **Botão**: "Criar Novo Jogo" (azul primário)

### Botão de Ação Principal

**"Novo Jogo"**:

- **Posição**: Inferior centralizado
- **Fundo**: Azul primário
- **Largura**: 50% da tela
- **Height**: 48px
- **Texto**: Branco, bold
- **Ícone**: Icons.add (branco) à esquerda
- **Funcionalidade**: Direciona para cadastro de jogo em dupla
- **Margin top**: 20px

### TELA 12.2 - Estatísticas da Dupla Selecionada

**Descrição Geral**: Dashboard específico mostrando métricas de performance com o parceiro selecionado.

**Header Personalizado**:

- **Fundo**: Azul primário
- **Título**: "ESTATÍSTICAS COM BELTRANO" (branco, bold, 18px)
- **Subtítulo**: "12 jogos • 8 vitórias • 4 derrotas" (branco, 14px)
- **Ícone voltar**: Icons.arrow_back à esquerda

### Seção de Filtro de Data

- **Layout**: Idêntico à TELA 12
- **Funcionalidade**: Filtra apenas jogos com o parceiro específico

### Resumo da Dupla

**Card de Performance**:

- **Container**: Card destacado, elevação 4.0
- **Fundo**: Gradiente azul claro
- **Padding**: 20px
- **Border radius**: 16px

**Métricas da Dupla**:

1. **Taxa de Vitória**:
   - Valor: "67%" (grande, bold)
   - Label: "Taxa de vitórias juntos"
   - Cor: verde se > 50%, vermelho se < 50%

2. **Jogos Totais**:
   - Valor: "12" (grande, bold)
   - Label: "Jogos disputados"

3. **Última Partida**:
   - Valor: "15/03/2024" (médio)
   - Label: "Último jogo"
   - Status: "Vitória" ou "Derrota" (colorido)

### Grid de Métricas (Layout idêntico à TELA 12)

**Diferenças nos Dados**:

- **Cálculos**: Baseados apenas em jogos da dupla específica
- **Labels**: Mantêm mesmo formato
- **Cores**: Padrão azul/amarelo/verde
- **Valores**: Refletem performance conjunta

### Gráficos Específicos da Dupla

#### Gráfico de Evolução Temporal

- **Tipo**: Linha
- **Dimensão**: Largura total, 120px height
- **Dados**: Performance ao longo do tempo
- **Eixo X**: Datas dos jogos
- **Eixo Y**: Taxa de vitória
- **Linha**: Azul primário, 2px
- **Pontos**: Círculos azuis, 4px

#### Gráfico Comparativo

- **Tipo**: Barras duplas
- **Comparação**: "Individual vs Em Dupla"
- **Categorias**: Saque, Devolução, Finalização
- **Cores**:
  - Individual: cinza
  - Em dupla: azul primário

### Seção de Jogos Recentes

**Título**: "ÚLTIMOS JOGOS JUNTOS" (azul primário, bold)

#### Lista de Jogos

- **Layout**: Cards horizontais compactos
- **Informações por jogo**:
  - Data e horário
  - Adversários enfrentados
  - Resultado (vitória/derrota)
  - Placar final
  - Duração da partida

**Card de Jogo Individual**:

- **Height**: 60px
- **Padding**: 12px
- **Border left**: 4px (verde vitória, vermelho derrota)

### Funcionalidades Adicionais

#### Botão Comparar

- **Texto**: "Comparar com Outras Duplas"
- **Ícone**: Icons.compare_arrows
- **Funcionalidade**: Modal de comparação

#### Botão Histórico Completo

- **Texto**: "Ver Todos os Jogos"
- **Ícone**: Icons.history
- **Funcionalidade**: Lista completa de partidas

#### Botão Novo Jogo com Esta Dupla

- **Posição**: Destaque na parte inferior
- **Texto**: "Jogar Novamente com Beltrano"
- **Fundo**: Verde (diferente do azul padrão)
- **Funcionalidade**: Cadastro de jogo pré-preenchido

### Indicadores Visuais Especiais

#### Streaks

- **Vitórias Consecutivas**: Badge verde "3 vitórias seguidas"
- **Melhor Sequência**: "Melhor: 5 vitórias seguidas"

#### Medalhas de Conquista

- **Primeira Vitória**: Ícone troféu dourado
- **10 Jogos**: Badge "Parceiro Confiável"
- **70%+ Vitórias**: Badge "Dupla Imbatível"

---

## 🎨 Especificações Visuais Específicas

### Paleta de Cores para Gráficos

- **Primária**: #4A90E2 (azul principal)
- **Secundária**: #FFC107 (amarelo)
- **Sucesso**: #4CAF50 (verde)
- **Alerta**: #FF9800 (laranja)
- **Erro**: #F44336 (vermelho)
- **Neutro**: #9E9E9E (cinza)

### Animações e Transições

- **Gráficos**: Animação de entrada 800ms
- **Cards**: Hover elevation (web) 300ms
- **Modais**: Slide up 250ms
- **Loading**: Shimmer effect contínuo
- **Navigation**: Fade transition 200ms

### Estados de Loading

- **Gráficos**: Skeleton com forma do gráfico
- **Listas**: Cards skeleton com shimmer
- **Métricas**: Placeholder com largura variável

### Responsividade

- **Mobile Portrait**: Layout vertical otimizado
- **Mobile Landscape**: Grid 2x4 para métricas
- **Tablet**: Gráficos maiores, layout expandido
- **Breakpoints**: 480px, 768px, 1024px

### Acessibilidade

- **Contrast**: WCAG AA compliance
- **Touch targets**: Mínimo 44x44px
- **Screen readers**: Labels descritivos
- **Focus indicators**: Borda azul 2px
- **Color blindness**: Padrões além de cores

Este módulo completa a especificação técnica das funcionalidades sociais e analíticas do aplicativo Apex Sports - Beach Tenis, fornecendo base sólida para implementação das features mais avançadas de conexão entre usuários e análise de performance esportiva.
