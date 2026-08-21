// screens-arena.jsx — Tela 3 (Arena Home), 3.1 (Professores), 3.2 (Add Prof), 3.3 (Alunos)

const professorList = [
  { name:'Fulano Silva dos Santos', status:true },
  { name:'Gulano Oliveira dos Santos', status:false },
  { name:'Hulano Ribeiro', status:false },
  { name:'Julano Antônio Alves', status:true },
  { name:'Lulano Silva Souza', status:true },
  { name:'Mulano da Silveira', status:false },
  { name:'Nulano Aparecido Mota', status:false },
  { name:'Pulano Campos Silva', status:false },
  { name:'Rulano Duarte', status:true },
  { name:'Sulano Beraldo Borba', status:true },
  { name:'Tulano Cacildo Costa', status:true },
];

// ── Tela 3: Arena Home ────────────────────────────────────────
function ArenaHomeScreen({ navigate, goBack }) {
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%' }}>
      <ProfileHeader name="ARENA TAL" onBack={goBack} />
      <div style={{ flex:1, background:'white', display:'flex', alignItems:'center', justifyContent:'center' }}>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:10, padding:'20px', maxWidth:320, width:'100%' }}>
          <GridBtn label="PROFESSOR" icon={<ProfessorIcon/>} active={true} onClick={() => navigate('arena-professores')} />
          <GridBtn label="ALUNO" icon={<AlunoIcon/>} active={false} onClick={() => navigate('arena-alunos')} />
          <GridBtn label="EDITAR\nPERFIL" icon={<EditarPerfilIcon/>} active={false} onClick={() => {}} />
          <GridBtn label="ALTERNAR\nPERFIL" icon={<AlternarPerfilIcon/>} active={true} onClick={() => navigate('profile-select')} />
        </div>
      </div>
      <BottomBar />
    </div>
  );
}

// ── Tela 3.1: Professores list ────────────────────────────────
function ArenaProfessoresScreen({ navigate, goBack }) {
  const [showModal, setShowModal] = React.useState(false);
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%', position:'relative' }}>
      <ProfileHeader name="ARENA TAL" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white' }}>
        <SearchBar placeholder="Buscar professor" onPlus={() => setShowModal(true)} />
        <div style={{ display:'flex', alignItems:'center', justifyContent:'flex-end', padding:'0 12px 6px' }}>
          <label style={{ display:'flex', alignItems:'center', gap:4, fontSize:11, color:'#888' }}>
            <input type="checkbox" style={{ margin:0 }} /> Mostrar inativos?
          </label>
        </div>
        <SectionTitle>MEUS PROFESSORES</SectionTitle>
        <div style={{ display:'flex', padding:'4px 12px', borderBottom:'1px solid #e0e0e0' }}>
          <span style={{ flex:1, fontSize:11, color:'#999' }}>Nome ⇅</span>
          <span style={{ fontSize:11, color:'#999', marginRight:24 }}>Editar</span>
          <span style={{ fontSize:11, color:'#999' }}>On/Off</span>
        </div>
        {professorList.map((p, i) => (
          <ListRow key={i} name={p.name} status={p.status} canEdit={true} canView={false} />
        ))}
      </div>
      <BottomBar />
      {showModal && <AddProfessorModal onClose={() => setShowModal(false)} />}
    </div>
  );
}

// ── Tela 3.2: Add Professor modal ─────────────────────────────
function AddProfessorModal({ onClose }) {
  return (
    <Modal title="CADASTRAR PROFESSOR" onClose={onClose}>
      <div style={{ display:'flex', flexDirection:'column', gap:9 }}>
        <PillInput placeholder="Digite o Nome (instrução abaixo)" />
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8 }}>
          <div style={{ display:'flex', alignItems:'center', gap:5 }}>
            <span style={{ fontSize:12 }}>📅</span>
            <PillInput placeholder="Data de nascimento" style={{ flex:1 }} />
          </div>
          <div style={{ display:'flex', alignItems:'center', gap:5 }}>
            <span style={{ fontSize:11, color:'#aaa' }}>▼</span>
            <PillInput placeholder="Sexo" style={{ flex:1 }} />
          </div>
        </div>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8 }}>
          <PillInput placeholder="CPF" />
          <PillInput placeholder="E-mail" />
        </div>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8 }}>
          <PillInput placeholder="Telefone" />
          <label style={{ display:'flex', alignItems:'center', gap:4, fontSize:11, color:'#666' }}>
            <input type="checkbox" style={{ margin:0 }} /> É WhatsApp?
          </label>
        </div>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8 }}>
          <PillInput placeholder="Instagram" />
          <PillInput placeholder="Facebook" />
        </div>
        <div style={{ display:'flex', gap:10, justifyContent:'center', marginTop:6 }}>
          <Btn style={{ padding:'9px 24px' }}>Salvar</Btn>
          <Btn color={C.yellowBtn} textColor="#333" onClick={onClose} style={{ padding:'9px 20px' }}>Cancelar</Btn>
        </div>
      </div>
    </Modal>
  );
}

