# Analisando a estrutura, a ordem correta para cadastros seria

1. `TipoAssinatura` (necessário para `PacotePagamento`)
2. `PacotePagamento` (pode ser vinculado a usuários posteriormente)
3. `Usuario` (base para todos os perfis)
4. Perfis específicos (`Arena`, `Professor`, `Atleta`, `Aluno`, `ProfissionalTecnico`)

Aqui estão os modelos JSON para cada cadastro:

### 1. TipoAssinatura

```json
{
  "nome": "Plano Básico",
  "descricao": "Acesso básico ao sistema",
  "duracao_dias": 30,
  "preco": 99.90,
  "recorrente": true,
  "ativo": true
}
```

### 2. PacotePagamento

```json
{
  "id_tipo_assinatura": 1, // ID do TipoAssinatura criado anteriormente
  "nome": "Plano Trimestral",
  "descricao": "Plano básico com desconto para pagamento trimestral",
  "duracao_dias": 90,
  "preco": 249.70,
  "desconto": 15,
  "ativo": true
}
```

### 3. Usuario (Admin)

```json
{
  "nome": "Administrador do Sistema",
  "email": "admin@beachtenis.com.br",
  "senha": "SenhaSegura123!",
  "tipo": "ADMIN",
  "cpf": "12345678901",
  "telefone": "11999998888",
  "data_nascimento": "1980-01-01",
  "genero": "M",
  "foto_perfil": null,
  "ativo": true
}
```

### 4. Usuario (Arena)

```json
{
  "nome": "Arena Beach Tennis SP",
  "email": "arena@beachtenis.com.br",
  "senha": "SenhaArena123!",
  "tipo": "ARENA",
  "cnpj": "12345678000199",
  "telefone": "1122223333",
  "endereco": "Rua das Quadras, 100",
  "cidade": "São Paulo",
  "estado": "SP",
  "cep": "01234000",
  "ativo": true
}
```

### 5. Usuario (Professor)

```json
{
  "nome": "Carlos Silva",
  "email": "professor@beachtenis.com.br",
  "senha": "SenhaProf123!",
  "tipo": "PROFESSOR",
  "cpf": "98765432100",
  "telefone": "11987654321",
  "data_nascimento": "1985-05-15",
  "genero": "M",
  "cref": "123456-G/SP",
  "especialidades": ["Iniciantes", "Avançados"],
  "ativo": true
}
```

### 6. Usuario (Aluno)

```json
{
  "nome": "Maria Oliveira",
  "email": "aluno@beachtenis.com.br",
  "senha": "SenhaAluno123!",
  "tipo": "ALUNO",
  "cpf": "11122233344",
  "telefone": "11999997777",
  "data_nascimento": "1990-08-20",
  "genero": "F",
  "nivel": "INICIANTE",
  "objetivo": "Lazer",
  "ativo": true
}
```

### 7. Usuario (Atleta)

```json
{
  "nome": "João Santos",
  "email": "atleta@beachtenis.com.br",
  "senha": "SenhaAtleta123!",
  "tipo": "ATLETA",
  "cpf": "22233344455",
  "telefone": "11988887777",
  "data_nascimento": "1995-03-10",
  "genero": "M",
  "altura": 1.85,
  "peso": 80,
  "lado_preferido": "DIREITO",
  "posicao_quadra": "DIREITA",
  "ranking_nacional": 15,
  "ranking_estadual": 5,
  "mao_dominante": "DIREITA",
  "categoria": "ABERTA",
  "ativo": true
}
```

### 8. Usuario (Profissional Técnico)

```json
{
  "nome": "Ana Costa",
  "email": "tecnico@beachtenis.com.br",
  "senha": "SenhaTecnico123!",
  "tipo": "PROFISSIONAL_TECNICO",
  "cpf": "33344455566",
  "telefone": "11977776666",
  "data_nascimento": "1982-11-25",
  "genero": "F",
  "cref": "987654-G/SP",
  "especialidade": "Preparação Física",
  "formacao": "Educação Física - USP",
  "ano_formacao": 2005,
  "ativo": true
}
```

### Ordem de Cadastro Recomendada

1. Cadastrar `TipoAssinatura`
2. Cadastrar `PacotePagamento` (vinculando ao ID do `TipoAssinatura`)
3. Cadastrar `Usuario` (ADMIN)
4. Cadastrar demais usuários (ARENA, PROFESSOR, ALUNO, etc.)

Observações:

- Os campos de senha devem ser criptografados antes de serem salvos no banco de dados
- Os IDs dos relacionamentos devem ser ajustados conforme os registros forem sendo criados
- Alguns campos podem ser opcionais dependendo da configuração do seu modelo
