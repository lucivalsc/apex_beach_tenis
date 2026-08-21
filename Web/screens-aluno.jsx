// screens-aluno.jsx — Tela 5, 5.1, 5.2, 5.3, 5.4, 5.5

const treinoList = [
  { date:'26/10/2023', prof:'Fulano Silva dos Santos', status:true },
  { date:'26/10/2023', prof:'Fulano Silva dos Santos', status:'-' },
  { date:'26/10/2023', prof:'Fulano Silva dos Santos', status:'-' },
  { date:'26/10/2023', prof:'Fulano Silva dos Santos', status:true },
  { date:'26/10/2023', prof:'Fulano Silva dos Santos', status:true },
  { date:'26/10/2023', prof:'Fulano Silva dos Santos', status:true },
  { date:'26/10/2023', prof:'Fulano Silva dos Santos', status:'-' },
  { date:'26/10/2023', prof:'Fulano Silva dos Santos', status:true },
  { date:'26/10/2023', prof:'Fulano Silva dos Santos', status:'-' },
  { date:'26/10/2023', prof:'Fulano Silva dos Santos', status:true },
  { date:'26/10/2023', prof:'Fulano Silva dos Santos', status:true },
];

// ── Tela 5: Aluno Home ────────────────────────────────────────
function AlunoHomeScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="ALUNO: FULANO DE  TAL" onBack={goBack} />
      <div style={{ flex:1, background:'white', display:'flex', alignItems:'center', justifyContent:'center' }}>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:10, padding:'20px', maxWidth:320, width:'100%' }}>
          <GridBtn label={"MEUS\nTREINOS"} icon={<TreinoIcon/>} active={true} onClick={() => navigate('aluno-treinos')} />
          <GridBtn label={"MINHAS\nESTATÍSTICAS"} icon={<EstatisticasIcon/>} active={false} onClick={() => navigate('aluno-estatisticas')} />
          <GridBtn label={"MINHAS\nAVALIAÇÕES"} icon={<AvaliacaoIcon/>} active={false} onClick={() => navigate('aluno-avaliacoes')} />
          <GridBtn label={"EDITAR\nPERFIL"} icon={<EditarPerfilIcon/>} active={true} onClick={() => {}} />
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 5.1: Minhas Estatísticas (treino progress) ───────────
function AlunoEstatisticasScreen({ navigate, goBack }) {
  const treinos = [
    { name:'Treino 1', desc:'Abaixo você tem a estatística do percen-tual de acertos do treino 1', pct:88 },
    { name:'Treino 2', desc:'Abaixo você tem a estatística do percen-tual de acertos do treino 2', pct:88 },
    { name:'Treino 3', desc:'Abaixo você tem a estatística do percen-tual de acertos do treino 3', pct:88 },
    { name:'Treino 4', desc:'Abaixo você tem a estatística do percen-tual de acertos do treino 4', pct:88 },
  ];
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="ALUNO: FULANO DE  TAL" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white', padding:'16px 14px' }}>
        <SectionTitle>MINHAS ESTATÍSTICAS</SectionTitle>
        <div style={{ height:12 }} />
        {treinos.map((t, i) => (
          <div key={i} style={{ display:'flex', gap:12, alignItems:'center', marginBottom:14, cursor:'pointer' }}>
            <div style={{ width:72, height:72, background:C.blue, borderRadius:8, display:'flex', alignItems:'center', justifyContent:'center', flexShrink:0 }}>
              <svg width="32" height="28" viewBox="0 0 32 28" fill="none"><rect x="1" y="1" width="30" height="22" rx="2" stroke="white" strokeWidth="1.5"/><circle cx="16" cy="12" r="5" stroke="white" strokeWidth="1.5"/></svg>
            </div>
            <div style={{ flex:1 }}>
              <p style={{ margin:'0 0 4px', fontSize:14, fontWeight:600, color:'#333' }}>{t.name}</p>
              <p style={{ margin:'0 0 6px', fontSize:11, color:'#999', lineHeight:'1.4' }}>{t.desc}</p>
              <div style={{ position:'relative', height:12, background:'#e0e0e0', borderRadius:6, overflow:'visible' }}>
                <div style={{ position:'absolute', left:0, top:0, bottom:0, width:`${t.pct}%`, background:C.blue, borderRadius:6 }}>
                  <div style={{ position:'absolute', right:-10, top:'50%', transform:'translateY(-50%)', background:C.yellowBtn, borderRadius:'50%', width:22, height:22, display:'flex', alignItems:'center', justifyContent:'center', fontSize:9, fontWeight:'bold', color:'#333' }}>{t.pct}%</div>
                </div>
              </div>
            </div>
          </div>
        ))}
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 5.2: Minhas Avaliações list ──────────────────────────
function AlunoAvaliacoesScreen({ navigate, goBack }) {
  const [showDetail, setShowDetail] = React.useState(false);
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%', position:'relative' }}>
      <ProfileHeader name="ALUNO: FULANO DE  TAL" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white' }}>
        <div style={{ height:16 }} />
        <SectionTitle>MINHAS AVALIAÇÕES</SectionTitle>
        <div style={{ display:'flex', padding:'4px 12px', borderBottom:'1px solid #e0e0e0', gap:4 }}>
          <span style={{ flex:'0 0 80px', fontSize:11, color:'#999' }}>Data ⇅</span>
          <span style={{ flex:1, fontSize:11, color:'#999' }}>Aluno ⇅</span>
          <span style={{ fontSize:11, color:'#999', marginRight:18 }}>Ver</span>
          <span style={{ fontSize:11, color:'#999' }}>Status</span>
        </div>
        {treinoList.map((row, i) => (
          <div key={i} style={{ display:'flex', alignItems:'center', padding:'7px 12px', borderBottom:'1px solid #f0f0f0', gap:4 }}>
            <span style={{ flex:'0 0 80px', fontSize:12, color:C.blue }}>{row.date}</span>
            <span style={{ flex:1, fontSize:12, color:C.blue }}>Fulano Silva dos Santos</span>
            <button onClick={() => setShowDetail(true)} style={{ background:'none', border:'none', cursor:'pointer', padding:'0 4px', marginRight:8 }}><EyeIcon color={C.blue}/></button>
            {row.status === true && <span style={{ color:C.green, fontSize:15 }}>✓</span>}
            {row.status === '-' && <span style={{ color:'#bbb', fontSize:15 }}>-</span>}
          </div>
        ))}
      </div>
      <BottomBar />
      {showDetail && <AvaliacaoDetailModal onClose={() => setShowDetail(false)} />}
    </div>
  );
}

