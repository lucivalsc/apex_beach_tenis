// screens-profissional.jsx — Tela 6 (Prof Técnico Home), 6.1 (Atletas), 6.2 (Jogos do Atleta)

const solicitacoes = [
  { name:'Pulano Campos Silva' },
  { name:'Pulano Campos Silva' },
  { name:'Pulano Campos Silva' },
];

const atletasList = [
  'Fulano Silva dos Santos','Atleta 2','Atleta 3','Atleta 4','Atleta 5',
  'Atleta 6','Atleta 7','Atleta 8','Atleta 9','Atleta 10',
  'Atleta 11','Atleta 12','Atleta 13',
];

const jogosList = [
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

// ── Tela 6: Profissional Técnico Home ────────────────────────
function ProfissionalHomeScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="FULANO DE TAL" onBack={goBack}>
        <ProfTecnicoNotifs />
      </ProfileHeader>
      <div style={{ flex:1, overflowY:'auto', background:'white', padding:'12px 14px' }}>
        {/* Solicitações */}
        <SectionTitle>NOVAS SOLICITAÇÕES</SectionTitle>
        {solicitacoes.map((s, i) => (
          <div key={i} style={{ display:'flex', alignItems:'center', padding:'8px 12px', borderBottom:'1px solid #f0f0f0', gap:8 }}>
            <div style={{ width:30, height:30, borderRadius:6, background:C.blue, display:'flex', alignItems:'center', justifyContent:'center', flexShrink:0 }}>
              <svg width="18" height="18" viewBox="0 0 18 18" fill="none"><rect x="1" y="1" width="16" height="16" rx="3" stroke="white" strokeWidth="1.5"/><circle cx="9" cy="7" r="2" stroke="white" strokeWidth="1.5"/><path d="M3.5 15c0-3 2.5-4.5 5.5-4.5s5.5 1.5 5.5 4.5" stroke="white" strokeWidth="1.5"/></svg>
            </div>
            <span style={{ flex:1, color:C.blue, fontSize:13 }}>{s.name}</span>
            <span style={{ color:C.green, fontSize:18, cursor:'pointer' }}>✓</span>
            <span style={{ color:C.red, fontSize:18, cursor:'pointer', marginLeft:6 }}>✗</span>
          </div>
        ))}
        {/* Grid buttons */}
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:10, marginTop:16, maxWidth:320, margin:'16px auto 0' }}>
          <GridBtn label="ATLETAS" icon={<AtletaIcon/>} active={true} onClick={() => navigate('profissional-atletas')} />
          <GridBtn label={"ADICIONAR\nJOGO"} icon={<AdicionarJogoIcon/>} active={false} onClick={() => navigate('jogo-modo')} />
          <GridBtn label={"EDITAR\nPERFIL"} icon={<EditarPerfilIcon/>} active={false} onClick={() => {}} />
          <GridBtn label={"ALTERNAR\nPERFIL"} icon={<AlternarPerfilIcon/>} active={true} onClick={() => navigate('profile-select')} />
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 6.1: Meus Atletas list ───────────────────────────────
function ProfissionalAtletasScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="FULANO DE TAL" onBack={goBack}>
        <ProfTecnicoNotifs />
      </ProfileHeader>
      <div style={{ flex:1, overflowY:'auto', background:'white' }}>
        <div style={{ height:8 }} />
        <SectionTitle>MEUS ATLETAS</SectionTitle>
        <div style={{ display:'flex', padding:'4px 12px', borderBottom:'1px solid #e0e0e0' }}>
          <span style={{ flex:1, fontSize:11, color:'#999' }}>Nome ⇅</span>
          <span style={{ fontSize:11, color:'#999', marginRight:22 }}>Jogos</span>
          <span style={{ fontSize:11, color:'#999' }}>Remover</span>
        </div>
        {atletasList.map((name, i) => (
          <div key={i} style={{ display:'flex', alignItems:'center', padding:'8px 12px', borderBottom:'1px solid #f0f0f0', gap:4 }}>
            <span style={{ flex:1, color:C.blue, fontSize:13 }}>{name}</span>
            <button onClick={() => navigate('profissional-jogos')} style={{ background:'none', border:'none', cursor:'pointer', padding:'0 4px', marginRight:6 }}><EyeIcon color={C.blue}/></button>
            <button style={{ background:'none', border:'none', cursor:'pointer', padding:'0 4px', marginRight:6 }}>
              <span style={{ color:C.blue, fontSize:18, fontWeight:'bold', lineHeight:1 }}>+</span>
            </button>
            <span style={{ color:C.red, fontSize:18, cursor:'pointer' }}>✗</span>
          </div>
        ))}
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 6.2: Jogos do Atleta ─────────────────────────────────
function ProfissionalJogosScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="FULANO DE TAL" onBack={goBack}>
        <ProfTecnicoNotifs />
      </ProfileHeader>
      <div style={{ flex:1, overflowY:'auto', background:'white' }}>
        <SectionTitle>ATLETA FULANO SILVA DOS SANTOS</SectionTitle>
        <div style={{ display:'flex', padding:'4px 12px', borderBottom:'1px solid #e0e0e0', gap:4 }}>
          <span style={{ flex:'0 0 80px', fontSize:11, color:'#999' }}>Data ⇅</span>
          <span style={{ flex:1, fontSize:11, color:'#999' }}>Jogo ⇅</span>
          <span style={{ fontSize:11, color:'#999', marginRight:14 }}>Ver</span>
          <span style={{ fontSize:11, color:'#999', marginRight:14 }}>Editar</span>
          <span style={{ fontSize:11, color:'#999' }}>Status</span>
        </div>
        {jogosList.map((row, i) => (
          <div key={i} style={{ display:'flex', alignItems:'center', padding:'7px 12px', borderBottom:'1px solid #f0f0f0', gap:4 }}>
            <span style={{ flex:'0 0 80px', fontSize:12, color:C.blue }}>{row.date}</span>
            <span style={{ flex:1, fontSize:12, color:C.blue }}>{row.jogo}</span>
            <button style={{ background:'none', border:'none', cursor:'pointer', padding:'0 3px', marginRight:4 }}><EyeIcon color={C.blue}/></button>
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

Object.assign(window, { ProfissionalHomeScreen, ProfissionalAtletasScreen, ProfissionalJogosScreen });
