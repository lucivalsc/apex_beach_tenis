// ============================================================
// SCREENS - SUBSCRIPTION (Telas 2.1, 2.1.1, 2.1.2, 2.1.3)
// Fluxo completo de assinatura para novos usuários
// ============================================================

// TELA 2.1 - Escolha de Assinatura
function SubscriptionPlanScreen() {
  const [selectedPlan, setSelectedPlan] = React.useState(null);

  const plans = [
    {
      id: 'atleta',
      title: 'ATLETA',
      description: 'Acompanhe suas estatísticas nos jogos. Crie relacionamentos com outros atletas. Observe o desempenho das duplas que você participa. Conheça os seus pontos fortes e pontos fracos.'
    },
    {
      id: 'arena',
      title: 'ARENA',
      description: 'Cadastrando sua Arena você poderá incluir os professores que fazem parte dela, bem como seus alunos, dando a oportunidade de analisar o desenvolvimento técnico dos alunos.'
    },
    {
      id: 'profissional',
      title: 'PROFISSIONAL TÉCNICO',
      description: 'Acompanhe suas estatísticas nos jogos. Crie relacionamentos com outros atletas. Observe o desempenho das duplas que você participa. Conheça os seus pontos fortes e pontos fracos.'
    }
  ];

  const handleSelectPlan = (planId) => {
    setSelectedPlan(planId);

    // Salva o plano escolhido
    localStorage.setItem('selectedPlan', planId);

    // Navega para a tela de cadastro correspondente
    if (planId === 'atleta') {
      window.navigateTo('subscription-register-athlete');
    } else if (planId === 'arena') {
      window.navigateTo('subscription-register-arena');
    } else if (planId === 'profissional') {
      window.navigateTo('subscription-register-athlete'); // Usa o mesmo cadastro do atleta
    }
  };

  return (
    <div className="screen">
      <div className="header-bar blue">
        <div className="status-bar">
          <span className="time">08:00</span>
          <div className="dynamic-island"></div>
          <div className="status-icons">
            <svg width="16" height="12" viewBox="0 0 16 12" fill="none"><path d="M1 5.5C3.5 3 5.5 1.5 8 1.5C10.5 1.5 12.5 3 15 5.5" stroke="white" strokeWidth="1.5"/><path d="M4 8C5.5 6.5 6.5 6 8 6C9.5 6 10.5 6.5 12 8" stroke="white" strokeWidth="1.5"/></svg>
            <svg width="20" height="12" viewBox="0 0 20 12"><rect x="1" y="1" width="14" height="10" rx="2" stroke="white" strokeWidth="1.5" fill="white"/><path d="M16 4v4" stroke="white" strokeWidth="1.5"/></svg>
          </div>
        </div>

        <div className="nav-bar">
          <button className="btn-icon" onClick={() => window.navigateBack()}>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
              <path d="M15 18l-6-6 6-6" stroke="white" strokeWidth="2" strokeLinecap="round"/>
            </svg>
          </button>
          <button className="btn-icon">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
              <circle cx="12" cy="6" r="1.5" fill="white"/>
              <circle cx="12" cy="12" r="1.5" fill="white"/>
              <circle cx="12" cy="18" r="1.5" fill="white"/>
            </svg>
          </button>
        </div>

        <div className="profile-header">
          <div className="avatar-large">
            <svg width="60" height="60" viewBox="0 0 60 60" fill="none">
              <circle cx="30" cy="22" r="10" fill="#ccc"/>
              <path d="M10 50c0-11 9-20 20-20s20 9 20 20" fill="#ccc"/>
            </svg>
            <button className="btn-avatar-edit">
              <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                <path d="M8 4v8M4 8h8" stroke="white" strokeWidth="2" strokeLinecap="round"/>
              </svg>
            </button>
          </div>
          <span className="profile-name">Fulano de tal</span>
        </div>
      </div>

      <div className="content-scroll">
        <div className="section-title">ESCOLHA SUA ASSINATURA</div>

        <div className="subscription-plans">
          {plans.map(plan => (
            <div key={plan.id} className="plan-card">
              <button
                className={`btn-plan ${selectedPlan === plan.id ? 'selected' : ''}`}
                onClick={() => handleSelectPlan(plan.id)}
              >
                {plan.title}
              </button>

              <div className="plan-details">
                <div className="plan-label">FUNCIONALIDADES</div>
                <p className="plan-description">{plan.description}</p>
              </div>
            </div>
          ))}
        </div>
      </div>

      <div className="footer-logo">
        <Logo40x40 />
      </div>
    </div>
  );
}

