# Documentação da API OnTarget Server Deluxe

## Sumário

1. [Introdução](#introdução)
2. [Configuração Inicial](#configuração-inicial)
3. [Endpoints Básicos](#endpoints-básicos)
4. [Operações GET](#operações-get)
   - [Consultas Simples](#consultas-simples)
   - [Consultas com Filtros](#consultas-com-filtros)
   - [Consultas com Joins](#consultas-com-joins)
   - [Consultas com Ordenação](#consultas-com-ordenação)
   - [Consultas com Paginação](#consultas-com-paginação)
   - [Consultas com Agrupamento](#consultas-com-agrupamento)
5. [Operações POST](#operações-post)
6. [Operações PUT](#operações-put)
7. [Operações DELETE](#operações-delete)
8. [Tratamento de Datas](#tratamento-de-datas)
9. [Sincronização](#sincronização)
10. [Exemplos por Entidade](#exemplos-por-entidade)
    - [Usuários (User)](#usuários-user)
    - [Clientes (Client)](#clientes-client)
    - [Produtos (Product)](#produtos-product)
    - [Vendas (Sale)](#vendas-sale)
    - [Visitas (Visit)](#visitas-visit)
    - [Metas (Goal)](#metas-goal)

## Introdução

A API OnTarget Server Deluxe é uma API RESTful que permite a manipulação de dados para o sistema de gestão de vendas e visitas. Esta documentação detalha como utilizar os endpoints da API para realizar operações de consulta (GET), criação (POST), atualização (PUT) e exclusão (DELETE) de dados.

A API foi desenvolvida utilizando Node.js com Sequelize como ORM para interação com o banco de dados MySQL/MariaDB. Todas as respostas são retornadas no formato JSON.

## Configuração Inicial

A API está configurada para preservar o formato original das datas enviadas nas requisições, evitando conversões automáticas de timezone. Isso é particularmente importante para garantir a consistência dos dados entre o cliente e o servidor.

## Endpoints Básicos

A API segue um padrão de rotas baseado nas entidades do sistema:

```
/api/v1/{entidade}
```

Onde `{entidade}` pode ser:
- users
- clients
- products
- sales
- visits
- goals
- brands
- client_brands
- client_services
- client_types
- specialities
- checks
- visit_images
- sync_logs

## Operações GET

### Consultas Simples

Para obter todos os registros de uma entidade:

```
GET /api/v1/{entidade}
```

**Exemplo:**
```json
{
  "entity": "clients",
  "data": {}
}
```

### Consultas com Filtros

Para filtrar registros com base em condições específicas:

```json
{
  "entity": "clients",
  "data": {},
  "filter": [
    {
      "field": "name",
      "operator": "like",
      "value": "%Maria%"
    },
    {
      "field": "created_at",
      "operator": ">=",
      "value": "2023-01-01T00:00:00"
    }
  ]
}
```

**Operadores disponíveis:**
- `=`: Igual
- `!=`: Diferente
- `>`: Maior que
- `>=`: Maior ou igual a
- `<`: Menor que
- `<=`: Menor ou igual a
- `like`: Contém (use % como curinga)
- `in`: Está na lista de valores
- `not in`: Não está na lista de valores
- `between`: Entre dois valores
- `is null`: É nulo
- `is not null`: Não é nulo

### Consultas com Joins

Para obter dados relacionados de múltiplas tabelas:

```json
{
  "entity": "sales",
  "alias": "s",
  "data": {},
  "joins": [
    {
      "table": "clients",
      "alias": "c",
      "on": "s.client_id = c.id",
      "type": "inner"
    },
    {
      "table": "users",
      "alias": "u",
      "on": "s.user_id = u.id",
      "type": "left"
    }
  ],
  "select": ["s.*", "c.name as client_name", "u.name as user_name"]
}
```

**Tipos de join disponíveis:**
- `inner`: Inner join
- `left`: Left join
- `right`: Right join
- `full`: Full join

### Consultas com Ordenação

Para ordenar os resultados:

```json
{
  "entity": "products",
  "data": {},
  "orderBy": [
    {
      "field": "description",
      "direction": "asc"
    },
    {
      "field": "created_at",
      "direction": "desc"
    }
  ]
}
```

### Consultas com Paginação

Para limitar o número de resultados e implementar paginação:

```json
{
  "entity": "clients",
  "data": {},
  "limit": 10,
  "offset": 0
}
```

### Consultas com Agrupamento

Para agrupar resultados e realizar operações de agregação:

```json
{
  "entity": "sales",
  "data": {},
  "select": [
    "client_id",
    "COUNT(*) as total_sales",
    "SUM(value) as total_value"
  ],
  "groupBy": ["client_id"]
}
```

## Operações POST

Para criar novos registros:

```
POST /api/v1
```

**Corpo da requisição:**
```json
{
  "entity": "clients",
  "data": {
    "name": "Novo Cliente",
    "phone": "(11) 98765-4321",
    "address": "Rua Exemplo, 123",
    "latitude": -23.5505,
    "longitude": -46.6333,
    "type": "Farmácia",
    "type_id": "uuid-do-tipo",
    "speciality_id": "uuid-da-especialidade",
    "created_by": "uuid-do-usuario",
    "created_at": "2023-06-15T10:30:00",
    "updated_at": "2023-06-15T10:30:00"
  }
}
```

**Observação importante sobre datas:**
As datas enviadas no formato ISO (como "2023-06-15T10:30:00") serão preservadas exatamente como enviadas, sem conversões automáticas de timezone.

## Operações PUT

Para atualizar registros existentes:

```
PUT /api/v1
```

**Corpo da requisição:**
```json
{
  "entity": "products",
  "data": {
    "description": "Nome Atualizado do Produto",
    "application": "Nova aplicação do produto",
    "updated_at": "2023-06-15T14:45:00"
  },
  "filter": [
    {
      "field": "id",
      "operator": "=",
      "value": "uuid-do-produto"
    }
  ]
}
```

## Operações DELETE

Para excluir registros:

```
DELETE /api/v1
```

**Corpo da requisição:**
```json
{
  "entity": "visits",
  "filter": [
    {
      "field": "id",
      "operator": "=",
      "value": "uuid-da-visita"
    }
  ]
}
```

## Tratamento de Datas

A API foi configurada para preservar o formato original das datas enviadas nas requisições. Isso significa que:

1. Datas enviadas no formato ISO (como "2023-06-15T10:30:00") serão armazenadas exatamente como enviadas
2. Não haverá conversão automática de timezone pelo servidor
3. As datas serão retornadas nas consultas exatamente como foram armazenadas

Isso é especialmente importante para garantir a consistência dos dados entre o cliente e o servidor, evitando problemas com fusos horários diferentes.

## Sincronização

A API suporta sincronização bidirecional de dados entre o servidor e aplicativos clientes. O status de sincronização é controlado pelo campo `sync_status` presente em várias entidades:

- `0`: Não sincronizado
- `1`: Sincronizado com o servidor

Para sincronizar dados:

```
POST /api/v1/sync
```

**Corpo da requisição:**
```json
{
  "entity": "clients",
  "data": [
    {
      "id": "uuid-do-cliente",
      "name": "Nome do Cliente",
      "sync_status": 0,
      "created_at": "2023-06-15T10:30:00",
      "updated_at": "2023-06-15T10:30:00"
    }
  ]
}
```

## Exemplos por Entidade

### Usuários (User)

**Modelo:**
```javascript
const User = sequelize.define('User', {
    id: {
        type: DataTypes.STRING,
        primaryKey: true,
        defaultValue: () => uuidv4(),
    },
    name: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    email: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
    },
    password: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    // outros campos...
});
```

**Exemplo de consulta:**
```json
{
  "entity": "users",
  "data": {},
  "filter": [
    {
      "field": "email",
      "operator": "=",
      "value": "usuario@exemplo.com"
    }
  ],
  "select": ["id", "name", "email", "created_at"]
}
```

### Clientes (Client)

**Modelo:**
```javascript
const Client = sequelize.define('Client', {
    id: {
        type: DataTypes.STRING,
        primaryKey: true,
        defaultValue: () => uuidv4(),
    },
    name: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    phone: {
        type: DataTypes.STRING,
        allowNull: true,
    },
    address: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    latitude: {
        type: DataTypes.FLOAT,
        allowNull: false,
    },
    longitude: {
        type: DataTypes.FLOAT,
        allowNull: false,
    },
    // outros campos...
});
```

**Exemplo de consulta com join:**
```json
{
  "entity": "clients",
  "alias": "c",
  "data": {},
  "joins": [
    {
      "table": "client_types",
      "alias": "ct",
      "on": "c.type_id = ct.id",
      "type": "inner"
    },
    {
      "table": "specialities",
      "alias": "s",
      "on": "c.speciality_id = s.id",
      "type": "left"
    }
  ],
  "select": ["c.*", "ct.name as type_name", "s.name as speciality_name"],
  "filter": [
    {
      "field": "c.created_at",
      "operator": ">=",
      "value": "2023-01-01T00:00:00"
    }
  ],
  "orderBy": [
    {
      "field": "c.name",
      "direction": "asc"
    }
  ]
}
```

### Produtos (Product)

**Modelo:**
```javascript
const Product = sequelize.define('Product', {
    id: {
        type: DataTypes.STRING,
        primaryKey: true,
        defaultValue: () => uuidv4(),
    },
    id_brand: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    product_code: {
        type: DataTypes.STRING,
        allowNull: false,
        unique: true,
    },
    description: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    // outros campos...
});
```

**Exemplo de criação:**
```json
{
  "entity": "products",
  "data": {
    "id_brand": "uuid-da-marca",
    "product_code": "PROD001",
    "description": "Produto de Exemplo",
    "application": "Aplicação de exemplo do produto",
    "created_by": "uuid-do-usuario",
    "created_at": "2023-06-15T10:30:00",
    "updated_at": "2023-06-15T10:30:00"
  }
}
```

### Vendas (Sale)

**Modelo:**
```javascript
const Sale = sequelize.define('Sale', {
    id: {
        type: DataTypes.STRING,
        primaryKey: true,
        defaultValue: () => uuidv4(),
    },
    user_id: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    client_id: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    factory: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    quantity: {
        type: DataTypes.INTEGER,
        allowNull: false,
    },
    value: {
        type: DataTypes.FLOAT,
        allowNull: false,
    },
    // outros campos...
});
```

**Exemplo de consulta com agrupamento:**
```json
{
  "entity": "sales",
  "alias": "s",
  "data": {},
  "joins": [
    {
      "table": "clients",
      "alias": "c",
      "on": "s.client_id = c.id",
      "type": "inner"
    }
  ],
  "select": [
    "c.name as client_name",
    "SUM(s.value) as total_value",
    "SUM(s.quantity) as total_quantity"
  ],
  "filter": [
    {
      "field": "s.month",
      "operator": "=",
      "value": 6
    },
    {
      "field": "s.year",
      "operator": "=",
      "value": 2023
    }
  ],
  "groupBy": ["s.client_id", "c.name"],
  "orderBy": [
    {
      "field": "total_value",
      "direction": "desc"
    }
  ]
}
```

### Visitas (Visit)

**Modelo:**
```javascript
const Visit = sequelize.define('Visit', {
    id: {
        type: DataTypes.STRING,
        primaryKey: true,
        defaultValue: () => uuidv4(),
    },
    user_id: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    check_id: {
        type: DataTypes.STRING,
        allowNull: false,
    },
    observations: {
        type: DataTypes.TEXT,
        allowNull: true,
    },
    // outros campos...
});
```

**Exemplo de consulta com join múltiplo:**
```json
{
  "entity": "visits",
  "alias": "v",
  "data": {},
  "joins": [
    {
      "table": "checks",
      "alias": "ch",
      "on": "v.check_id = ch.id",
      "type": "inner"
    },
    {
      "table": "clients",
      "alias": "c",
      "on": "ch.client_id = c.id",
      "type": "inner"
    },
    {
      "table": "users",
      "alias": "u",
      "on": "v.user_id = u.id",
      "type": "inner"
    },
    {
      "table": "visit_images",
      "alias": "vi",
      "on": "v.id = vi.visit_id",
      "type": "left"
    }
  ],
  "select": [
    "v.*", 
    "c.name as client_name", 
    "u.name as user_name",
    "ch.check_in_time",
    "GROUP_CONCAT(vi.image_url) as images"
  ],
  "filter": [
    {
      "field": "v.created_at",
      "operator": "between",
      "value": ["2023-06-01T00:00:00", "2023-06-30T23:59:59"]
    }
  ],
  "groupBy": ["v.id"],
  "orderBy": [
    {
      "field": "v.created_at",
      "direction": "desc"
    }
  ]
}
```

### Metas (Goal)

**Exemplo de consulta:**
```json
{
  "entity": "goals",
  "alias": "g",
  "data": {},
  "joins": [
    {
      "table": "users",
      "alias": "u",
      "on": "g.user_id = u.id",
      "type": "inner"
    }
  ],
  "select": ["g.*", "u.name as user_name"],
  "filter": [
    {
      "field": "g.month",
      "operator": "=",
      "value": 6
    },
    {
      "field": "g.year",
      "operator": "=",
      "value": 2023
    }
  ],
  "orderBy": [
    {
      "field": "g.target_value",
      "direction": "desc"
    }
  ]
}
```

---

Esta documentação fornece uma visão geral de como utilizar a API OnTarget Server Deluxe. Para casos específicos ou dúvidas adicionais, consulte a equipe de desenvolvimento.