// ── Tela 5.3: Avaliação Detail modal ──────────────────────────
function AvaliacaoDetailModal({ onClose }) {
  return (
    <Modal title="AVALIAÇÃO DE  XX/XX/XXXX" onClose={onClose}>
      <div style={{ display:'flex', flexDirection:'column', gap:8 }}>
        {['ITEM 1','ITEM 2','ITEM 3','ITEM 4','ITEM 5'].map((item, i) => (
          <div key={i} style={{ display:'flex', gap:6, alignItems:'center' }}>
            <div style={{ background:'#EBEBEB', borderRadius:20, padding:'7px 12px', flex:1, fontSize:11, color:'#888' }}>{item}</div>
            <div style={{ background:'#EBEBEB', borderRadius:20, padding:'7px 12px', flex:'0 0 auto', fontSize:11, color:'#888' }}>Previsto</div>
            <div style={{ background:'#EBEBEB', borderRadius:20, padding:'7px 8px', flex:'0 0 auto', fontSize:10, color:'#888', textAlign:'center', lineHeight:'1.2' }}>Executado<br/>Acertos</div>
          </div>
        ))}
        <div style={{ display:'flex', gap:10, justifyContent:'center', marginTop:8 }}>
          <Btn color={C.yellowBtn} textColor="#333" style={{ padding:'9px 14px', fontSize:12 }}>PROFESSOR<br/>FULANO DE TAL</Btn>
          <Btn style={{ padding:'9px 20px', fontSize:12 }}>APROVADO(A)</Btn>
        </div>
      </div>
    </Modal>
  );
}