// TELA 2.1.2 - Cadastro de Assinatura como Atleta
function SubscriptionRegisterAthleteScreen() {
  const [formData, setFormData] = React.useState({
    name: '',
    birthDate: '',
    sex: '',
    city: '',
    email: '',
    phone: '',
    whatsapp: false,
    cpf: '',
    instagram: '',
    facebook: ''
  });

  const handleChange = (field, value) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  const handleSubmit = () => {
    // Salva os dados do atleta
    localStorage.setItem('athleteData', JSON.stringify(formData));

    // Navega para a tela de pagamento
    window.navigateTo('subscription-payment');
  };

  return (
    <div className="screen">
      <div className="header-bar blue">
        <div className="status-bar">
          <span className="time">08:00</span>
          <div className="dynamic-island"></div>
          <div className="status-icons">
            <svg width="16" height="12" viewBox="0 0 16 12" fill="none"><path d="M1 5.5C3.5 3 5.5 1.5 8 1.5C10.5 1.5 12.5 3 15 5.5" stroke="white" strokeWidth="1.5"/><path d="M4 8C5.5 6.5 6.5 6 8 6C9.5 6 10.5 6.5 12 8" stroke="white" strokeWidth="1.5"/></svg>
            <svg width="20" height="12" viewBox="0 0 20 12"><rect x="1" y="1" width="14" height="10" rx="2" stroke="white" strokeWidth="1.5" fill="white"/><path d="M16 4v4" stroke="white" strokeWidth="1.5"/></svg>
          </div>
        </div>

        <div className="nav-bar">
          <button className="btn-icon" onClick={() => window.navigateBack()}>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
              <path d="M15 18l-6-6 6-6" stroke="white" strokeWidth="2" strokeLinecap="round"/>
            </svg>
          </button>
          <button className="btn-icon">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
              <circle cx="12" cy="6" r="1.5" fill="white"/>
              <circle cx="12" cy="12" r="1.5" fill="white"/>
              <circle cx="12" cy="18" r="1.5" fill="white"/>
            </svg>
          </button>
        </div>

        <div className="profile-header">
          <div className="avatar-large">
            <svg width="60" height="60" viewBox="0 0 60 60" fill="none">
              <circle cx="30" cy="22" r="10" fill="#ccc"/>
              <path d="M10 50c0-11 9-20 20-20s20 9 20 20" fill="#ccc"/>
            </svg>
            <button className="btn-avatar-edit">
              <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                <rect x="4" y="6" width="8" height="6" rx="1" stroke="white" strokeWidth="1.5"/>
                <circle cx="8" cy="9" r="1.5" fill="white"/>
                <path d="M6 6V5c0-1.1.9-2 2-2s2 .9 2 2v1" stroke="white" strokeWidth="1.5"/>
              </svg>
            </button>
          </div>
          <span className="profile-name">Fulano de tal</span>
        </div>
      </div>

      <div className="content-scroll">
        <div className="section-title">MEUS DADOS</div>

        <div className="form-subscription">
          <div className="form-row">
            <div className="avatar-upload">
              <svg width="40" height="40" viewBox="0 0 40 40" fill="none">
                <rect width="40" height="40" rx="8" fill="#50B6E8"/>
                <path d="M20 14v12M14 20h12" stroke="white" strokeWidth="2" strokeLinecap="round"/>
              </svg>
              <div className="camera-badge">
                <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
                  <rect x="1" y="3" width="10" height="7" rx="1" stroke="white" strokeWidth="1"/>
                  <circle cx="6" cy="6.5" r="1.5" fill="white"/>
                  <path d="M4 3l1-1.5h2L8 3" stroke="white" strokeWidth="1"/>
                </svg>
              </div>
            </div>

            <div className="form-group flex-1">
              <label className="form-label">Nome</label>
              <input
                type="text"
                className="form-input"
                value={formData.name}
                onChange={(e) => handleChange('name', e.target.value)}
              />
            </div>
          </div>

          <div className="form-row">
            <div className="form-group flex-1">
              <label className="form-label">Data de Nascimento</label>
              <input
                type="date"
                className="form-input"
                value={formData.birthDate}
                onChange={(e) => handleChange('birthDate', e.target.value)}
              />
            </div>
            <div className="form-group flex-1">
              <label className="form-label">Sexo</label>
              <input
                type="text"
                className="form-input"
                value={formData.sex}
                onChange={(e) => handleChange('sex', e.target.value)}
              />
            </div>
          </div>

          <div className="form-row">
            <div className="form-group flex-1">
              <label className="form-label">Cidade</label>
              <input
                type="text"
                className="form-input"
                value={formData.city}
                onChange={(e) => handleChange('city', e.target.value)}
              />
            </div>
            <div className="form-group flex-1">
              <label className="form-label">E-mail</label>
              <input
                type="email"
                className="form-input"
                value={formData.email}
                onChange={(e) => handleChange('email', e.target.value)}
              />
            </div>
          </div>

          <div className="form-group">
            <label className="form-label">Telefone</label>
            <div className="input-with-checkbox">
              <input
                type="tel"
                className="form-input"
                value={formData.phone}
                onChange={(e) => handleChange('phone', e.target.value)}
              />
              <label className="checkbox-label">
                <input
                  type="checkbox"
                  checked={formData.whatsapp}
                  onChange={(e) => handleChange('whatsapp', e.target.checked)}
                />
                <span>É WhatsApp?</span>
              </label>
            </div>
          </div>

          <div className="form-group">
            <label className="form-label">CPF</label>
            <input
              type="text"
              className="form-input"
              value={formData.cpf}
              onChange={(e) => handleChange('cpf', e.target.value)}
            />
          </div>

          <div className="form-divider"></div>

          <div className="form-row">
            <div className="form-group flex-1">
              <label className="form-label">Instagram</label>
              <input
                type="text"
                className="form-input"
                value={formData.instagram}
                onChange={(e) => handleChange('instagram', e.target.value)}
              />
            </div>
            <div className="form-group flex-1">
              <label className="form-label">Facebook</label>
              <input
                type="text"
                className="form-input"
                value={formData.facebook}
                onChange={(e) => handleChange('facebook', e.target.value)}
              />
            </div>
          </div>

          <button className="btn-primary large" onClick={handleSubmit}>
            CADASTRAR
          </button>
        </div>
      </div>

      <div className="footer-logo">
        <Logo40x40 />
      </div>
    </div>
  );
}

