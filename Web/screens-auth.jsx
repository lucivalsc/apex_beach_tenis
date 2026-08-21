// screens-auth.jsx — Tela 1 (Login) and Tela 1.1 (Register)

const { useState: useAuthState } = React;

function ToggleSwitch({ on, dark = false }) {
  const bg = on ? (dark ? '#222' : C.blue) : '#ccc';
  return (
    <div style={{ width: 46, height: 26, borderRadius: 13, background: bg, position: 'relative', display: 'flex', alignItems: 'center', padding: '0 3px', boxSizing: 'border-box', transition: 'background 0.2s', cursor: 'pointer', flexShrink: 0 }}>
      <div style={{ width: 20, height: 20, borderRadius: '50%', background: 'white', position: 'absolute', left: on ? 'calc(100% - 23px)' : '3px', transition: 'left 0.2s', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        {on && !dark && <span style={{ fontSize: 10 }}>✦</span>}
        {on && dark && <span style={{ fontSize: 10 }}>☽</span>}
      </div>
    </div>
  );
}

function LoginScreen({ navigate }) {
  const [tab, setTab] = useAuthState('login');

  return (
    <div style={{ display: 'flex', flexDirection: 'column', height: '100%', background: C.blue, position: 'relative', overflow: 'hidden' }}>
      {/* Status bar */}
      <div style={{ display: 'flex', justifyContent: 'space-between', alignItems: 'center', padding: '12px 20px 4px', fontSize: 12, fontWeight: 600, color: 'white', flexShrink: 0 }}>
        <span>08.00</span>
        <div style={{ display: 'flex', gap: 5, alignItems: 'center' }}>
          <svg width="16" height="11" viewBox="0 0 16 11" fill="white">
            <path d="M8 2.5C5.5 2.5 3.2 3.5 1.5 5.2L0 3.7C2.1 1.4 5 0 8 0s5.9 1.4 8 3.7L14.5 5.2C12.8 3.5 10.5 2.5 8 2.5z"/>
            <path d="M8 6.5C6.4 6.5 5 7.1 4 8.1L2.5 6.6C3.9 5.3 5.9 4.5 8 4.5s4.1.8 5.5 2.1L12 8.1C11 7.1 9.6 6.5 8 6.5z"/>
            <circle cx="8" cy="10.5" r="1.5"/>
          </svg>
          <svg width="22" height="11" viewBox="0 0 22 11" fill="none">
            <rect x="0.5" y="0.5" width="18" height="10" rx="2" stroke="white" strokeWidth="1.2"/>
            <rect x="2" y="2" width="12" height="7" rx="1" fill="white"/>
            <path d="M19.5 3.5v4c1-.4 1.5-1 1.5-2s-.5-1.6-1.5-2z" fill="white"/>
          </svg>
        </div>
      </div>

      {/* Mascot + logo */}
      <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', paddingTop: 8, flexShrink: 0 }}>
        <img src="mpyq906i-pagina_1_img_1.jpeg" alt="mascot" style={{ height: 160, objectFit: 'contain' }} />
        <ScoreDisplay />
        <p style={{ color: 'white', fontWeight: 800, fontSize: 14, letterSpacing: 1.5, margin: '6px 0 0', textTransform: 'uppercase' }}>Análise de Alto Rendimento</p>
      </div>

      {/* Tab card */}
      <div style={{ flex: 1, display: 'flex', flexDirection: 'column', position: 'relative', marginTop: 10 }}>
        {/* Tabs */}
        <div style={{ display: 'flex', paddingLeft: 16 }}>
          <button onClick={() => setTab('login')} style={{
            background: tab === 'login' ? 'white' : 'rgba(255,255,255,0.25)',
            border: 'none', borderRadius: '12px 12px 0 0',
            padding: '10px 22px', fontSize: 13, fontWeight: 700,
            color: tab === 'login' ? '#555' : 'white',
            cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 6,
          }}>
            <span style={{ fontSize: 14 }}>⬏</span> Entrar
          </button>
          <button onClick={() => setTab('register')} style={{
            background: tab === 'register' ? 'white' : 'rgba(255,255,255,0.25)',
            border: 'none', borderRadius: '12px 12px 0 0',
            padding: '10px 18px', fontSize: 13, fontWeight: 700,
            color: tab === 'register' ? '#555' : 'white',
            cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 6,
            marginLeft: 4, marginTop: tab === 'register' ? 0 : 4,
          }}>
            <span style={{ fontSize: 14 }}>⊕</span> Registrar
          </button>
        </div>

        {/* Card body */}
        <div style={{ flex: 1, background: 'white', borderRadius: '0 12px 0 0', overflowY: 'auto', padding: '16px 20px 12px' }}>
          {tab === 'login' ? (
            <LoginForm navigate={navigate} />
          ) : (
            <RegisterForm navigate={navigate} />
          )}
        </div>
      </div>

      {/* Dark mode toggles (login tab only) */}
      {tab === 'login' && (
        <div style={{ background: 'white', display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 6, padding: '10px 0 0', flexShrink: 0 }}>
          <ToggleSwitch on={true} dark={false} />
          <ToggleSwitch on={true} dark={true} />
          <p style={{ margin: '2px 0 8px', fontSize: 11, color: '#666' }}>Modo escuro</p>
        </div>
      )}
      {tab === 'register' && (
        <div style={{ background: 'white', display: 'flex', flexDirection: 'column', alignItems: 'center', padding: '8px 0 0', flexShrink: 0 }}>
          <ToggleSwitch on={true} dark={false} />
          <p style={{ margin: '4px 0 8px', fontSize: 11, color: '#666' }}>Modo escuro</p>
        </div>
      )}
    </div>
  );
}

function LoginForm({ navigate }) {
  const handleLogin = () => {
    // Simula login bem-sucedido
    localStorage.setItem('isLoggedIn', 'true');

    // Verifica se é assinante
    const isSubscriber = localStorage.getItem('isSubscriber') === 'true';

    if (isSubscriber) {
      // Se já é assinante, vai direto para seleção de perfil
      navigate('profile-select');
    } else {
      // Se não é assinante, vai para escolha de assinatura
      navigate('subscription-plan');
    }
  };

  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 12 }}>
      <div style={{ width: 70, height: 70, borderRadius: '50%', background: '#E8E8E8', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        <PersonIcon size={44} color="#aaa" />
      </div>

      <div style={{ width: '100%', display: 'flex', flexDirection: 'column', gap: 10 }}>
        <Input icon="👤" placeholder="Usuário ou e-mail" />
        <Input icon="🔒" placeholder="Senha" type="password" rightEl={<span style={{ fontSize: 16 }}>👁</span>} />
      </div>

      <div style={{ width: '100%', display: 'flex', justifyContent: 'space-between', alignItems: 'center' }}>
        <label style={{ display: 'flex', alignItems: 'center', gap: 5, fontSize: 12, color: '#666', cursor: 'pointer' }}>
          <input type="checkbox" style={{ margin: 0 }} /> Manter conectado
        </label>
        <span style={{ fontSize: 12, color: '#666', cursor: 'pointer' }}>Esqueci a senha</span>
      </div>

      <Btn onClick={handleLogin} style={{ width: '70%', textAlign: 'center' }}>Entrar</Btn>

      <div style={{ display: 'flex', gap: 10, width: '100%', justifyContent: 'center' }}>
        <button style={{ background: '#3b5998', color: 'white', border: 'none', borderRadius: 6, padding: '8px 12px', fontSize: 11, fontWeight: 600, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 5 }}>
          <span style={{ fontSize: 14, fontWeight: 'bold' }}>f</span> Login com Facebook
        </button>
        <button style={{ background: 'white', color: '#555', border: '1.5px solid #ddd', borderRadius: 6, padding: '8px 12px', fontSize: 11, fontWeight: 600, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 5 }}>
          <svg width="14" height="14" viewBox="0 0 48 48"><path fill="#EA4335" d="M24 9.5c3.5 0 6.3 1.2 8.4 3.1l6.3-6.3C34.8 2.8 29.8.5 24 .5 14.8.5 7 6.2 3.6 14.1l7.3 5.7C12.7 13.5 17.9 9.5 24 9.5z"/><path fill="#4A90D9" d="M46.5 24.5c0-1.6-.1-3.1-.4-4.5H24v8.5h12.7c-.6 3-2.3 5.5-4.9 7.2l7.5 5.8C43.6 37.5 46.5 31.5 46.5 24.5z"/><path fill="#34A853" d="M10.9 28.2A15 15 0 0 1 9.5 24c0-1.5.3-2.9.7-4.2l-7.3-5.7A23.6 23.6 0 0 0 .5 24c0 3.8.9 7.4 2.4 10.6l8-6.4z"/><path fill="#FBBC05" d="M24 47.5c5.8 0 10.7-1.9 14.2-5.1l-7.5-5.8c-1.9 1.3-4.4 2-6.7 2-6.1 0-11.3-4-13.1-9.4l-8 6.4C6.9 41.7 14.8 47.5 24 47.5z"/></svg>
          Login com Google
        </button>
      </div>
    </div>
  );
}

function RegisterForm({ navigate }) {
  const handleRegister = () => {
    // Simula registro bem-sucedido
    localStorage.setItem('isLoggedIn', 'true');

    // Novo usuário sempre NÃO é assinante
    localStorage.removeItem('isSubscriber');

    // Vai para escolha de assinatura
    navigate('subscription-plan');
  };

  return (
    <div style={{ display: 'flex', flexDirection: 'column', alignItems: 'center', gap: 12 }}>
      <div style={{ width: 70, height: 70, borderRadius: '50%', background: '#E8E8E8', display: 'flex', alignItems: 'center', justifyContent: 'center' }}>
        <PersonIcon size={44} color="#aaa" />
      </div>

      <div style={{ width: '100%', display: 'flex', flexDirection: 'column', gap: 10 }}>
        <Input icon="👤" placeholder="Usuário ou e-mail" />
        <Input icon="🔒" placeholder="Senha" type="password" />
        <Input icon="🔒" placeholder="Confirmar a Senha" type="password" />
      </div>

      <Btn onClick={handleRegister} style={{ width: '70%', textAlign: 'center' }}>Registrar</Btn>

      <div style={{ display: 'flex', gap: 10, width: '100%', justifyContent: 'center' }}>
        <button style={{ background: '#3b5998', color: 'white', border: 'none', borderRadius: 6, padding: '8px 10px', fontSize: 11, fontWeight: 600, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 5 }}>
          <span style={{ fontSize: 14, fontWeight: 'bold' }}>f</span> Registrar com Facebook
        </button>
        <button style={{ background: 'white', color: '#555', border: '1.5px solid #ddd', borderRadius: 6, padding: '8px 10px', fontSize: 11, fontWeight: 600, cursor: 'pointer', display: 'flex', alignItems: 'center', gap: 5 }}>
          <svg width="14" height="14" viewBox="0 0 48 48"><path fill="#EA4335" d="M24 9.5c3.5 0 6.3 1.2 8.4 3.1l6.3-6.3C34.8 2.8 29.8.5 24 .5 14.8.5 7 6.2 3.6 14.1l7.3 5.7C12.7 13.5 17.9 9.5 24 9.5z"/><path fill="#4A90D9" d="M46.5 24.5c0-1.6-.1-3.1-.4-4.5H24v8.5h12.7c-.6 3-2.3 5.5-4.9 7.2l7.5 5.8C43.6 37.5 46.5 31.5 46.5 24.5z"/><path fill="#34A853" d="M10.9 28.2A15 15 0 0 1 9.5 24c0-1.5.3-2.9.7-4.2l-7.3-5.7A23.6 23.6 0 0 0 .5 24c0 3.8.9 7.4 2.4 10.6l8-6.4z"/><path fill="#FBBC05" d="M24 47.5c5.8 0 10.7-1.9 14.2-5.1l-7.5-5.8c-1.9 1.3-4.4 2-6.7 2-6.1 0-11.3-4-13.1-9.4l-8 6.4C6.9 41.7 14.8 47.5 24 47.5z"/></svg>
          Registrar com Google
        </button>
      </div>
    </div>
  );
}

Object.assign(window, { LoginScreen });
