// screens-professor.jsx — Tela 4 (Prof Home), 4.1 (Arenas), 4.2 (Avaliações), 4.3 (Add Aval), 4.4 (Treinos), 4.5 (Add Treino)

const avalList = [
  { date:'26/10/2023', name:'Fulano Silva dos Santos', status:true },
  { date:'26/10/2023', name:'Fulano Silva dos Santos', status:'-' },
  { date:'26/10/2023', name:'Fulano Silva dos Santos', status:'-' },
  { date:'26/10/2023', name:'Fulano Silva dos Santos', status:true },
  { date:'26/10/2023', name:'Fulano Silva dos Santos', status:true },
  { date:'26/10/2023', name:'Fulano Silva dos Santos', status:true },
  { date:'26/10/2023', name:'Fulano Silva dos Santos', status:'-' },
  { date:'26/10/2023', name:'Fulano Silva dos Santos', status:true },
  { date:'26/10/2023', name:'Fulano Silva dos Santos', status:'-' },
  { date:'26/10/2023', name:'Fulano Silva dos Santos', status:true },
  { date:'26/10/2023', name:'Fulano Silva dos Santos', status:true },
];

// ── Tela 4: Professor Home ────────────────────────────────────
function ProfessorHomeScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="PROF.: FULANO DE  TAL" onBack={goBack} />
      <div style={{ flex:1, background:'white', display:'flex', alignItems:'center', justifyContent:'center' }}>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:10, padding:'20px', maxWidth:320, width:'100%' }}>
          <GridBtn label={"MEUS\nTREINOS"} icon={<TreinoIcon/>} active={true} onClick={() => navigate('professor-treinos')} />
          <GridBtn label="ARENAs" icon={<ArenaIcon/>} active={false} onClick={() => navigate('professor-arenas')} />
          <GridBtn label="AVALIAÇÕES" icon={<AvaliacaoIcon/>} active={false} onClick={() => navigate('professor-avaliacoes')} />
          <GridBtn label={"EDITAR\nPERFIL"} icon={<EditarPerfilIcon/>} active={true} onClick={() => {}} />
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 4.1: Select Arena (multi-arena professor) ────────────
function ProfessorArenasScreen({ navigate, goBack }) {
  const arenas = [
    { name:'Arena 01', pct:88 },
    { name:'Arena 02', pct:88 },
    { name:'Arena 03', pct:88 },
    { name:'Arena 04', pct:88 },
  ];
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="PROF.: FULANO DE  TAL" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white', padding:'16px 14px' }}>
        <p style={{ textAlign:'center', color:C.blueDark, fontWeight:800, fontSize:13, marginBottom:16, padding:'0 20px' }}>
          Selecione a Arena que você quer administrar os treinos e avaliações
        </p>
        {arenas.map((a, i) => (
          <div key={i} onClick={() => navigate('professor-avaliacoes')} style={{ display:'flex', gap:12, alignItems:'center', marginBottom:14, cursor:'pointer' }}>
            <div style={{ width:72, height:72, background:C.blue, borderRadius:8, display:'flex', alignItems:'center', justifyContent:'center', flexShrink:0 }}>
              <svg width="32" height="28" viewBox="0 0 32 28" fill="none">
                <rect x="1" y="1" width="30" height="22" rx="2" stroke="white" strokeWidth="1.5"/>
                <circle cx="16" cy="12" r="5" stroke="white" strokeWidth="1.5"/>
              </svg>
            </div>
            <div style={{ flex:1 }}>
              <p style={{ margin:'0 0 4px', fontSize:14, fontWeight:600, color:'#333' }}>{a.name}</p>
              <p style={{ margin:'0 0 6px', fontSize:11, color:'#999', lineHeight:'1.4' }}>Abaixo você tem a estatística do percen-tual de treinos executados</p>
              <div style={{ position:'relative', height:12, background:'#e0e0e0', borderRadius:6, overflow:'visible' }}>
                <div style={{ position:'absolute', left:0, top:0, bottom:0, width:`${a.pct}%`, background:C.blue, borderRadius:6 }}>
                  <div style={{ position:'absolute', right:-10, top:'50%', transform:'translateY(-50%)', background:C.yellowBtn, borderRadius:'50%', width:22, height:22, display:'flex', alignItems:'center', justifyContent:'center', fontSize:9, fontWeight:'bold', color:'#333', whiteSpace:'nowrap' }}>{a.pct}%</div>
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

// ── Tela 4.2: Avaliações list ─────────────────────────────────
function ProfessorAvaliacoesScreen({ navigate, goBack }) {
  const [showModal, setShowModal] = React.useState(false);
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%', position:'relative' }}>
      <ProfileHeader name="PROF.: FULANO DE  TAL" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white' }}>
        <div style={{ display:'flex', gap:8, padding:'8px 12px' }}>
          <div style={{ display:'flex', alignItems:'center', background:'#EBEBEB', borderRadius:20, padding:'7px 10px', gap:4, flex:'0 0 auto', minWidth:120 }}>
            <span style={{ fontSize:11, color:'#aaa' }}>▼</span>
            <span style={{ fontSize:11, color:'#888' }}>Selecionar a Arena</span>
          </div>
          <div style={{ flex:1, display:'flex', alignItems:'center', background:'#EBEBEB', borderRadius:20, padding:'7px 10px', gap:4 }}>
            <svg width="13" height="13" viewBox="0 0 14 14" fill="none"><circle cx="6" cy="6" r="5" stroke="#aaa" strokeWidth="1.5"/><line x1="10" y1="10" x2="13" y2="13" stroke="#aaa" strokeWidth="1.5" strokeLinecap="round"/></svg>
            <span style={{ fontSize:11, color:'#888' }}>Buscar aluno</span>
          </div>
          <button onClick={() => setShowModal(true)} style={{ background:'none', border:'none', cursor:'pointer', color:C.blue, fontSize:24, fontWeight:'bold', padding:'0 4px' }}>+</button>
        </div>
        <SectionTitle>AVALIAÇÕES CONFIGURADAS</SectionTitle>
        <div style={{ display:'flex', padding:'4px 12px', borderBottom:'1px solid #e0e0e0', gap:4 }}>
          <span style={{ flex:'0 0 80px', fontSize:11, color:'#999' }}>Data ⇅</span>
          <span style={{ flex:1, fontSize:11, color:'#999' }}>Aluno ⇅</span>
          <span style={{ fontSize:11, color:'#999', marginRight:18 }}>Ver</span>
          <span style={{ fontSize:11, color:'#999', marginRight:18 }}>Editar</span>
          <span style={{ fontSize:11, color:'#999' }}>Status</span>
        </div>
        {avalList.map((row, i) => (
          <div key={i} style={{ display:'flex', alignItems:'center', padding:'7px 12px', borderBottom:'1px solid #f0f0f0', gap:4 }}>
            <span style={{ flex:'0 0 80px', fontSize:12, color:C.blue }}>{row.date}</span>
            <span style={{ flex:1, fontSize:12, color:C.blue }}>{row.name}</span>
            <button style={{ background:'none', border:'none', cursor:'pointer', padding:'0 4px', marginRight:4 }}><EyeIcon color={C.blue}/></button>
            <button style={{ background:'none', border:'none', cursor:'pointer', padding:'0 4px', marginRight:4 }}><EditIcon color={C.yellowBtn}/></button>
            {row.status === true && <span style={{ color:C.green, fontSize:15 }}>✓</span>}
            {row.status === '-' && <span style={{ color:'#bbb', fontSize:15 }}>-</span>}
          </div>
        ))}
      </div>
      <BottomBar />
      {showModal && <AddAvaliacaoModal onClose={() => setShowModal(false)} />}
    </div>
  );
}

// ── Tela 4.3: Add Avaliação modal ─────────────────────────────
function AddAvaliacaoModal({ onClose }) {
  return (
    <Modal title="CADASTRAR AVALIAÇÃO" onClose={onClose}>
      <div style={{ display:'flex', flexDirection:'column', gap:9 }}>
        <PillInput placeholder="Digite o Nome do aluno (instrução abaixo)" />
        {[1,2,3].map(n => (
          <div key={n} style={{ display:'flex', gap:6, alignItems:'center' }}>
            <div style={{ display:'flex', alignItems:'center', gap:4, flex:'0 0 auto', background:'#EBEBEB', borderRadius:20, padding:'7px 10px' }}>
              <span style={{ fontSize:10, color:'#aaa' }}>▼</span>
              <span style={{ fontSize:11, color:'#888' }}>Item {n}</span>
            </div>
            <PillInput placeholder="Previsto" style={{ flex:1 }} />
            <div style={{ background:'#EBEBEB', borderRadius:20, padding:'7px 8px', flex:'0 0 auto', fontSize:10, color:'#888', textAlign:'center', lineHeight:'1.2' }}>Executado<br/>Acertos</div>
          </div>
        ))}
        <p style={{ textAlign:'center', margin:'2px 0', fontSize:11, color:'#888', cursor:'pointer' }}>+ ADICIONAR MAIS ITEM +</p>
        <div style={{ display:'flex', alignItems:'center', gap:4, background:'#EBEBEB', borderRadius:20, padding:'7px 10px' }}>
          <span style={{ fontSize:11, color:'#aaa' }}>▼</span>
          <span style={{ fontSize:11, color:'#888' }}>Resultado da Avaliação</span>
        </div>
        <div style={{ display:'flex', gap:10, justifyContent:'center', marginTop:4 }}>
          <Btn style={{ padding:'9px 24px' }}>Salvar</Btn>
          <Btn color={C.yellowBtn} textColor="#333" onClick={onClose} style={{ padding:'9px 20px' }}>Cancelar</Btn>
        </div>
      </div>
    </Modal>
  );
}

// ── Tela 4.4: Treinos list ────────────────────────────────────
function ProfessorTreinosScreen({ navigate, goBack }) {
  const [showModal, setShowModal] = React.useState(false);
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%', position:'relative' }}>
      <ProfileHeader name="PROF.: FULANO DE  TAL" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white' }}>
        <div style={{ display:'flex', gap:8, padding:'8px 12px' }}>
          <div style={{ display:'flex', alignItems:'center', background:'#EBEBEB', borderRadius:20, padding:'7px 10px', gap:4, flex:'0 0 auto', minWidth:120 }}>
            <span style={{ fontSize:11, color:'#aaa' }}>▼</span>
            <span style={{ fontSize:11, color:'#888' }}>Selecionar a Arena</span>
          </div>
          <div style={{ flex:1, display:'flex', alignItems:'center', background:'#EBEBEB', borderRadius:20, padding:'7px 10px', gap:4 }}>
            <svg width="13" height="13" viewBox="0 0 14 14" fill="none"><circle cx="6" cy="6" r="5" stroke="#aaa" strokeWidth="1.5"/><line x1="10" y1="10" x2="13" y2="13" stroke="#aaa" strokeWidth="1.5" strokeLinecap="round"/></svg>
            <span style={{ fontSize:11, color:'#888' }}>Buscar aluno</span>
          </div>
          <button onClick={() => setShowModal(true)} style={{ background:'none', border:'none', cursor:'pointer', color:C.blue, fontSize:24, fontWeight:'bold', padding:'0 4px' }}>+</button>
        </div>
        <SectionTitle>TREINOS CONFIGURADOS</SectionTitle>
        <div style={{ display:'flex', padding:'4px 12px', borderBottom:'1px solid #e0e0e0', gap:4 }}>
          <span style={{ flex:'0 0 80px', fontSize:11, color:'#999' }}>Data ⇅</span>
          <span style={{ flex:1, fontSize:11, color:'#999' }}>Aluno ⇅</span>
          <span style={{ fontSize:11, color:'#999', marginRight:18 }}>Ver</span>
          <span style={{ fontSize:11, color:'#999', marginRight:18 }}>Editar</span>
          <span style={{ fontSize:11, color:'#999' }}>Status</span>
        </div>
        {avalList.map((row, i) => (
          <div key={i} style={{ display:'flex', alignItems:'center', padding:'7px 12px', borderBottom:'1px solid #f0f0f0', gap:4 }}>
            <span style={{ flex:'0 0 80px', fontSize:12, color:C.blue }}>{row.date}</span>
            <span style={{ flex:1, fontSize:12, color:C.blue }}>{row.name}</span>
            <button style={{ background:'none', border:'none', cursor:'pointer', padding:'0 4px', marginRight:4 }}><EyeIcon color={C.blue}/></button>
            <button style={{ background:'none', border:'none', cursor:'pointer', padding:'0 4px', marginRight:4 }}><EditIcon color={C.yellowBtn}/></button>
            {row.status === true && <span style={{ color:C.green, fontSize:15 }}>✓</span>}
            {row.status === '-' && <span style={{ color:'#bbb', fontSize:15 }}>-</span>}
          </div>
        ))}
      </div>
      <BottomBar />
      {showModal && <AddTreinoModal onClose={() => setShowModal(false)} />}
    </div>
  );
}

// ── Tela 4.5: Add Treino modal ────────────────────────────────
function AddTreinoModal({ onClose }) {
  return (
    <Modal title="CADASTRAR TREINO" onClose={onClose}>
      <div style={{ display:'flex', flexDirection:'column', gap:9 }}>
        <PillInput placeholder="Digite o Nome do aluno (instrução abaixo)" />
        <div style={{ display:'flex', gap:8, alignItems:'center' }}>
          <div style={{ display:'flex', alignItems:'center', gap:4, background:C.blue, borderRadius:20, padding:'8px 12px', flex:'0 0 auto' }}>
            <span style={{ fontSize:11, color:'#aaa' }}>▼</span>
            <span style={{ fontSize:11, color:'white', fontWeight:600 }}>Selecione o nível</span>
          </div>
          <p style={{ margin:0, fontSize:10, color:'#888', flex:1, lineHeight:'1.3' }}>Caso queira poderá escolher um treino pré-configurado conforme o nível desejado</p>
        </div>
        <p style={{ textAlign:'center', margin:'2px 0', fontSize:11, color:'#888', cursor:'pointer' }}>+ ADICIONAR MAIS ITEM +</p>
        {[1,2,3].map(n => (
          <div key={n} style={{ display:'flex', gap:6, alignItems:'center' }}>
            <div style={{ display:'flex', alignItems:'center', gap:4, flex:'0 0 auto', background:'#EBEBEB', borderRadius:20, padding:'7px 10px' }}>
              <span style={{ fontSize:10, color:'#aaa' }}>▼</span>
              <span style={{ fontSize:11, color:'#888' }}>Item {n}</span>
            </div>
            <PillInput placeholder="Previsto" style={{ flex:1 }} />
            <div style={{ background:'#EBEBEB', borderRadius:20, padding:'7px 8px', flex:'0 0 auto', fontSize:10, color:'#888', textAlign:'center', lineHeight:'1.2' }}>Executado<br/>Acertos</div>
          </div>
        ))}
        <div style={{ display:'flex', gap:10, justifyContent:'center', marginTop:4 }}>
          <Btn style={{ padding:'9px 24px' }}>Salvar</Btn>
          <Btn color={C.yellowBtn} textColor="#333" onClick={onClose} style={{ padding:'9px 20px' }}>Cancelar</Btn>
        </div>
      </div>
    </Modal>
  );
}

Object.assign(window, { ProfessorHomeScreen, ProfessorArenasScreen, ProfessorAvaliacoesScreen, ProfessorTreinosScreen });