// TELA 2.1.1 - Cadastro de Assinatura como Arena
function SubscriptionRegisterArenaScreen() {
  const [formData, setFormData] = React.useState({
    name: '',
    address: '',
    cnpj: '',
    phone: '',
    whatsapp: false,
    email: '',
    instagram: '',
    facebook: ''
  });

  const handleChange = (field, value) => {
    setFormData(prev => ({ ...prev, [field]: value }));
  };

  const handleSubmit = () => {
    // Salva os dados da arena
    localStorage.setItem('arenaData', JSON.stringify(formData));

    // Navega para a tela de pagamento
    window.navigateTo('subscription-payment');
  };

  return (
    <div className="screen">
      <div className="header-bar blue">
        <div className="status-bar">
          <span className="time">08:00</span>
          <div className="dynamic-island"></div>
          <div className="status-icons">
            <svg width="16" height="12" viewBox="0 0 16 12" fill="none"><path d="M1 5.5C3.5 3 5.5 1.5 8 1.5C10.5 1.5 12.5 3 15 5.5" stroke="white" strokeWidth="1.5"/><path d="M4 8C5.5 6.5 6.5 6 8 6C9.5 6 10.5 6.5 12 8" stroke="white" strokeWidth="1.5"/></svg>
            <svg width="20" height="12" viewBox="0 0 20 12"><rect x="1" y="1" width="14" height="10" rx="2" stroke="white" strokeWidth="1.5" fill="white"/><path d="M16 4v4" stroke="white" strokeWidth="1.5"/></svg>
          </div>
        </div>

        <div className="nav-bar">
          <button className="btn-icon" onClick={() => window.navigateBack()}>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
              <path d="M15 18l-6-6 6-6" stroke="white" strokeWidth="2" strokeLinecap="round"/>
            </svg>
          </button>
          <button className="btn-icon">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
              <circle cx="12" cy="6" r="1.5" fill="white"/>
              <circle cx="12" cy="12" r="1.5" fill="white"/>
              <circle cx="12" cy="18" r="1.5" fill="white"/>
            </svg>
          </button>
        </div>

        <div className="profile-header">
          <div className="avatar-large">
            <svg width="60" height="60" viewBox="0 0 60 60" fill="none">
              <circle cx="30" cy="22" r="10" fill="#ccc"/>
              <path d="M10 50c0-11 9-20 20-20s20 9 20 20" fill="#ccc"/>
            </svg>
            <button className="btn-avatar-edit">
              <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                <rect x="4" y="6" width="8" height="6" rx="1" stroke="white" strokeWidth="1.5"/>
                <circle cx="8" cy="9" r="1.5" fill="white"/>
                <path d="M6 6V5c0-1.1.9-2 2-2s2 .9 2 2v1" stroke="white" strokeWidth="1.5"/>
              </svg>
            </button>
          </div>
          <span className="profile-name">Fulano de tal</span>
        </div>
      </div>

      <div className="content-scroll">
        <div className="section-title">MINHA ARENA</div>

        <div className="form-subscription">
          <div className="form-row">
            <div className="avatar-upload">
              <svg width="40" height="40" viewBox="0 0 40 40" fill="none">
                <rect width="40" height="40" rx="8" fill="#50B6E8"/>
                <path d="M20 14v12M14 20h12" stroke="white" strokeWidth="2" strokeLinecap="round"/>
              </svg>
              <div className="camera-badge">
                <svg width="12" height="12" viewBox="0 0 12 12" fill="none">
                  <rect x="1" y="3" width="10" height="7" rx="1" stroke="white" strokeWidth="1"/>
                  <circle cx="6" cy="6.5" r="1.5" fill="white"/>
                  <path d="M4 3l1-1.5h2L8 3" stroke="white" strokeWidth="1"/>
                </svg>
              </div>
            </div>

            <div className="form-group flex-1">
              <label className="form-label">Nome</label>
              <input
                type="text"
                className="form-input"
                value={formData.name}
                onChange={(e) => handleChange('name', e.target.value)}
              />
            </div>
          </div>

          <div className="form-group">
            <label className="form-label">Endereço</label>
            <input
              type="text"
              className="form-input"
              value={formData.address}
              onChange={(e) => handleChange('address', e.target.value)}
            />
          </div>

          <div className="form-group">
            <label className="form-label">CNPJ</label>
            <input
              type="text"
              className="form-input"
              value={formData.cnpj}
              onChange={(e) => handleChange('cnpj', e.target.value)}
            />
          </div>

          <div className="form-group">
            <label className="form-label">Telefone</label>
            <div className="input-with-checkbox">
              <input
                type="tel"
                className="form-input"
                value={formData.phone}
                onChange={(e) => handleChange('phone', e.target.value)}
              />
              <label className="checkbox-label">
                <input
                  type="checkbox"
                  checked={formData.whatsapp}
                  onChange={(e) => handleChange('whatsapp', e.target.checked)}
                />
                <span>É WhatsApp?</span>
              </label>
            </div>
          </div>

          <div className="form-group">
            <label className="form-label">E-mail</label>
            <input
              type="email"
              className="form-input"
              value={formData.email}
              onChange={(e) => handleChange('email', e.target.value)}
            />
          </div>

          <div className="form-divider"></div>

          <div className="form-row">
            <div className="form-group flex-1">
              <label className="form-label">Instagram</label>
              <input
                type="text"
                className="form-input"
                value={formData.instagram}
                onChange={(e) => handleChange('instagram', e.target.value)}
              />
            </div>
            <div className="form-group flex-1">
              <label className="form-label">Facebook</label>
              <input
                type="text"
                className="form-input"
                value={formData.facebook}
                onChange={(e) => handleChange('facebook', e.target.value)}
              />
            </div>
          </div>

          <button className="btn-primary large" onClick={handleSubmit}>
            CADASTRAR
          </button>
        </div>
      </div>

      <div className="footer-logo">
        <Logo40x40 />
      </div>
    </div>
  );
}