// ── Tela 3.3: Alunos list ─────────────────────────────────────
function ArenaAlunosScreen({ navigate, goBack }) {
  const [showModal, setShowModal] = React.useState(false);
  return (
    <div style={{ display:'flex', flexDirection:'column', height:'100%', position:'relative' }}>
      <ProfileHeader name="ARENA TAL" onBack={goBack} />
      <div style={{ flex:1, overflowY:'auto', background:'white' }}>
        <SearchBar placeholder="Buscar aluno" onPlus={() => setShowModal(true)} />
        <div style={{ display:'flex', alignItems:'center', justifyContent:'flex-end', padding:'0 12px 6px' }}>
          <label style={{ display:'flex', alignItems:'center', gap:4, fontSize:11, color:'#888' }}>
            <input type="checkbox" style={{ margin:0 }} /> Mostrar inativos?
          </label>
        </div>
        <SectionTitle>MEUS ALUNOS</SectionTitle>
        <div style={{ display:'flex', padding:'4px 12px', borderBottom:'1px solid #e0e0e0' }}>
          <span style={{ flex:1, fontSize:11, color:'#999' }}>Nome ⇅</span>
          <span style={{ fontSize:11, color:'#999', marginRight:24 }}>Editar</span>
          <span style={{ fontSize:11, color:'#999' }}>On/Off</span>
        </div>
        {professorList.map((p, i) => (
          <ListRow key={i} name={p.name} status={p.status} canEdit={true} canView={false} />
        ))}
      </div>
      <BottomBar />
      {showModal && <AddAlunoModal onClose={() => setShowModal(false)} />}
    </div>
  );
}

// ── Add Aluno modal ───────────────────────────────────────────
function AddAlunoModal({ onClose }) {
  return (
    <Modal title="CADASTRAR ALUNO" onClose={onClose}>
      <div style={{ display:'flex', flexDirection:'column', gap:9 }}>
        <PillInput placeholder="Digite o Nome (instrução abaixo)" />
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8 }}>
          <div style={{ display:'flex', alignItems:'center', gap:5 }}>
            <span style={{ fontSize:12 }}>📅</span>
            <PillInput placeholder="Data de nascimento" style={{ flex:1 }} />
          </div>
          <div style={{ display:'flex', alignItems:'center', gap:5 }}>
            <span style={{ fontSize:11, color:'#aaa' }}>▼</span>
            <PillInput placeholder="Sexo" style={{ flex:1 }} />
          </div>
        </div>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8 }}>
          <PillInput placeholder="CPF" />
          <PillInput placeholder="E-mail" />
        </div>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8 }}>
          <PillInput placeholder="Telefone" />
          <label style={{ display:'flex', alignItems:'center', gap:4, fontSize:11, color:'#666' }}>
            <input type="checkbox" style={{ margin:0 }} /> É WhatsApp?
          </label>
        </div>
        <div style={{ display:'grid', gridTemplateColumns:'1fr 1fr', gap:8 }}>
          <PillInput placeholder="Instagram" />
          <PillInput placeholder="Facebook" />
        </div>
        <div style={{ display:'flex', gap:10, justifyContent:'center', marginTop:6 }}>
          <Btn style={{ padding:'9px 24px' }}>Salvar</Btn>
          <Btn color={C.yellowBtn} textColor="#333" onClick={onClose} style={{ padding:'9px 20px' }}>Cancelar</Btn>
        </div>
      </div>
    </Modal>
  );
}

Object.assign(window, { ArenaHomeScreen, ArenaProfessoresScreen, ArenaAlunosScreen });
