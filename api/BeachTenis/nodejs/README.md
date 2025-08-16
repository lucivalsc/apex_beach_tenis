# Beach Tênis API

API RESTful em Node.js para o sistema de Beach Tênis, com suporte a usuários, arenas, jogos e treinamentos.

## Requisitos

- Node.js 14+
- MySQL 5.7+

## Instalação

1. Clone o repositório
2. Instale as dependências:

```bash
cd nodejs
npm install
```

3. Crie um arquivo `.env` baseado no `.env.example`:

```bash
cp .env.example .env
```

4. Configure as variáveis de ambiente no arquivo `.env` com suas credenciais do MySQL e outras configurações.

5. Inicie o servidor:

```bash
npm start
```

Para desenvolvimento, use:

```bash
npm run dev
```

## Estrutura do Projeto

```text
nodejs/
  │── config/             # Configurações do projeto
  │   └── database.js     # Configuração do banco de dados MySQL
  │── middleware/         # Middlewares da aplicação
  │   │── authMiddleware.js # Middleware de autenticação JWT
  │   └── customUnauthorizedMiddleware.js # Tratamento personalizado de erros 401/403
  │── models/             # Modelos de dados
  │   │── baseEntity.js   # Modelo base com campos comuns
  │   │── user.js         # Modelo de usuário
  │   │── arena.js        # Modelo de arena
  │   │── game.js         # Modelo de jogo
  │   │── training.js     # Modelo de treinamento
  │   │── loginModel.js   # Modelo para login com email/senha
  │   │── loginSocialModel.js # Modelo para login social
  │   │── tokenModel.js   # Modelo para tokens JWT
  │   │── jwtConfig.js    # Configurações do JWT
  │   └── index.js        # Exportação de todos os modelos
  │── routes/             # Rotas da API
  │   │── userRoutes.js   # Rotas de usuário e autenticação
  │   │── arenaRoutes.js  # Rotas de arena
  │   │── gameRoutes.js   # Rotas de jogo
  │   └── trainingRoutes.js # Rotas de treinamento
  │── app.js              # Arquivo principal da aplicação
  │── package.json        # Dependências e scripts
  └── .env                # Variáveis de ambiente (não versionado)
```

## Endpoints da API

### Usuários

- `GET /api/user` - Listar todos os usuários
- `GET /api/user/:userId` - Obter usuário por ID
- `POST /api/user` - Criar novo usuário
- `PUT /api/user/:userId` - Atualizar usuário
- `DELETE /api/user/:userId` - Desativar usuário
- `POST /api/user/login` - Login com email e senha
- `POST /api/user/login/google` - Login com Google
- `POST /api/user/login/facebook` - Login com Facebook
- `POST /api/user/refresh-token` - Renovar token JWT
- `POST /api/user/logout` - Logout

### Arenas

- `GET /api/arena` - Listar todas as arenas
- `GET /api/arena/:arenaId` - Obter arena por ID
- `POST /api/arena` - Criar nova arena
- `PUT /api/arena/:arenaId` - Atualizar arena
- `DELETE /api/arena/:arenaId` - Desativar arena

### Jogos

- `GET /api/game` - Listar todos os jogos
- `GET /api/game/:gameId` - Obter jogo por ID
- `POST /api/game` - Criar novo jogo
- `PUT /api/game/:gameId` - Atualizar jogo
- `DELETE /api/game/:gameId` - Desativar jogo
- `POST /api/game/:gameId/player/:playerId` - Adicionar jogador ao jogo
- `DELETE /api/game/:gameId/player/:playerId` - Remover jogador do jogo

### Treinamentos

- `GET /api/training` - Listar todos os treinamentos
- `GET /api/training/:trainingId` - Obter treinamento por ID
- `POST /api/training` - Criar novo treinamento
- `PUT /api/training/:trainingId` - Atualizar treinamento
- `DELETE /api/training/:trainingId` - Desativar treinamento
- `POST /api/training/:trainingId/student/:studentId` - Adicionar aluno ao treinamento
- `DELETE /api/training/:trainingId/student/:studentId` - Remover aluno do treinamento

## Autenticação

A API utiliza autenticação JWT (JSON Web Token). Para acessar endpoints protegidos, inclua o token no cabeçalho de autorização:

```http
Authorization: Bearer seu_token_jwt
```

## Banco de Dados

O banco de dados é inicializado automaticamente na primeira execução, criando as tabelas necessárias se não existirem.

## Status

Os registros usam o seguinte padrão de status:

- 1: Ativo
- 2: Desativado

## Segurança

- Senhas são armazenadas com hash SHA-256 em base64
- Tokens JWT expiram em 24 horas por padrão
- Sistema de invalidação de tokens para logout seguro
- Middleware centralizado para autenticação JWT
- Tratamento personalizado de erros de autenticação
- Validação de modelos para todas as operações

## Modelos de Autenticação

### LoginModel

Modelo para autenticação com email e senha.

### LoginSocialModel

Modelo para autenticação com provedores sociais (Google, Facebook).

### TokenModel

Modelo para gerenciamento de tokens JWT e refresh tokens.

## Status da API

A API fornece um endpoint para verificar seu status:

```http
GET /api/status
```

Resposta:

```json
{
  "status": "online",
  "timestamp": "2023-11-20T12:34:56.789Z",
  "environment": "development"
}
```