// TELA 2.1.3 - Forma de Pagamento
function SubscriptionPaymentScreen() {
  const [paymentMethod, setPaymentMethod] = React.useState('card'); // 'card' ou 'pix'
  const [cardData, setCardData] = React.useState({
    number: '',
    name: '',
    cvv: '',
    expiry: '',
    installments: '1'
  });

  const handleCardChange = (field, value) => {
    setCardData(prev => ({ ...prev, [field]: value }));
  };

  const handlePayment = () => {
    // Processa o pagamento
    const paymentInfo = {
      method: paymentMethod,
      ...(paymentMethod === 'card' ? cardData : {})
    };

    localStorage.setItem('paymentCompleted', 'true');
    localStorage.setItem('paymentInfo', JSON.stringify(paymentInfo));

    // Marca como assinante
    localStorage.setItem('isSubscriber', 'true');

    // Navega para seleção de perfil
    window.navigateTo('profile-selection');
  };

  const handleCancel = () => {
    window.navigateBack();
  };

  return (
    <div className="screen">
      <div className="header-bar blue">
        <div className="status-bar">
          <span className="time">08:00</span>
          <div className="dynamic-island"></div>
          <div className="status-icons">
            <svg width="16" height="12" viewBox="0 0 16 12" fill="none"><path d="M1 5.5C3.5 3 5.5 1.5 8 1.5C10.5 1.5 12.5 3 15 5.5" stroke="white" strokeWidth="1.5"/><path d="M4 8C5.5 6.5 6.5 6 8 6C9.5 6 10.5 6.5 12 8" stroke="white" strokeWidth="1.5"/></svg>
            <svg width="20" height="12" viewBox="0 0 20 12"><rect x="1" y="1" width="14" height="10" rx="2" stroke="white" strokeWidth="1.5" fill="white"/><path d="M16 4v4" stroke="white" strokeWidth="1.5"/></svg>
          </div>
        </div>

        <div className="nav-bar">
          <button className="btn-icon" onClick={() => window.navigateBack()}>
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
              <path d="M15 18l-6-6 6-6" stroke="white" strokeWidth="2" strokeLinecap="round"/>
            </svg>
          </button>
          <button className="btn-icon">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none">
              <circle cx="12" cy="6" r="1.5" fill="white"/>
              <circle cx="12" cy="12" r="1.5" fill="white"/>
              <circle cx="12" cy="18" r="1.5" fill="white"/>
            </svg>
          </button>
        </div>

        <div className="profile-header">
          <div className="avatar-large">
            <svg width="60" height="60" viewBox="0 0 60 60" fill="none">
              <circle cx="30" cy="22" r="10" fill="#ccc"/>
              <path d="M10 50c0-11 9-20 20-20s20 9 20 20" fill="#ccc"/>
            </svg>
            <button className="btn-avatar-edit">
              <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                <path d="M8 4v8M4 8h8" stroke="white" strokeWidth="2" strokeLinecap="round"/>
              </svg>
            </button>
          </div>
          <span className="profile-name">Fulano de tal</span>
        </div>
      </div>

      <div className="content-scroll">
        <div className="section-title">FORMA DE PAGAMENTO</div>

        <div className="payment-tabs">
          <button
            className={`payment-tab ${paymentMethod === 'card' ? 'active' : ''}`}
            onClick={() => setPaymentMethod('card')}
          >
            <svg width="20" height="16" viewBox="0 0 20 16" fill="none">
              <rect x="1" y="1" width="18" height="14" rx="2" stroke="currentColor" strokeWidth="1.5"/>
              <rect x="1" y="4" width="18" height="3" fill="currentColor"/>
            </svg>
            CARTÃO DE CRÉDITO
          </button>
          <button
            className={`payment-tab ${paymentMethod === 'pix' ? 'active' : ''}`}
            onClick={() => setPaymentMethod('pix')}
          >
            <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
              <path d="M10 2l6 6-6 6-6-6 6-6z" stroke="currentColor" strokeWidth="1.5"/>
              <path d="M4 10l6 6M16 10l-6 6" stroke="currentColor" strokeWidth="1.5"/>
            </svg>
            PIX
          </button>
        </div>

        {paymentMethod === 'card' ? (
          <div className="payment-form">
            <div className="form-group">
              <input
                type="text"
                className="form-input"
                placeholder="Número do cartão (apenas números)"
                value={cardData.number}
                onChange={(e) => handleCardChange('number', e.target.value)}
              />
            </div>

            <div className="form-group">
              <input
                type="text"
                className="form-input"
                placeholder="Digite o nome do titular"
                value={cardData.name}
                onChange={(e) => handleCardChange('name', e.target.value)}
              />
            </div>

            <div className="form-row">
              <div className="form-group flex-1">
                <input
                  type="text"
                  className="form-input"
                  placeholder="Código de segurança"
                  value={cardData.cvv}
                  onChange={(e) => handleCardChange('cvv', e.target.value)}
                />
              </div>
              <button className="btn-icon help-icon">
                <svg width="20" height="20" viewBox="0 0 20 20" fill="none">
                  <circle cx="10" cy="10" r="8" stroke="#50B6E8" strokeWidth="1.5"/>
                  <path d="M10 14v-1M10 7v4" stroke="#50B6E8" strokeWidth="1.5" strokeLinecap="round"/>
                </svg>
              </button>
            </div>

            <div className="form-group">
              <div className="input-with-icon">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                  <rect x="2" y="4" width="12" height="10" rx="1" stroke="#50B6E8" strokeWidth="1.5"/>
                  <path d="M2 7h12M5 4V2M11 4V2" stroke="#50B6E8" strokeWidth="1.5"/>
                </svg>
                <input
                  type="text"
                  className="form-input"
                  placeholder="Data de vencimento"
                  value={cardData.expiry}
                  onChange={(e) => handleCardChange('expiry', e.target.value)}
                />
              </div>
            </div>

            <div className="form-group">
              <div className="input-with-icon">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                  <path d="M2 6l6-4 6 4v6a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" stroke="#50B6E8" strokeWidth="1.5"/>
                </svg>
                <select
                  className="form-input"
                  value={cardData.installments}
                  onChange={(e) => handleCardChange('installments', e.target.value)}
                >
                  <option value="1">1x - Sem juros</option>
                  <option value="2">2x - Sem juros</option>
                  <option value="3">3x - Sem juros</option>
                  <option value="6">6x - Com juros</option>
                  <option value="12">12x - Com juros</option>
                </select>
              </div>
            </div>

            <div className="payment-actions">
              <button className="btn-primary" onClick={handlePayment}>Pagar</button>
              <button className="btn-secondary" onClick={handleCancel}>Cancelar</button>
            </div>
          </div>
        ) : (
          <div className="payment-form pix-form">
            <div className="pix-container">
              <div className="input-with-icon">
                <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                  <path d="M2 6l6-4 6 4v6a2 2 0 01-2 2H4a2 2 0 01-2-2V6z" stroke="#50B6E8" strokeWidth="1.5"/>
                </svg>
                <span className="pix-installment">Pacote</span>
              </div>

              <div className="qrcode">
                <svg width="180" height="180" viewBox="0 0 180 180">
                  <rect x="10" y="10" width="160" height="160" fill="#333"/>
                  <rect x="20" y="20" width="30" height="30" fill="white"/>
                  <rect x="130" y="20" width="30" height="30" fill="white"/>
                  <rect x="20" y="130" width="30" height="30" fill="white"/>

                  <rect x="60" y="25" width="10" height="10" fill="white"/>
                  <rect x="75" y="25" width="10" height="10" fill="white"/>
                  <rect x="90" y="25" width="10" height="10" fill="white"/>

                  <rect x="60" y="45" width="10" height="10" fill="white"/>
                  <rect x="90" y="45" width="10" height="10" fill="white"/>

                  <rect x="25" y="60" width="10" height="10" fill="white"/>
                  <rect x="45" y="60" width="10" height="10" fill="white"/>
                  <rect x="75" y="60" width="10" height="10" fill="white"/>
                  <rect x="105" y="60" width="10" height="10" fill="white"/>
                  <rect x="135" y="60" width="10" height="10" fill="white"/>

                  <rect x="60" y="75" width="10" height="10" fill="white"/>
                  <rect x="90" y="75" width="10" height="10" fill="white"/>

                  <rect x="25" y="90" width="10" height="10" fill="white"/>
                  <rect x="45" y="90" width="10" height="10" fill="white"/>
                  <rect x="75" y="90" width="10" height="10" fill="white"/>
                  <rect x="105" y="90" width="10" height="10" fill="white"/>
                  <rect x="135" y="90" width="10" height="10" fill="white"/>

                  <rect x="60" y="105" width="10" height="10" fill="white"/>
                  <rect x="90" y="105" width="10" height="10" fill="white"/>

                  <rect x="60" y="135" width="10" height="10" fill="white"/>
                  <rect x="75" y="135" width="10" height="10" fill="white"/>
                  <rect x="90" y="135" width="10" height="10" fill="white"/>
                  <rect x="130" y="135" width="10" height="10" fill="white"/>
                </svg>
              </div>

              <div className="pix-code">
                <input
                  type="text"
                  className="form-input"
                  value="blablablablablablablablablabla"
                  readOnly
                />
                <button className="btn-copy">
                  <svg width="16" height="16" viewBox="0 0 16 16" fill="none">
                    <rect x="5" y="5" width="9" height="9" rx="1" stroke="#50B6E8" strokeWidth="1.5"/>
                    <path d="M3 11V3a2 2 0 012-2h8" stroke="#50B6E8" strokeWidth="1.5"/>
                  </svg>
                  Copiar
                </button>
              </div>
            </div>

            <div className="payment-actions">
              <button className="btn-primary" onClick={handlePayment}>Pagar</button>
              <button className="btn-secondary" onClick={handleCancel}>Cancelar</button>
            </div>
          </div>
        )}
      </div>

      <div className="footer-logo">
        <Logo40x40 />
      </div>
    </div>
  );
}

// Exporta as telas
Object.assign(window, {
  SubscriptionPlanScreen,
  SubscriptionRegisterAthleteScreen,
  SubscriptionRegisterArenaScreen,
  SubscriptionPaymentScreen
});
