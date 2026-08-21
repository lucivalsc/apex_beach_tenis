# 🔍 ANÁLISE COMPLETA - FLUXOS DE NAVEGAÇÃO
## Beach Tennis 40×40 App

---

## 🚨 **PROBLEMAS CRÍTICOS IDENTIFICADOS**

### ❌ **1. FLUXO DE REGISTRO ESTÁ INCORRETO**

**IMPLEMENTAÇÃO ATUAL (ERRADA):**
```
Login → Seleção de Perfil → Home do Perfil
```

**FLUXO CORRETO DA DOCUMENTAÇÃO:**
```
Login/Registro (Abas) →
  ├─ Se JÁ ASSINANTE → Tela 2: Seleção de Perfil → Home
  └─ Se NÃO ASSINANTE →
      Tela 2.1: Escolha Assinatura (3 planos) →
      Tela 2.1.2/2.1.1: Cadastro (Atleta ou Arena) →
      Tela 2.1.3: Pagamento (Cartão ou PIX) →
      Home do perfil escolhido
```

### 📸 **EVIDÊNCIAS DA DOCUMENTAÇÃO:**

1. **TELA 1** - Login/Registro (`mpyq906o-pagina_3_img_1.png` + `mpyq906z-pagina_3_img_2.png`)
   - Duas ABAS na mesma tela: "Entrar" e "Registrar"

2. **TELA 2** - Seleção de Perfil (`mpyq9077-pagina_4_img_1.png`)
   - Título: "Qual perfil você quer administrar?"
   - 5 perfis: Atleta, Aluno, Professor, Arena, Profissional Técnico
   - **NOTA:** "Se já é assinante e tem mais de um perfil"

3. **TELA 2.1** - Escolha de Assinatura (`mpyq907d-pagina_4_img_2.jpeg`)
   - Título: "ESCOLHA SUA ASSINATURA"
   - **NOTA:** "Se não é assinante"
   - 3 planos: ATLETA, ARENA, PROFISSIONAL TÉCNICO

4. **TELA 2.1.2** - Cadastro Atleta (`mpyq907o-pagina_5_img_1.jpeg`)
   - Formulário completo: Nome, Data Nasc, Sexo, Cidade, Email, Tel, CPF, Instagram, Facebook

5. **TELA 2.1.1** - Cadastro Arena (`mpyq907t-pagina_5_img_2.jpeg`)
   - Formulário: Nome, Endereço, CNPJ, Telefone, Email, Instagram, Facebook

6. **TELA 2.1.3** - Pagamento (`mpyq907y-pagina_6_img_1.jpeg` + `mpyq9085-pagina_6_img_2.jpeg`)
   - Duas ABAS: "CARTÃO DE CRÉDITO" e "PIX"
   - Cartão: formulário completo
   - PIX: QR Code + código para copiar

---

## ✅ **CORREÇÕES NECESSÁRIAS**

### **Arquivos a Criar/Modificar:**

#### 1. **Criar: `screens-subscription.jsx`**
Novo arquivo com 4 componentes:

```jsx
// Tela 2.1 - Escolha de Assinatura
function SubscriptionPlansScreen({ navigate }) {
  // 3 cards: ATLETA, ARENA, PROFISSIONAL TÉCNICO
}

// Tela 2.1.2 - Cadastro Atleta
function AthleteSignupScreen({ navigate }) {
  // Formulário completo do atleta
}

// Tela 2.1.1 - Cadastro Arena
function ArenaSignupScreen({ navigate }) {
  // Formulário completo da arena
}

// Tela 2.1.3 - Pagamento
function PaymentScreen({ navigate, plan }) {
  // Abas: Cartão de Crédito | PIX
}
```

#### 2. **Modificar: `screens-auth.jsx`**

**ESTADO ATUAL:**
```jsx
// Após registro, vai direto para seleção de perfil
if (activeTab === 'register') {
  navigate('profile-select');
}
```

**DEVERIA SER:**
```jsx
// Após registro, verificar se já é assinante
if (activeTab === 'register') {
  // Simular verificação de assinatura
  const isSubscriber = false; // Verificar no backend
  
  if (isSubscriber) {
    navigate('profile-select'); // TELA 2
  } else {
    navigate('subscription-plans'); // TELA 2.1
  }
}
```

#### 3. **Modificar: `Beach Tennis App.html`**

Adicionar rota para subscription:

```jsx
// Adicionar no switch de screens
case 'subscription-plans':
  return <SubscriptionPlansScreen navigate={navigate} />;
case 'athlete-signup':
  return <AthleteSignupScreen navigate={navigate} />;
case 'arena-signup':
  return <ArenaSignupScreen navigate={navigate} />;
case 'payment':
  return <PaymentScreen navigate={navigate} plan={currentPlan} />;
```

---

## 🎯 **FLUXO CORRETO COMPLETO**

### **Cenário A: Novo Usuário (NÃO assinante)**
```
1. TELA 1 (Login/Registro)
   └─ Clicar "Registrar"
   └─ Preencher: Usuário/Email, Senha, Confirmar Senha
   └─ Botão "Registrar"
   
2. TELA 2.1 (Escolha Assinatura)
   └─ Escolher um dos 3 planos:
       ├─ ATLETA → vai para Tela 2.1.2
       ├─ ARENA → vai para Tela 2.1.1
       └─ PROFISSIONAL TÉCNICO → vai para Tela 2.1.2 (mesmo form que atleta)

3. TELA 2.1.2 ou 2.1.1 (Cadastro)
   └─ Preencher todos os dados
   └─ Botão "CADASTRAR"

4. TELA 2.1.3 (Pagamento)
   └─ Escolher método:
       ├─ CARTÃO: preencher dados → Botão "Pagar"
       └─ PIX: ver QR Code → Botão "Copiar" → Botão "Pagar"
   
5. HOME do perfil escolhido
   └─ Se escolheu ATLETA → Atleta Home (TELA 7)
   └─ Se escolheu ARENA → Arena Home (TELA 3)
   └─ Se escolheu PROFISSIONAL → Profissional Home (TELA 6)
```

### **Cenário B: Usuário Existente (JÁ assinante)**
```
1. TELA 1 (Login)
   └─ Clicar "Entrar"
   └─ Preencher: Usuário/Email, Senha
   └─ Checkbox "Manter conectado" (opcional)
   └─ Botão "Entrar"

2. TELA 2 (Seleção de Perfil)
   └─ Mostra APENAS os perfis que o usuário tem acesso
   └─ Clicar no perfil desejado

3. HOME do perfil selecionado
```

---

## 📋 **CHECKLIST DE IMPLEMENTAÇÃO**

- [ ] **1. Criar `screens-subscription.jsx`**
  - [ ] SubscriptionPlansScreen (TELA 2.1)
  - [ ] AthleteSignupScreen (TELA 2.1.2)
  - [ ] ArenaSignupScreen (TELA 2.1.1)
  - [ ] PaymentScreen com abas Cartão/PIX (TELA 2.1.3)

- [ ] **2. Modificar `screens-auth.jsx`**
  - [ ] Adicionar lógica de verificação de assinatura
  - [ ] Navegar para `subscription-plans` se não assinante
  - [ ] Navegar para `profile-select` se já assinante

- [ ] **3. Modificar `screens-profile.jsx`**
  - [ ] Na seleção de perfil, mostrar apenas perfis que o usuário tem

- [ ] **4. Atualizar `Beach Tennis App.html`**
  - [ ] Importar `screens-subscription.jsx`
  - [ ] Adicionar rotas: subscription-plans, athlete-signup, arena-signup, payment
  - [ ] Gerenciar estado global (usuário, plano selecionado, dados de cadastro)

- [ ] **5. Testar Fluxos Completos**
  - [ ] Novo usuário → Registro → Planos → Cadastro → Pagamento → Home
  - [ ] Usuário existente → Login → Seleção → Home
  - [ ] Voltar (botão back) em cada etapa

---

## 🔧 **OUTRAS NAVEGAÇÕES QUE PRECISAM REVISÃO**

### **Navegação entre perfis múltiplos:**
- Usuário pode ser ATLETA + PROFESSOR ao mesmo tempo
- Precisa de um menu/drawer para alternar entre perfis
- Atualmente não há essa funcionalidade

### **Navegação em modais:**
- Tela 3.1.1 (Modal Cadastro Professor) sobrepõe Tela 3.1
- Tela 3.2.1 (Modal Cadastro Aluno) sobrepõe Tela 3.2
- Implementar modais overlay ao invés de navegação completa

### **Fluxo de Registro de Jogo:**
- Tela 8 (Modo) → escolher Simples ou Duplas
- Se Simples → Tela 8.1
- Se Duplas → Tela 8.2
- Atualmente pode estar simplificado

---

**Data:** 2026-06-03  
**Status:** 🚨 CRÍTICO - Fluxo de registro está incorreto  
**Prioridade:** P0 - Bloqueia onboarding de novos usuários  
**Versão:** 1.0
