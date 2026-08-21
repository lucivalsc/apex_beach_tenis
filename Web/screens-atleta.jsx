// screens-atleta.jsx — Tela 7, 7.1, 8, 8.1, 8.2, 9, 9.1, 9.2, 11, 12, 12.1, 12.2

const myJogosList = [
  { date:'26/10/2023', jogo:'Fulano/Beltrano x Ciclano...', status:true },
  { date:'26/10/2023', jogo:'Fulano/Beltrano x Ciclano...', status:'-' },
  { date:'26/10/2023', jogo:'Fulano/Beltrano x Ciclano...', status:'-' },
  { date:'26/10/2023', jogo:'Fulano x Ciclano', status:true },
  { date:'26/10/2023', jogo:'Fulano/Beltrano x Ciclano...', status:true },
  { date:'26/10/2023', jogo:'Fulano x Ciclano', status:true },
  { date:'26/10/2023', jogo:'Fulano/Beltrano x Ciclano...', status:'-' },
  { date:'26/10/2023', jogo:'Fulano x Ciclano', status:true },
  { date:'26/10/2023', jogo:'Fulano/Beltrano x Ciclano...', status:'-' },
  { date:'26/10/2023', jogo:'Fulano x Ciclano', status:true },
  { date:'26/10/2023', jogo:'Fulano x Ciclano', status:true },
];

