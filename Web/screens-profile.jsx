// screens-profile.jsx — Tela 2, 2.1, 2.1.1, 2.1.2, 2.1.3

// ── Tela 2: Profile selector (subscriber) ─────────────────────
function ProfileSelectScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="Fulano de tal" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white', padding:'20px 16px' }}>
        <p style={{ textAlign:'center', color:C.blueDark, fontWeight:800, fontSize:15, marginBottom:24 }}>
          Qual perfil você<br/>quer administrar?
        </p>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:10, maxWidth:320, margin:'0 auto' }}>
          <GridBtn label="ATLETA" icon={<AtletaIcon/>} active={true} onClick={() => navigate('atleta-home')} />
          <GridBtn label="ALUNO" icon={<AlunoIcon/>} active={false} onClick={() => navigate('aluno-home')} />
          <GridBtn label="PROFESSOR" icon={<ProfessorIcon/>} active={false} onClick={() => navigate('professor-home')} />
          <GridBtn label="ARENA" icon={<ArenaIcon/>} active={true} onClick={() => navigate('arena-home')} />
        </div>
        <div style={{ maxWidth:160, margin:'10px auto 0' }}>
          <GridBtn label={"PROFISSIONAL\nTÉCNICO"} icon={<TechIcon/>} active={true} onClick={() => navigate('profissional-home')} />
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 2.1: Subscription chooser (non-subscriber) ───────────
function SubscriptionScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="Fulano de tal" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white', padding:'16px' }}>
        <p style={{ textAlign:'center', color:C.blueDark, fontWeight:800, fontSize:14, marginBottom:16, borderBottom:'1px solid #e0e0e0', paddingBottom:10 }}>
          ESCOLHA SUA ASSINATURA
        </p>
        {[
          { label:'ATLETA', desc:'Acompanhe suas estatísticas nos jogos. Crie relacionamentos com outros atletas. Observe o desempenho das duplas que você participa. Conheça os seus pontos fortes e pontos fracos.', screen:'register-atleta' },
          { label:'ARENA', desc:'Cadastrando sua Arena você poderá incluir os professores que fazem parte dela, bem como seus alunos, dando a oportunidade de analisar o desenvolvimento técnico dos alunos.', screen:'register-arena' },
          { label:'PROFISSIONAL\nTÉCNICO', desc:'Acompanhe suas estatísticas nos jogos. Crie relacionamentos com outros atletas. Observe o desempenho das duplas que você participa. Conheça os seus pontos fortes e pontos fracos.', screen:'payment' },
        ].map((item, i) => (
          <div key={i} style={{ marginBottom:16 }}>
            <div style={{ display:'flex', alignItems:'center', justifyContent:'space-between' }}>
              <button onClick={() => navigate(item.screen)} style={{ background:C.blueDark, color:'white', border:'none', borderRadius:20, padding:'8px 20px', fontWeight:800, fontSize:12, cursor:'pointer', letterSpacing:0.5 }}>{item.label}</button>
              <span style={{ color:'#bbb', fontSize:18, letterSpacing:3 }}>···</span>
            </div>
            <div style={{ background:'#F0F0F0', borderRadius:6, padding:'10px 12px', marginTop:6 }}>
              <p style={{ margin:'0 0 4px', color:'#888', fontWeight:700, fontSize:10, letterSpacing:0.5 }}>FUNCIONALIDADES</p>
              <p style={{ margin:0, fontSize:11, color:'#666', lineHeight:'1.5' }}>{item.desc}</p>
            </div>
          </div>
        ))}
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 2.1.2: Atleta registration form ──────────────────────
function RegisterAtletaScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="Fulano de tal" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white', padding:'12px 14px' }}>
        <p style={{ textAlign:'center', color:C.blueDark, fontWeight:800, fontSize:13, marginBottom:14, borderBottom:'1px solid #e0e0e0', paddingBottom:8 }}>MEUS DADOS</p>
        <div style={{ display:'flex', gap:12, alignItems:'flex-start', marginBottom:12 }}>
          <PhotoPlaceholder size={76} />
          <div style={{ flex:1 }}>
            <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>Nome</p>
            <PillInput placeholder="" />
          </div>
        </div>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:10, marginBottom:10 }}>
          <div>
            <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>Data de Nascimento</p>
            <PillInput placeholder="" />
          </div>
          <div>
            <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>Sexo</p>
            <PillInput placeholder="" />
          </div>
        </div>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:10, marginBottom:10 }}>
          <div>
            <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>Cidade</p>
            <PillInput placeholder="" />
          </div>
          <div>
            <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>E-mail</p>
            <PillInput placeholder="" />
          </div>
        </div>
        <div style={{ marginBottom:10 }}>
          <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>Telefone</p>
          <div style={{ display:'flex', alignItems:'center', gap:8 }}>
            <PillInput placeholder="" style={{ flex:1 }} />
            <label style={{ display:'flex', alignItems:'center', gap:4, fontSize:11, color:'#666', whiteSpace:'nowrap' }}>
              <input type="checkbox" style={{ margin:0 }} /> É WhatsApp?
            </label>
          </div>
        </div>
        <div style={{ marginBottom:12 }}>
          <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>CPF</p>
          <PillInput placeholder="" />
        </div>
        <div style={{ borderTop:'1px solid #e0e0e0', margin:'12px 0' }} />
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:10, marginBottom:16 }}>
          <div>
            <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>Instagram</p>
            <PillInput placeholder="" />
          </div>
          <div>
            <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>Facebook</p>
            <PillInput placeholder="" />
          </div>
        </div>
        <div style={{ display:'flex', justifyContent:'center' }}>
          <Btn onClick={() => navigate('payment')} style={{ padding:'10px 32px' }}>CADASTRAR</Btn>
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 2.1.1: Arena registration form ───────────────────────
function RegisterArenaScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="Fulano de tal" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white', padding:'12px 14px' }}>
        <p style={{ textAlign:'center', color:C.blueDark, fontWeight:800, fontSize:13, marginBottom:14, borderBottom:'1px solid #e0e0e0', paddingBottom:8 }}>MINHA ARENA</p>
        <div style={{ display:'flex', gap:12, alignItems:'flex-start', marginBottom:12 }}>
          <PhotoPlaceholder size={76} />
          <div style={{ flex:1 }}>
            <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>Nome</p>
            <PillInput placeholder="" />
          </div>
        </div>
        <div style={{ display:'flex', flexDirection:'column', gap:10, marginBottom:10 }}>
          <div>
            <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>Endereço</p>
            <PillInput placeholder="" />
          </div>
          <div>
            <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>CNPJ</p>
            <PillInput placeholder="" />
          </div>
        </div>
        <div style={{ marginBottom:10 }}>
          <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>Telefone</p>
          <div style={{ display:'flex', alignItems:'center', gap:8 }}>
            <PillInput placeholder="" style={{ flex:1 }} />
            <label style={{ display:'flex', alignItems:'center', gap:4, fontSize:11, color:'#666', whiteSpace:'nowrap' }}>
              <input type="checkbox" style={{ margin:0 }} /> É WhatsApp?
            </label>
          </div>
        </div>
        <div style={{ marginBottom:12 }}>
          <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>E-mail</p>
          <PillInput placeholder="" />
        </div>
        <div style={{ borderTop:'1px solid #e0e0e0', margin:'12px 0' }} />
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:10, marginBottom:16 }}>
          <div>
            <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>Instagram</p>
            <PillInput placeholder="" />
          </div>
          <div>
            <p style={{ margin:'0 0 4px', color:C.blueDark, fontSize:12, fontWeight:700 }}>Facebook</p>
            <PillInput placeholder="" />
          </div>
        </div>
        <div style={{ display:'flex', justifyContent:'center' }}>
          <Btn onClick={() => navigate('payment')} style={{ padding:'10px 32px' }}>CADASTRAR</Btn>
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 2.1.3: Payment screen ────────────────────────────────
function PaymentScreen({ navigate, goBack }) {
  const [payTab, setPayTab] = React.useState('card');
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="Fulano de tal" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white', padding:'12px 14px' }}>
        <p style={{ textAlign:'center', color:C.blueDark, fontWeight:800, fontSize:13, marginBottom:16, borderBottom:'1px solid #e0e0e0', paddingBottom:8 }}>FORMA DE PAGAMENTO</p>
        <div style={{ background:'#F0F0F0', borderRadius:10, overflow:'hidden', marginBottom:4 }}>
          {/* Tab headers */}
          <div style={{ display:'flex' }}>
            <button onClick={() => setPayTab('card')} style={{ flex:1, padding:'10px 8px', background: payTab==='card' ? 'white' : '#F0F0F0', border:'none', borderRadius: payTab==='card' ? '10px 0 0 0' : '0', cursor:'pointer', fontWeight:700, fontSize:12, display:'flex', alignItems:'center', justifyContent:'center', gap:6, color:'#555' }}>
              💳 CARTÃO DE<br/>CRÉDITO
            </button>
            <button onClick={() => setPayTab('pix')} style={{ flex:1, padding:'10px 8px', background: payTab==='pix' ? 'white' : '#F0F0F0', border:'none', borderRadius: payTab==='pix' ? '0 10px 0 0' : '0', cursor:'pointer', fontWeight:700, fontSize:12, display:'flex', alignItems:'center', justifyContent:'center', gap:6, color:'#555' }}>
              <svg width="20" height="20" viewBox="0 0 20 20" fill="none"><rect x="1" y="1" width="7" height="7" rx="1" stroke="#555" strokeWidth="1.5"/><rect x="12" y="1" width="7" height="7" rx="1" stroke="#555" strokeWidth="1.5"/><rect x="1" y="12" width="7" height="7" rx="1" stroke="#555" strokeWidth="1.5"/><rect x="13" y="13" width="2" height="2" fill="#555"/><rect x="16" y="13" width="2" height="2" fill="#555"/><rect x="13" y="16" width="5" height="2" fill="#555"/></svg>
              PIX
            </button>
          </div>
          {/* Card form */}
          <div style={{ background:'white', padding:'14px 12px', display:'flex', flexDirection:'column', gap:10 }}>
            {payTab === 'card' ? (
              <>
                <PillInput placeholder="Número do cartão (apenas números)" />
                <PillInput placeholder="Digite o nome do titular" />
                <div style={{ display:'flex', gap:8 }}>
                  <PillInput placeholder="Código de segurança" style={{ flex:1 }} />
                  <button style={{ background:C.blue, color:'white', border:'none', borderRadius:'50%', width:32, height:32, fontSize:14, fontWeight:'bold', cursor:'pointer', flexShrink:0 }}>?</button>
                </div>
                <div style={{ display:'flex', alignItems:'center', gap:6 }}>
                  <span style={{ fontSize:13 }}>📅</span>
                  <PillInput placeholder="Data de vencimento" style={{ flex:1 }} />
                </div>
                <div style={{ display:'flex', alignItems:'center', gap:6 }}>
                  <span style={{ fontSize:12, color:'#aaa' }}>▼</span>
                  <PillInput placeholder="Pacote" style={{ flex:1 }} />
                </div>
              </>
            ) : (
              <>
                <div style={{ display:'flex', alignItems:'center', gap:6 }}>
                  <span style={{ fontSize:12, color:'#aaa' }}>▼</span>
                  <PillInput placeholder="Pacote" style={{ flex:1 }} />
                </div>
                {/* QR Code placeholder */}
                <div style={{ display:'flex', justifyContent:'center', padding:'8px 0' }}>
                  <div style={{ width:120, height:120, border:'2px solid #ccc', borderRadius:4, display:'flex', alignItems:'center', justifyContent:'center' }}>
                    <svg width="100" height="100" viewBox="0 0 100 100" fill="none">
                      <rect x="5" y="5" width="30" height="30" rx="2" stroke="#aaa" strokeWidth="3" fill="none"/>
                      <rect x="12" y="12" width="16" height="16" rx="1" fill="#bbb"/>
                      <rect x="65" y="5" width="30" height="30" rx="2" stroke="#aaa" strokeWidth="3" fill="none"/>
                      <rect x="72" y="12" width="16" height="16" rx="1" fill="#bbb"/>
                      <rect x="5" y="65" width="30" height="30" rx="2" stroke="#aaa" strokeWidth="3" fill="none"/>
                      <rect x="12" y="72" width="16" height="16" rx="1" fill="#bbb"/>
                      <rect x="45" y="5" width="4" height="4" fill="#bbb"/><rect x="52" y="5" width="4" height="4" fill="#bbb"/>
                      <rect x="45" y="12" width="4" height="4" fill="#bbb"/><rect x="59" y="12" width="4" height="4" fill="#bbb"/>
                      <rect x="45" y="45" width="4" height="4" fill="#bbb"/><rect x="52" y="52" width="4" height="4" fill="#bbb"/>
                      <rect x="65" y="45" width="4" height="4" fill="#bbb"/><rect x="72" y="45" width="4" height="4" fill="#bbb"/>
                      <rect x="80" y="52" width="4" height="4" fill="#bbb"/><rect x="65" y="59" width="4" height="4" fill="#bbb"/>
                      <rect x="45" y="65" width="4" height="4" fill="#bbb"/><rect x="52" y="72" width="4" height="4" fill="#bbb"/>
                      <rect x="59" y="65" width="4" height="4" fill="#bbb"/><rect x="45" y="80" width="4" height="4" fill="#bbb"/>
                      <rect x="72" y="65" width="4" height="4" fill="#bbb"/><rect x="80" y="72" width="4" height="4" fill="#bbb"/>
                      <rect x="65" y="80" width="4" height="4" fill="#bbb"/><rect x="80" y="80" width="4" height="4" fill="#bbb"/>
                    </svg>
                  </div>
                </div>
                <div style={{ display:'flex', alignItems:'center', gap:6 }}>
                  <PillInput placeholder="blablablablablablablablablablablabla" style={{ flex:1, fontSize:10 }} />
                  <button style={{ background:'none', border:'none', cursor:'pointer', color:'#aaa', fontSize:11, display:'flex', alignItems:'center', gap:3, flexShrink:0 }}>
                    <svg width="14" height="14" viewBox="0 0 14 14" fill="none"><rect x="1" y="3" width="10" height="10" rx="1" stroke="#aaa" strokeWidth="1.2"/><path d="M4 3V2a1 1 0 011-1h6a1 1 0 011 1v8a1 1 0 01-1 1h-1" stroke="#aaa" strokeWidth="1.2"/></svg>
                    Copiar
                  </button>
                </div>
              </>
            )}
            <div style={{ display:'flex', gap:10, justifyContent:'center', marginTop:4 }}>
              <Btn onClick={() => navigate('profile-select')} style={{ padding:'10px 24px' }}>Pagar</Btn>
              <Btn color={C.yellowBtn} textColor="#333" style={{ padding:'10px 20px' }}>Cancelar</Btn>
            </div>
          </div>
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

Object.assign(window, { ProfileSelectScreen, SubscriptionScreen, RegisterAtletaScreen, RegisterArenaScreen, PaymentScreen });