// ── Tela 5.4: Meus Treinos list ───────────────────────────────
function AlunoTreinosScreen({ navigate, goBack }) {
  const [showDetail, setShowDetail] = React.useState(false);
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%', position:'relative' }}>
      <ProfileHeader name="ALUNO: FULANO DE  TAL" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white' }}>
        <SectionTitle>MEUS TREINOS</SectionTitle>
        <div style={{ display:'flex', padding:'4px 12px', borderBottom:'1px solid #e0e0e0', gap:4 }}>
          <span style={{ flex:'0 0 80px', fontSize:11, color:'#999' }}>Data ⇅</span>
          <span style={{ flex:1, fontSize:11, color:'#999' }}>Professor ⇅</span>
          <span style={{ fontSize:11, color:'#999', marginRight:14 }}>Ver</span>
          <span style={{ fontSize:11, color:'#999', marginRight:14 }}>Editar</span>
          <span style={{ fontSize:11, color:'#999' }}>Status</span>
        </div>
        {treinoList.map((row, i) => (
          <div key={i} style={{ display:'flex', alignItems:'center', padding:'7px 12px', borderBottom:'1px solid #f0f0f0', gap:4 }}>
            <span style={{ flex:'0 0 80px', fontSize:12, color:C.blue }}>{row.date}</span>
            <span style={{ flex:1, fontSize:12, color:C.blue }}>{row.prof}</span>
            <button onClick={() => setShowDetail(true)} style={{ background:'none', border:'none', cursor:'pointer', padding:'0 3px', marginRight:4 }}><EyeIcon color={C.blue}/></button>
            <button style={{ background:'none', border:'none', cursor:'pointer', padding:'0 3px', marginRight:4 }}><EditIcon color={C.yellowBtn}/></button>
            {row.status === true && <span style={{ color:C.green, fontSize:15 }}>✓</span>}
            {row.status === '-' && <span style={{ color:'#bbb', fontSize:15 }}>-</span>}
          </div>
        ))}
      </div>
      <BottomBar />
      {showDetail && <TreinoDetailModal onClose={() => setShowDetail(false)} />}
    </div>
  );
}

// ── Tela 5.5: Treino Detail modal ─────────────────────────────
function TreinoDetailModal({ onClose }) {
  return (
    <Modal title="TREINO DIA 26/10/2023" onClose={null}>
      <div style={{ display:'flex', flexDirection:'column', gap:10 }}>
        <div style={{ background:'#EBEBEB', borderRadius:20, padding:'9px 14px', fontSize:12, color:'#555' }}>Professor: FULANO SILVA DOS SANTOS</div>
        <div style={{ display:'grid', gridTemplateColumns:'1fr auto auto', gap:6, alignItems:'center' }}>
          <span style={{ fontSize:11, color:'#999' }}>Descrição</span>
          <span style={{ fontSize:11, color:'#999', paddingRight:8 }}>Previsto</span>
          <span style={{ fontSize:11, color:'#999' }}>Êxito</span>
          {['Item de treino 1','Item de treino 2','Item de treino 3'].map((item, i) => (
            <React.Fragment key={i}>
              <div style={{ background:'#EBEBEB', borderRadius:20, padding:'8px 12px', fontSize:11, color:'#888' }}>{item}</div>
              <div style={{ background:'#EBEBEB', borderRadius:20, padding:'8px 10px', fontSize:12, color:'#555', textAlign:'center' }}>20</div>
              <div style={{ background:'#EBEBEB', borderRadius:20, padding:'8px 10px', fontSize:12, color:'#555', textAlign:'center' }}>10</div>
            </React.Fragment>
          ))}
        </div>
        <div style={{ display:'flex', gap:10, justifyContent:'center', marginTop:4 }}>
          <Btn style={{ padding:'9px 24px' }}>Salvar</Btn>
          <Btn color={C.yellowBtn} textColor="#333" onClick={onClose} style={{ padding:'9px 20px' }}>Fechar</Btn>
        </div>
      </div>
    </Modal>
  );
}

Object.assign(window, { AlunoHomeScreen, AlunoEstatisticasScreen, AlunoAvaliacoesScreen, AlunoTreinosScreen });