// ── Tela 7: Atleta Home ───────────────────────────────────────
function AtletaHomeScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="FULANO DE TAL" onBack={goBack}>
        <ProfTecnicoNotifs />
      </ProfileHeader>
      <div style={{ flex:1, overflowY:'auto', background:'white', padding:'10px 14px' }}>
        <SearchBar placeholder="Buscar atletas" />
        <SectionTitle>SOLICITAÇÕES DE JOGOS</SectionTitle>
        {[0,1,2].map(i => (
          <div key={i} style={{ display:'flex', alignItems:'center', padding:'8px 12px', borderBottom:'1px solid #f0f0f0', gap:8 }}>
            <div style={{ width:30, height:30, borderRadius:6, background:C.blue, display:'flex', alignItems:'center', justifyContent:'center', flexShrink:0 }}>
              <svg width="18" height="18" viewBox="0 0 18 18" fill="none"><rect x="1" y="1" width="16" height="16" rx="3" stroke="white" strokeWidth="1.5"/><circle cx="9" cy="7" r="2" stroke="white" strokeWidth="1.5"/><path d="M3.5 15c0-3 2.5-4.5 5.5-4.5s5.5 1.5 5.5 4.5" stroke="white" strokeWidth="1.5"/></svg>
            </div>
            <span style={{ flex:1, color:C.blue, fontSize:13 }}>Pulano Campos Silva</span>
            <span style={{ color:C.green, fontSize:18, cursor:'pointer' }}>✓</span>
            <span style={{ color:C.red, fontSize:18, cursor:'pointer', marginLeft:6 }}>✗</span>
          </div>
        ))}
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:10, marginTop:14, maxWidth:320, margin:'14px auto 0' }}>
          <GridBtn label={"MINHAS\nESTATÍSTICAS"} icon={<EstatisticasIcon/>} active={true} onClick={() => navigate('atleta-stats')} />
          <GridBtn label={"ADICIONAR\nJOGO"} icon={<AdicionarJogoIcon/>} active={false} onClick={() => navigate('jogo-modo')} />
          <GridBtn label={"LISTAR\nJOGOS"} icon={<CalendarioIcon/>} active={false} onClick={() => navigate('atleta-jogos')} />
          <GridBtn label={"ALTERNAR\nPERFIL"} icon={<AlternarPerfilIcon/>} active={true} onClick={() => navigate('profile-select')} />
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 7.1: Meus Jogos list ─────────────────────────────────
function AtletaJogosScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="FULANO DE TAL" onBack={goBack}>
        <ProfTecnicoNotifs />
      </ProfileHeader>
      <div style={{ flex:1, overflowY:'auto', background:'white' }}>
        <SearchBar placeholder="Buscar atletas" />
        <SectionTitle>MEUS JOGOS</SectionTitle>
        <div style={{ display:'flex', padding:'4px 12px', borderBottom:'1px solid #e0e0e0', gap:4 }}>
          <span style={{ flex:'0 0 80px', fontSize:11, color:'#999' }}>Data ⇅</span>
          <span style={{ flex:1, fontSize:11, color:'#999' }}>Professor ⇅</span>
          <span style={{ fontSize:11, color:'#999', marginRight:14 }}>Ver</span>
          <span style={{ fontSize:11, color:'#999', marginRight:14 }}>Editar</span>
          <span style={{ fontSize:11, color:'#999' }}>Status</span>
        </div>
        {myJogosList.map((row, i) => (
          <div key={i} style={{ display:'flex', alignItems:'center', padding:'7px 12px', borderBottom:'1px solid #f0f0f0', gap:4 }}>
            <span style={{ flex:'0 0 80px', fontSize:12, color:C.blue }}>{row.date}</span>
            <span style={{ flex:1, fontSize:12, color:C.blue }}>{row.jogo}</span>
            <button onClick={() => navigate('jogo-placar')} style={{ background:'none', border:'none', cursor:'pointer', padding:'0 3px', marginRight:4 }}><EyeIcon color={C.blue}/></button>
            <button style={{ background:'none', border:'none', cursor:'pointer', padding:'0 3px', marginRight:4 }}><EditIcon color={C.yellowBtn}/></button>
            {row.status === true && <span style={{ color:C.green, fontSize:15 }}>✓</span>}
            {row.status === '-' && <span style={{ color:'#bbb', fontSize:15 }}>-</span>}
          </div>
        ))}
        <div style={{ display:'flex', justifyContent:'center', padding:'16px 0' }}>
          <Btn onClick={() => navigate('jogo-modo')} style={{ padding:'9px 28px', borderRadius:20 }}>Novo Jogo</Btn>
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 8: Modo de Jogo ──────────────────────────────────────
function JogoModoScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="FULANO DE TAL" onBack={goBack}>
        <ProfTecnicoNotifs />
      </ProfileHeader>
      <div style={{ flex:1, background:'white', display:'flex', flexDirection:'column' }}>
        <SectionTitle>MODO DE JOGO</SectionTitle>
        <div style={{ flex:1, display:'flex', alignItems:'center', justifyContent:'center' }}>
          <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:10, padding:'20px', maxWidth:300 }}>
            <GridBtn label="SIMPLES" icon={<SimplesIcon/>} active={true} onClick={() => navigate('jogo-register-simples')} />
            <GridBtn label="DUPLAS" icon={<DuplasIcon/>} active={false} onClick={() => navigate('jogo-register-duplas')} />
          </div>
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 8.1 / 8.2: Cadastro de Jogo ─────────────────────────
function JogoRegisterScreen({ navigate, goBack, duplas = false }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="FULANO DE TAL" onBack={goBack}>
        <ProfTecnicoNotifs />
      </ProfileHeader>
      <div style={{ flex:1, overflowY:'auto', background:'white', padding:'12px 14px' }}>
        <SectionTitle>CADASTRO DE JOGO</SectionTitle>
        <div style={{ height:12 }} />
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8, marginBottom:8 }}>
          <div style={{ display:'flex', alignItems:'center', gap:5, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
            <span style={{ fontSize:12 }}>📅</span>
            <span style={{ fontSize:11, color:'#999' }}>Data do jogo</span>
          </div>
          <PillInput placeholder="Local" />
        </div>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8, marginBottom:8 }}>
          <PillInput placeholder="Início" />
          <PillInput placeholder="Término" />
        </div>
        {duplas ? (
          <>
            <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8, marginBottom:4 }}>
              <div style={{ display:'flex', alignItems:'center', gap:5, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
                <svg width="12" height="12" viewBox="0 0 14 14" fill="none"><circle cx="6" cy="6" r="5" stroke="#aaa" strokeWidth="1.5"/><line x1="10" y1="10" x2="13" y2="13" stroke="#aaa" strokeWidth="1.5" strokeLinecap="round"/></svg>
                <span style={{ fontSize:11, color:'#999' }}>Buscar Atleta 1</span>
              </div>
              <div style={{ display:'flex', alignItems:'center', gap:5, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
                <svg width="12" height="12" viewBox="0 0 14 14" fill="none"><circle cx="6" cy="6" r="5" stroke="#aaa" strokeWidth="1.5"/><line x1="10" y1="10" x2="13" y2="13" stroke="#aaa" strokeWidth="1.5" strokeLinecap="round"/></svg>
                <span style={{ fontSize:11, color:'#999' }}>Buscar Atleta 2</span>
              </div>
            </div>
            <div style={{ textAlign:'center', color:C.blue, fontWeight:'bold', fontSize:16, margin:'4px 0' }}>X</div>
            <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8, marginBottom:8 }}>
              <div style={{ display:'flex', alignItems:'center', gap:5, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
                <svg width="12" height="12" viewBox="0 0 14 14" fill="none"><circle cx="6" cy="6" r="5" stroke="#aaa" strokeWidth="1.5"/><line x1="10" y1="10" x2="13" y2="13" stroke="#aaa" strokeWidth="1.5" strokeLinecap="round"/></svg>
                <span style={{ fontSize:11, color:'#999' }}>Buscar Atleta 3</span>
              </div>
              <div style={{ display:'flex', alignItems:'center', gap:5, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
                <svg width="12" height="12" viewBox="0 0 14 14" fill="none"><circle cx="6" cy="6" r="5" stroke="#aaa" strokeWidth="1.5"/><line x1="10" y1="10" x2="13" y2="13" stroke="#aaa" strokeWidth="1.5" strokeLinecap="round"/></svg>
                <span style={{ fontSize:11, color:'#999' }}>Buscar Atleta 4</span>
              </div>
            </div>
          </>
        ) : (
          <>
            <div style={{ display:'flex', alignItems:'center', gap:5, background:'#EBEBEB', borderRadius:20, padding:'8px 12px', marginBottom:4 }}>
              <svg width="12" height="12" viewBox="0 0 14 14" fill="none"><circle cx="6" cy="6" r="5" stroke="#aaa" strokeWidth="1.5"/><line x1="10" y1="10" x2="13" y2="13" stroke="#aaa" strokeWidth="1.5" strokeLinecap="round"/></svg>
              <span style={{ fontSize:11, color:'#999' }}>Buscar Atleta 1</span>
            </div>
            <div style={{ textAlign:'center', color:C.blue, fontWeight:'bold', fontSize:16, margin:'4px 0' }}>X</div>
            <div style={{ display:'flex', alignItems:'center', gap:5, background:'#EBEBEB', borderRadius:20, padding:'8px 12px', marginBottom:8 }}>
              <svg width="12" height="12" viewBox="0 0 14 14" fill="none"><circle cx="6" cy="6" r="5" stroke="#aaa" strokeWidth="1.5"/><line x1="10" y1="10" x2="13" y2="13" stroke="#aaa" strokeWidth="1.5" strokeLinecap="round"/></svg>
              <span style={{ fontSize:11, color:'#999' }}>Buscar Atleta 2</span>
            </div>
          </>
        )}
        <div style={{ display:'flex', alignItems:'center', gap:5, background:'#EBEBEB', borderRadius:20, padding:'8px 12px', marginBottom:12 }}>
          <svg width="12" height="12" viewBox="0 0 14 14" fill="none"><circle cx="6" cy="6" r="5" stroke="#aaa" strokeWidth="1.5"/><line x1="10" y1="10" x2="13" y2="13" stroke="#aaa" strokeWidth="1.5" strokeLinecap="round"/></svg>
          <span style={{ fontSize:11, color:'#999' }}>Adicionar Profissional Técnico</span>
        </div>
        <div style={{ display:'flex', gap:10, justifyContent:'center', marginBottom:14 }}>
          <Btn onClick={() => navigate('jogo-ponto')} style={{ padding:'10px 24px' }}>Salvar</Btn>
          <Btn color={C.yellowBtn} textColor="#333" onClick={goBack} style={{ padding:'10px 20px' }}>Cancelar</Btn>
        </div>
        <div style={{ fontSize:10, color:'#888', lineHeight:'1.6' }}>
          <p style={{ margin:'0 0 2px', fontWeight:700 }}>OBS:</p>
          <p style={{ margin:'0 0 2px' }}>1. Se for o profissional técnico que estiver cadastrando o jogo ele somente conseguirá buscar atletas que ele já tenha sido adicionado a permissão para administrar os jogos</p>
          <p style={{ margin:'0 0 2px' }}>2. Se for o atleta que estiver cadastrando o jogo, o campo "Buscar Atleta 1" será apenas leitura, trará o nome do Atleta.</p>
          <p style={{ margin:'0 0 2px' }}>3. Se o atleta não for encontrado, ou seja, se ele não estiver cadastrado, mostrar opção para convidar, inserindo e-mail e/ou celular.</p>
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 9.2: Placar do Jogo ──────────────────────────────────
function JogoPlacarScreen({ navigate, goBack }) {
  const [showModal, setShowModal] = React.useState(false);
  const [showJogadas, setShowJogadas] = React.useState(false);
  const pontos = [
    'SET 1 - G1 - 15X0','SET 1 - G1 - 30X0','SET 1 - G1 - 40X0','SET 1 - G1 - 40X15','SET 1 - G1 1X0',
    'SET 1 - G2 - 15X0','SET 1 - G2 - 15X15','SET 1 - G2 - 15X30','SET 1 - G2 - 30X30','SET 1 - G2 - 40X30',
    'SET 1 - G2 - 2X0','SET 1 - G3 - 15X0',
  ];
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%', position:'relative' }}>
      <ProfileHeader name="FULANO DE TAL" onBack={goBack}>
        <ProfTecnicoNotifs />
      </ProfileHeader>
      <div style={{ flex:1, overflowY:'auto', background:'white' }}>
        {/* Scoreboard */}
        <div style={{ background:'#111', padding:'10px 14px' }}>
          <p style={{ color:'white', fontWeight:800, fontSize:13, textAlign:'center', margin:'0 0 8px', letterSpacing:1 }}>PLACAR DO JOGO</p>
          <div style={{ display:'grid', gridTemplateColumns:'auto 1fr 1fr 1fr 1fr 1fr', gap:4, alignItems:'center' }}>
            <div />
            {['SET 1','SET 2','SET 3','GAMES','PONTOS'].map(h => (
              <span key={h} style={{ color:'#aaa', fontSize:9, textAlign:'center', fontWeight:700 }}>{h}</span>
            ))}
            <span style={{ color:'white', fontSize:11, fontWeight:600, paddingRight:4 }}>Fulano/Beltrano</span>
            {['6','6','5','5','30'].map((v, i) => (
              <div key={i} style={{ background:'#222', border:'1px solid #333', borderRadius:4, padding:'4px 2px', textAlign:'center', color:'#FFD700', fontFamily:'monospace', fontWeight:'bold', fontSize:14 }}>{v}</div>
            ))}
            <span style={{ color:'white', fontSize:11, fontWeight:600, paddingRight:4 }}>Ciclano/Selfieano</span>
            {['1','1','1','7','A'].map((v, i) => (
              <div key={i} style={{ background:'#222', border:'1px solid #333', borderRadius:4, padding:'4px 2px', textAlign:'center', color:'#FFD700', fontFamily:'monospace', fontWeight:'bold', fontSize:14 }}>{v}</div>
            ))}
          </div>
          <div style={{ display:'flex', justifyContent:'flex-end', marginTop:8 }}>
            <button onClick={() => setShowModal(true)} style={{ background:'none', border:'none', color:C.blue, fontSize:12, cursor:'pointer', display:'flex', alignItems:'center', gap:4, fontWeight:700 }}>
              ADICIONAR PONTO <span style={{ fontSize:18, fontWeight:'bold' }}>+</span>
            </button>
          </div>
        </div>
        {/* Points list */}
        {pontos.map((p, i) => (
          <div key={i} style={{ display:'flex', alignItems:'center', padding:'7px 12px', borderBottom:'1px solid #f0f0f0', gap:4 }}>
            <span style={{ flex:1, fontSize:12, color:C.blue }}>{p}</span>
            <span style={{ flex:1, fontSize:12, color:C.blue }}>Fulano/Beltrano x Ciclano...</span>
            <button style={{ background:'none', border:'none', cursor:'pointer', padding:'0 3px' }}><EyeIcon color={C.blue}/></button>
            <button style={{ background:'none', border:'none', cursor:'pointer', padding:'0 3px' }}><EditIcon color={C.yellowBtn}/></button>
          </div>
        ))}
      </div>
      <BottomBar />
      {showModal && <CadastrarPontoModal onClose={() => setShowModal(false)} onNext={() => { setShowModal(false); setShowJogadas(true); }} />}
      {showJogadas && <CadastrarJogadasModal onClose={() => setShowJogadas(false)} />}
    </div>
  );
}

// ── Tela 9: Cadastrar Ponto (saque) ──────────────────────────
function CadastrarPontoModal({ onClose, onNext }) {
  return (
    <Modal title="CADASTRAR PONTO" onClose={onClose}>
      <div style={{ display:'flex', flexDirection:'column', gap:9 }}>
        <div style={{ display:'flex', alignItems:'center', gap:6, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
          <span style={{ fontSize:12 }}>✅</span>
          <span style={{ fontSize:11, color:'#888' }}>Início</span>
        </div>
        <p style={{ textAlign:'center', color:C.blue, fontWeight:800, fontSize:13, margin:'4px 0 2px' }}>SAQUE</p>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8 }}>
          <div style={{ display:'flex', alignItems:'center', gap:4, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
            <span style={{ fontSize:11, color:'#aaa' }}>▼</span>
            <span style={{ fontSize:11, color:'#888' }}>Quem sacou?</span>
          </div>
          <div style={{ display:'flex', alignItems:'center', gap:4, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
            <span style={{ fontSize:11, color:'#aaa' }}>▼</span>
            <span style={{ fontSize:11, color:'#888' }}>Estilo do saque</span>
          </div>
          <div style={{ display:'flex', alignItems:'center', gap:4, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
            <span style={{ fontSize:11, color:'#aaa' }}>▼</span>
            <span style={{ fontSize:11, color:'#888' }}>De onde sacou?</span>
          </div>
          <div style={{ display:'flex', alignItems:'center', gap:4, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
            <span style={{ fontSize:11, color:'#aaa' }}>▼</span>
            <span style={{ fontSize:11, color:'#888' }}>Aonde sacou?</span>
          </div>
        </div>
        <div style={{ display:'flex', gap:16 }}>
          <label style={{ display:'flex', alignItems:'center', gap:4, fontSize:11, color:'#666' }}><input type="checkbox" style={{ margin:0 }}/> Finalizou o ponto?</label>
          <label style={{ display:'flex', alignItems:'center', gap:4, fontSize:11, color:'#666' }}><input type="checkbox" style={{ margin:0 }}/> Foi fora/rede</label>
        </div>
        <p onClick={onNext} style={{ textAlign:'center', margin:'2px 0', fontSize:11, color:C.blue, cursor:'pointer', fontWeight:700 }}>+ ADICIONAR JOGADA +</p>
        <div style={{ display:'flex', alignItems:'center', gap:6, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
          <span style={{ fontSize:12 }}>✅</span>
          <span style={{ fontSize:11, color:'#888' }}>Término</span>
        </div>
        <div style={{ display:'flex', gap:10, justifyContent:'center', marginTop:4 }}>
          <Btn style={{ padding:'9px 24px' }}>Salvar</Btn>
          <Btn color={C.yellowBtn} textColor="#333" onClick={onClose} style={{ padding:'9px 20px' }}>Cancelar</Btn>
        </div>
      </div>
    </Modal>
  );
}

// ── Tela 9.1: Cadastrar Ponto com Jogadas ────────────────────
function CadastrarJogadasModal({ onClose }) {
  return (
    <Modal title="CADASTRAR PONTO" onClose={onClose}>
      <div style={{ display:'flex', flexDirection:'column', gap:8 }}>
        <div style={{ display:'flex', alignItems:'center', gap:6, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
          <span style={{ fontSize:12 }}>✅</span>
          <span style={{ fontSize:11, color:'#888' }}>Início</span>
        </div>
        <div style={{ display:'flex', padding:'2px 4px', gap:4 }}>
          <span style={{ flex:'0 0 60px', fontSize:11, color:'#888' }}>Jogada</span>
          <span style={{ flex:'0 0 60px', fontSize:11, color:'#888' }}>Atleta</span>
          <span style={{ flex:1, fontSize:11, color:'#888' }}>Golpe</span>
          <span style={{ fontSize:11, color:'#888' }}>Ações</span>
        </div>
        {[['Saque','Fulano','Saque'],['Bola 1','Ciclano','Devolução'],['Bola 2','Beltrano','Curta']].map(([j,a,g], i) => (
          <div key={i} style={{ display:'flex', alignItems:'center', gap:4 }}>
            <span style={{ flex:'0 0 60px', fontSize:12, color:C.blue, fontWeight:600 }}>{j}</span>
            <span style={{ flex:'0 0 60px', fontSize:12, color:C.blue }}>{a}</span>
            <span style={{ flex:1, fontSize:12, color:C.blue }}>{g}</span>
            <button style={{ background:'none', border:'none', cursor:'pointer', padding:'0 2px' }}><EyeIcon color={C.blue} size={15}/></button>
            <button style={{ background:'none', border:'none', cursor:'pointer', padding:'0 2px' }}><EditIcon color={C.yellowBtn} size={15}/></button>
            <span style={{ color:C.red, fontSize:14, cursor:'pointer' }}>✗</span>
          </div>
        ))}
        <p style={{ textAlign:'center', margin:'2px 0', fontSize:11, color:C.blue, cursor:'pointer', fontWeight:700 }}>+ ADICIONAR JOGADA +</p>
        <p style={{ textAlign:'center', color:C.blue, fontWeight:800, fontSize:13, margin:'4px 0 2px' }}>JOGADA</p>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8 }}>
          <div style={{ display:'flex', alignItems:'center', gap:4, background:'#EBEBEB', borderRadius:20, padding:'8px 10px' }}>
            <span style={{ fontSize:10, color:'#aaa' }}>▼</span><span style={{ fontSize:11, color:'#888' }}>Quem finalizou?</span>
          </div>
          <div style={{ display:'flex', alignItems:'center', gap:4, background:'#EBEBEB', borderRadius:20, padding:'8px 10px' }}>
            <span style={{ fontSize:10, color:'#aaa' }}>▼</span><span style={{ fontSize:11, color:'#888' }}>Quando finalizou</span>
          </div>
          <div style={{ display:'flex', alignItems:'center', gap:4, background:'#EBEBEB', borderRadius:20, padding:'8px 10px' }}>
            <span style={{ fontSize:10, color:'#aaa' }}>▼</span><span style={{ fontSize:11, color:'#888' }}>Qual golpe?</span>
          </div>
          <div style={{ display:'flex', alignItems:'center', gap:4, background:'#EBEBEB', borderRadius:20, padding:'8px 10px' }}>
            <span style={{ fontSize:12 }}>✅</span><span style={{ fontSize:11, color:'#888' }}>Término</span>
          </div>
        </div>
        <div style={{ display:'flex', gap:16 }}>
          <label style={{ display:'flex', alignItems:'center', gap:4, fontSize:11, color:'#666' }}><input type="checkbox" style={{ margin:0 }}/> Finalizou o ponto?</label>
          <label style={{ display:'flex', alignItems:'center', gap:4, fontSize:11, color:'#666' }}><input type="checkbox" style={{ margin:0 }}/> Foi fora/rede</label>
        </div>
        <div style={{ display:'flex', alignItems:'center', gap:6, background:'#EBEBEB', borderRadius:20, padding:'8px 12px' }}>
          <span style={{ fontSize:12 }}>✅</span><span style={{ fontSize:11, color:'#888' }}>Término</span>
        </div>
        <div style={{ display:'flex', gap:10, justifyContent:'center', marginTop:4 }}>
          <Btn style={{ padding:'9px 24px' }}>Salvar</Btn>
          <Btn color={C.yellowBtn} textColor="#333" onClick={onClose} style={{ padding:'9px 20px' }}>Cancelar</Btn>
        </div>
      </div>
    </Modal>
  );
}

// ── Tela 11: Meus Amigos ──────────────────────────────────────
function AmigosScreen({ navigate, goBack }) {
  const amigos = [
    { name:'Amigo 1', comuns:32 },{ name:'Amigo 2', comuns:42 },{ name:'Amigo 3', comuns:11 },
    { name:'Amigo 4', comuns:8 },{ name:'Amigo 5', comuns:5 },{ name:'Amigo 6', comuns:23 },
    { name:'Amigo 7', comuns:66 },
  ];
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="FULANO DE TAL" onBack={goBack}>
        <ProfTecnicoNotifs />
      </ProfileHeader>
      <div style={{ flex:1, overflowY:'auto', background:'white' }}>
        <SearchBar placeholder="Buscar atletas" onPlus={() => {}} />
        <SectionTitle>MEUS AMIGOS</SectionTitle>
        <p style={{ margin:'8px 12px 4px', fontSize:13, color:'#777', fontWeight:600 }}>564 Amigos</p>
        {amigos.map((a, i) => (
          <div key={i} style={{ display:'flex', alignItems:'center', padding:'8px 12px', borderBottom:'1px solid #f0f0f0', gap:10 }}>
            <div style={{ width:42, height:42, borderRadius:8, background:C.blue, display:'flex', alignItems:'center', justifyContent:'center', flexShrink:0 }}>
              <svg width="22" height="22" viewBox="0 0 18 18" fill="none"><rect x="1" y="1" width="16" height="16" rx="3" stroke="white" strokeWidth="1.5"/><circle cx="9" cy="7" r="2" stroke="white" strokeWidth="1.5"/><path d="M3.5 15c0-3 2.5-4.5 5.5-4.5s5.5 1.5 5.5 4.5" stroke="white" strokeWidth="1.5"/></svg>
            </div>
            <div style={{ flex:1 }}>
              <p style={{ margin:0, fontSize:13, fontWeight:600, color:C.blue }}>{a.name}</p>
              <p style={{ margin:0, fontSize:11, color:'#999' }}>{a.comuns} amigos em comum</p>
            </div>
            <span style={{ color:'#bbb', fontSize:18, letterSpacing:2, cursor:'pointer' }}>···</span>
          </div>
        ))}
      </div>
      <BottomBar />
    </div>
  );
}

// ── SVG Pie Chart helper ───────────────────────────────────────
function PieChart({ segments, size=90 }) {
  const r = 38, cx = 45, cy = 45;
  let start = -Math.PI/2;
  const paths = segments.map(({ pct, color }) => {
    const angle = (pct / 100) * 2 * Math.PI;
    const x1 = cx + r * Math.cos(start);
    const y1 = cy + r * Math.sin(start);
    start += angle;
    const x2 = cx + r * Math.cos(start);
    const y2 = cy + r * Math.sin(start);
    const large = angle > Math.PI ? 1 : 0;
    return <path key={color} d={`M${cx},${cy} L${x1},${y1} A${r},${r},0,${large},1,${x2},${y2}Z`} fill={color}/>;
  });
  return <svg width={size} height={size} viewBox="0 0 90 90">{paths}</svg>;
}

function DonutChart({ segments, size=90 }) {
  const r = 32, ir = 18, cx = 45, cy = 45;
  let start = -Math.PI/2;
  const paths = segments.map(({ pct, color }) => {
    const angle = (pct / 100) * 2 * Math.PI;
    const x1 = cx + r * Math.cos(start); const y1 = cy + r * Math.sin(start);
    const ix1 = cx + ir * Math.cos(start); const iy1 = cy + ir * Math.sin(start);
    start += angle;
    const x2 = cx + r * Math.cos(start); const y2 = cy + r * Math.sin(start);
    const ix2 = cx + ir * Math.cos(start); const iy2 = cy + ir * Math.sin(start);
    const large = angle > Math.PI ? 1 : 0;
    return <path key={color} d={`M${ix1},${iy1} L${x1},${y1} A${r},${r},0,${large},1,${x2},${y2} L${ix2},${iy2} A${ir},${ir},0,${large},0,${ix1},${iy1}Z`} fill={color}/>;
  });
  return <svg width={size} height={size} viewBox="0 0 90 90">{paths}</svg>;
}

// ── Tela 12 / 12.2: Minhas Estatísticas ──────────────────────
function AtletaStatsScreen({ navigate, goBack, title='MINHAS ESTATÍSTICAS' }) {
  const statBoxes = [
    { label:'SAQUES\nQUEBRADOS', val:'15%', active:true },
    { label:'SAQUES\nCONFIRMADOS', val:'85%', active:false },
    { label:'ACES', val:'5%', active:false },
    { label:'BOLAS\nVENCIDAS', val:'58%', active:true },
  ];
  const pieSegs = [{ pct:80, color:C.blue },{ pct:20, color:C.yellowBtn }];
  const donutSegs = [
    { pct:25, color:C.blue },{ pct:8, color:'#aaa' },
    { pct:31, color:'#8B8B00' },{ pct:20, color:C.yellowBtn },{ pct:16, color:'#90C030' },
  ];
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="FULANO DE TAL" onBack={goBack}>
        <ProfTecnicoNotifs />
      </ProfileHeader>
      <div style={{ flex:1, overflowY:'auto', background:'white', padding:'0 0 16px' }}>
        <SectionTitle>{title}</SectionTitle>
        {/* Stat boxes */}
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr 1fr 1fr', gap:6, padding:'10px 12px' }}>
          {statBoxes.map((s,i) => (
            <div key={i} style={{ background: s.active ? C.blue : '#D0D0D0', borderRadius:8, padding:'8px 4px', textAlign:'center' }}>
              <p style={{ margin:'0 0 2px', color:'white', fontWeight:800, fontSize:14 }}>{s.val}</p>
              <p style={{ margin:0, color:'white', fontSize:9, lineHeight:'1.2', whiteSpace:'pre-line' }}>{s.label}</p>
            </div>
          ))}
        </div>
        {/* Pie + table */}
        <div style={{ display:'flex', alignItems:'center', gap:12, padding:'0 14px 10px' }}>
          <div style={{ position:'relative' }}>
            <PieChart segments={pieSegs} size={90}/>
            <div style={{ position:'absolute', top:'30%', left:'15%', color:'#fff', fontSize:10, fontWeight:700 }}>20%</div>
            <div style={{ position:'absolute', top:'55%', left:'30%', color:'#fff', fontSize:11, fontWeight:700 }}>80%</div>
          </div>
          <table style={{ flex:1, borderCollapse:'collapse', fontSize:11 }}>
            <thead>
              <tr>
                {['DESCRIÇÃO','QTDE','%'].map(h => <th key={h} style={{ background:C.blue, color:'white', padding:'3px 6px', fontWeight:700, fontSize:10 }}>{h}</th>)}
              </tr>
            </thead>
            <tbody>
              {[['VITÓRIAS','32','80'],['DERROTAS','8','20'],['TOTAL','40','100']].map(([d,q,p],i) => (
                <tr key={i} style={{ background: i===2 ? C.blue : 'transparent' }}>
                  <td style={{ padding:'3px 6px', color: i===2 ? 'white':'#555', fontWeight: i===2 ? 700:400 }}>{d}</td>
                  <td style={{ padding:'3px 6px', color: i===2 ? 'white':'#555', textAlign:'center', fontWeight: i===2 ? 700:400 }}>{q}</td>
                  <td style={{ padding:'3px 6px', color: i===2 ? 'white':'#555', textAlign:'center', fontWeight: i===2 ? 700:400 }}>{p}</td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        {/* Donut charts */}
        {[['BOLA DE FINALIZAÇÃO','GOLPE DE FINALIZAÇÃO']].map((labels,gi) => (
          <div key={gi} style={{ display:'flex', gap:10, alignItems:'center', padding:'6px 14px 10px', borderTop:'1px solid #f0f0f0' }}>
            <div>
              <p style={{ margin:'0 0 4px', color:C.blue, fontWeight:700, fontSize:11 }}>{labels[0]}</p>
              {[['SAQUE',80,'#aaa'],['PRIMEIRA BOLA',16,C.blue],['SEGUNDA BOLA',20,'#90C030'],['TERCEIRA BOLA',25,C.yellowBtn],['TROCAÇÃO',31,'#8B8B00']].map(([l,v,col])=>(
                <div key={l} style={{ display:'flex', alignItems:'center', gap:4, marginBottom:1 }}>
                  <div style={{ width:10, height:10, background:col, flexShrink:0 }}/>
                  <span style={{ fontSize:9, color:'#666' }}>{l}</span>
                  <span style={{ fontSize:9, color:'#666', marginLeft:'auto', paddingLeft:4 }}>{v}</span>
                </div>
              ))}
            </div>
            <div style={{ position:'relative', flexShrink:0 }}>
              <DonutChart segments={donutSegs} size={90}/>
              {[['16%',15,50],['25%',55,25],['8%',65,60],['31%',38,70],['20%',10,65]].map(([t,x,y])=>(
                <span key={t} style={{ position:'absolute', left:`${x}%`, top:`${y}%`, fontSize:9, fontWeight:700, color:'#333', transform:'translate(-50%,-50%)' }}>{t}</span>
              ))}
            </div>
          </div>
        ))}
        <div style={{ display:'flex', gap:10, alignItems:'center', padding:'6px 14px 10px', borderTop:'1px solid #f0f0f0' }}>
          <div style={{ position:'relative', flexShrink:0 }}>
            <DonutChart segments={donutSegs} size={90}/>
            {[['16%',15,50],['25%',55,25],['8%',65,60],['31%',38,70],['20%',10,65]].map(([t,x,y])=>(
              <span key={t} style={{ position:'absolute', left:`${x}%`, top:`${y}%`, fontSize:9, fontWeight:700, color:'#333', transform:'translate(-50%,-50%)' }}>{t}</span>
            ))}
          </div>
          <div>
            <p style={{ margin:'0 0 4px', color:C.blue, fontWeight:700, fontSize:11 }}>GOLPE DE FINALIZAÇÃO</p>
            {[['GOLPE 1',80,'#aaa'],['GOLPE 2',16,C.blue],['GOLPE 3',20,'#90C030'],['GOLPE 4',25,C.yellowBtn],['GOLPE 5',31,'#8B8B00']].map(([l,v,col])=>(
              <div key={l} style={{ display:'flex', alignItems:'center', gap:4, marginBottom:1 }}>
                <div style={{ width:10, height:10, background:col, flexShrink:0 }}/>
                <span style={{ fontSize:9, color:'#666' }}>{l}</span>
                <span style={{ fontSize:9, color:'#666', marginLeft:'auto', paddingLeft:8 }}>{v}</span>
              </div>
            ))}
          </div>
        </div>
        {title === 'MINHAS ESTATÍSTICAS' && (
          <div style={{ display:'flex', justifyContent:'center', padding:'8px 0' }}>
            <Btn onClick={() => navigate('atleta-duplas')} style={{ padding:'9px 28px', borderRadius:20 }}>MINHAS DUPLAS</Btn>
          </div>
        )}
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 12.1: Minhas Duplas list ─────────────────────────────
function AtletaDuplasScreen({ navigate, goBack }) {
  const duplas = ['Beltrano Lorem Ipsum','Ciclano Lorem Ipsum','Alfredo Lorem Ipsum','Antônio  Lorem Ipsum','Carlos  Lorem Ipsum','Eduardo Lorem Ipsum','Diogo  Lorem Ipsum','Marcos Jair de Aguiar','Renato dos Passos Rodrigues'];
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="FULANO DE TAL" onBack={goBack}>
        <ProfTecnicoNotifs />
      </ProfileHeader>
      <div style={{ flex:1, overflowY:'auto', background:'white' }}>
        <SectionTitle>MINHAS ESTATÍSTICAS EM DUPLAS</SectionTitle>
        <div style={{ display:'flex', padding:'4px 12px', borderBottom:'1px solid #e0e0e0' }}>
          <span style={{ flex:1, fontSize:11, color:'#999' }}>Nome ⇅</span>
          <span style={{ fontSize:11, color:'#999' }}>Ver</span>
        </div>
        {duplas.map((name, i) => (
          <div key={i} style={{ display:'flex', alignItems:'center', padding:'9px 12px', borderBottom:'1px solid #f0f0f0' }}>
            <span style={{ flex:1, color:C.blue, fontSize:13 }}>{name}</span>
            <button onClick={() => navigate('atleta-dupla-stats')} style={{ background:'none', border:'none', cursor:'pointer', padding:'0 4px' }}><EyeIcon color={C.blue}/></button>
          </div>
        ))}
        <div style={{ display:'flex', justifyContent:'center', padding:'16px 0' }}>
          <Btn style={{ padding:'9px 28px', borderRadius:20 }}>Novo Jogo</Btn>
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

Object.assign(window, {
  AtletaHomeScreen, AtletaJogosScreen, JogoModoScreen, JogoRegisterScreen,
  JogoPlacarScreen, AmigosScreen, AtletaStatsScreen, AtletaDuplasScreen,
});
