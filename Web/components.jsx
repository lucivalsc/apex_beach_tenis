// components.jsx — shared UI components for 40x40 Beach Tennis
// Export everything to window at bottom

const C = {
  blue: '#5CC8F0',
  blueDark: '#1565C0',
  blueText: '#3AABDF',
  grayBtn: '#C0C0C0',
  grayBg: '#EBEBEB',
  white: '#FFFFFF',
  green: '#43A047',
  red: '#E53935',
  yellow: '#FDD835',
  yellowBtn: '#F5C518',
};

function StatusBar({ dark = false }) {
  const col = dark ? '#333' : 'white';
  return (
    <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', padding:'10px 20px 4px', fontSize:12, fontWeight:600, color:col, flexShrink:0 }}>
      <span>08.00</span>
      <div style={{ display:'flex', gap:5, alignItems:'center' }}>
        <svg width="16" height="11" viewBox="0 0 16 11" fill={col}>
          <path d="M8 2.5C5.5 2.5 3.2 3.5 1.5 5.2L0 3.7C2.1 1.4 5 0 8 0s5.9 1.4 8 3.7L14.5 5.2C12.8 3.5 10.5 2.5 8 2.5z"/>
          <path d="M8 6.5C6.4 6.5 5 7.1 4 8.1L2.5 6.6C3.9 5.3 5.9 4.5 8 4.5s4.1.8 5.5 2.1L12 8.1C11 7.1 9.6 6.5 8 6.5z"/>
          <circle cx="8" cy="10.5" r="1.5"/>
        </svg>
        <svg width="22" height="11" viewBox="0 0 22 11" fill="none">
          <rect x="0.5" y="0.5" width="18" height="10" rx="2" stroke={col} strokeWidth="1.2"/>
          <rect x="2" y="2" width="12" height="7" rx="1" fill={col}/>
          <path d="M19.5 3.5v4c1-.4 1.5-1 1.5-2s-.5-1.6-1.5-2z" fill={col}/>
        </svg>
      </div>
    </div>
  );
}

function ProfileHeader({ name, onBack, children, blueBg = true }) {
  const bg = blueBg ? C.blue : C.blue;
  return (
    <div style={{ background: bg, flexShrink:0 }}>
      <StatusBar />
      <div style={{ display:'flex', justifyContent:'space-between', alignItems:'center', padding:'2px 14px 6px' }}>
        {onBack
          ? <button onClick={onBack} style={{ background:'none', border:'none', color:'white', fontSize:22, cursor:'pointer', padding:'4px 6px', lineHeight:1 }}>←</button>
          : <div style={{ width:36 }}/>}
        <button style={{ background:'none', border:'none', color:'white', fontSize:16, cursor:'pointer', letterSpacing:3, lineHeight:1 }}>···</button>
      </div>
      <div style={{ display:'flex', alignItems:'center', padding:'0 14px 12px', gap:12 }}>
        <div style={{ position:'relative', flexShrink:0 }}>
          <div style={{ width:62, height:62, borderRadius:'50%', background:'#C8C8C8', display:'flex', alignItems:'center', justifyContent:'center', border:'2px solid rgba(255,255,255,0.4)' }}>
            <PersonIcon size={38} color="#888" withTie />
          </div>
          <div style={{ position:'absolute', bottom:-2, right:-2, width:20, height:20, borderRadius:'50%', background:C.blue, border:'2px solid white', display:'flex', alignItems:'center', justifyContent:'center', color:'white', fontSize:13, fontWeight:'bold', cursor:'pointer' }}>+</div>
        </div>
        <span style={{ color:'white', fontWeight:700, fontSize:14, letterSpacing:0.5, flex:1 }}>{name}</span>
        {children}
      </div>
    </div>
  );
}

function BottomBar() {
  return (
    <div style={{ background:C.blue, flexShrink:0, display:'flex', alignItems:'center', justifyContent:'flex-end', padding:'4px 10px 0', position:'relative', minHeight:52 }}>
      <img src="mpyq906i-pagina_1_img_1.jpeg" alt="40x40" style={{ height:44, objectFit:'contain', maxWidth:100 }} />
      <div style={{ position:'absolute', bottom:6, left:'50%', transform:'translateX(-50%)', width:120, height:5, borderRadius:3, background:'white' }}/>
    </div>
  );
}

function Input({ icon, placeholder, type='text', rightEl }) {
  return (
    <div style={{ display:'flex', alignItems:'center', background:'#EBEBEB', borderRadius:25, padding:'10px 16px', gap:8 }}>
      {icon && <span style={{ color:'#aaa', fontSize:13, flexShrink:0 }}>{icon}</span>}
      <input type={type} placeholder={placeholder} style={{ flex:1, border:'none', background:'transparent', fontSize:13, color:'#555', outline:'none' }} />
      {rightEl && <span style={{ color:'#aaa', cursor:'pointer' }}>{rightEl}</span>}
    </div>
  );
}

function PillInput({ placeholder, style={} }) {
  return (
    <input placeholder={placeholder} style={{ background:'#EBEBEB', border:'none', borderRadius:25, padding:'9px 14px', fontSize:12, color:'#666', outline:'none', width:'100%', boxSizing:'border-box', ...style }} />
  );
}

function Btn({ children, onClick, color=C.blue, textColor='white', full=false, style={} }) {
  return (
    <button onClick={onClick} style={{ background:color, color:textColor, border:'none', borderRadius:25, padding:'11px 24px', fontSize:14, fontWeight:700, cursor:'pointer', width: full?'100%':'auto', ...style }}>
      {children}
    </button>
  );
}

function GridBtn({ label, icon, active=true, onClick }) {
  return (
    <div onClick={onClick} style={{ background: active ? C.blue : C.grayBtn, borderRadius:12, display:'flex', flexDirection:'column', alignItems:'center', justifyContent:'flex-end', padding:'10px 8px 10px', cursor:'pointer', userSelect:'none', minHeight:110, gap:6 }}>
      <div style={{ flex:1, display:'flex', alignItems:'center', justifyContent:'center' }}>{icon}</div>
      <span style={{ color:'white', fontWeight:800, fontSize:11, textAlign:'center', letterSpacing:0.5, lineHeight:'1.2' }}>{label}</span>
    </div>
  );
}

function SectionTitle({ children }) {
  return (
    <div style={{ display:'flex', alignItems:'center', justifyContent:'center', padding:'10px 0', borderTop:'1px solid #e0e0e0', borderBottom:'1px solid #e0e0e0', marginBottom:0 }}>
      <span style={{ color:C.blueDark, fontWeight:800, fontSize:13, letterSpacing:0.5 }}>{children}</span>
    </div>
  );
}

function TableHeader({ cols }) {
  return (
    <div style={{ display:'flex', alignItems:'center', padding:'4px 12px', borderBottom:'1px solid #e0e0e0' }}>
      {cols.map((c,i) => <span key={i} style={{ flex:c.flex||1, fontSize:11, color:'#999', fontWeight:600 }}>{c.label}</span>)}
    </div>
  );
}

function ListRow({ name, hasPhoto=true, canEdit=true, status, canView=false, onEdit, onView, extra }) {
  return (
    <div style={{ display:'flex', alignItems:'center', padding:'7px 12px', gap:8, borderBottom:'1px solid #f0f0f0' }}>
      {hasPhoto && (
        <div style={{ width:30, height:30, borderRadius:6, background:C.blue, display:'flex', alignItems:'center', justifyContent:'center', flexShrink:0 }}>
          <svg width="18" height="18" viewBox="0 0 18 18" fill="none">
            <rect x="1" y="1" width="16" height="16" rx="3" stroke="white" strokeWidth="1.5"/>
            <circle cx="9" cy="7" r="2" stroke="white" strokeWidth="1.5"/>
            <path d="M3.5 15c0-3 2.5-4.5 5.5-4.5s5.5 1.5 5.5 4.5" stroke="white" strokeWidth="1.5"/>
          </svg>
        </div>
      )}
      <span style={{ flex:1, color:C.blue, fontSize:12.5, fontWeight:500 }}>{name}</span>
      {extra}
      {canView && <button onClick={onView} style={{ background:'none', border:'none', cursor:'pointer', color:C.blue, padding:'0 2px' }}><EyeIcon color={C.blue}/></button>}
      {canEdit && <button onClick={onEdit} style={{ background:'none', border:'none', cursor:'pointer', padding:'0 2px' }}><EditIcon color={C.yellowBtn}/></button>}
      {status === true && <span style={{ color:C.green, fontSize:16, lineHeight:1 }}>✓</span>}
      {status === false && <span style={{ color:C.red, fontSize:16, lineHeight:1 }}>✗</span>}
      {status === '-' && <span style={{ color:'#999', fontSize:16, lineHeight:1 }}>-</span>}
    </div>
  );
}

function Modal({ title, children, onClose, style={} }) {
  return (
    <div style={{ position:'absolute', inset:0, background:'rgba(0,0,0,0.65)', display:'flex', alignItems:'center', justifyContent:'center', zIndex:200, padding:'0 10px' }}>
      <div style={{ background:'white', borderRadius:14, padding:'16px 14px', width:'100%', maxHeight:'78%', overflowY:'auto', position:'relative', ...style }}>
        {onClose && (
          <button onClick={onClose} style={{ position:'absolute', top:8, right:8, width:26, height:26, borderRadius:'50%', background:C.yellowBtn, border:'none', fontWeight:'bold', cursor:'pointer', fontSize:12 }}>X</button>
        )}
        <div style={{ textAlign:'center', borderBottom:'1px solid #e0e0e0', paddingBottom:10, marginBottom:12 }}>
          <span style={{ color:C.blueDark, fontWeight:800, fontSize:13, letterSpacing:0.5 }}>{title}</span>
        </div>
        {children}
      </div>
    </div>
  );
}

function PhotoPlaceholder({ size=80 }) {
  return (
    <div style={{ width:size, height:size, borderRadius:10, background:C.blue, display:'flex', alignItems:'center', justifyContent:'center', position:'relative', cursor:'pointer', flexShrink:0 }}>
      <svg width={size*0.45} height={size*0.4} viewBox="0 0 36 32" fill="none">
        <rect x="2" y="8" width="32" height="22" rx="3" stroke="white" strokeWidth="2"/>
        <circle cx="18" cy="19" r="6" stroke="white" strokeWidth="2"/>
        <path d="M13 8l2-5h6l2 5" stroke="white" strokeWidth="2"/>
      </svg>
      <div style={{ position:'absolute', bottom:-6, right:-6, width:20, height:20, borderRadius:'50%', background:C.blue, border:'2px solid white', display:'flex', alignItems:'center', justifyContent:'center', color:'white', fontSize:13, fontWeight:'bold' }}>+</div>
    </div>
  );
}

function ScoreDisplay() {
  return (
    <div style={{ display:'flex', gap:4, justifyContent:'center', margin:'6px 0' }}>
      {['4','0','×','4','0'].map((d,i) => (
        <div key={i} style={{ width:36, height:42, background:'#CC1111', borderRadius:6, display:'flex', alignItems:'center', justifyContent:'center', color:'white', fontWeight:900, fontSize:22, boxShadow:'0 2px 6px rgba(0,0,0,0.4)', position:'relative', overflow:'hidden', flexShrink:0 }}>
          <div style={{ position:'absolute', left:0, right:0, top:'50%', height:1.5, background:'rgba(0,0,0,0.25)' }}/>
          {d}
        </div>
      ))}
    </div>
  );
}

// ── SVG Icon Components ─────────────────────────────
function PersonIcon({ size=28, color='white', withTie=false }) {
  return (
    <svg width={size} height={size} viewBox="0 0 32 32" fill="none">
      <circle cx="16" cy="11" r="7" fill={color}/>
      <path d="M3 31c0-8 5.5-12 13-12s13 4 13 12" fill={color}/>
      {withTie && <path d="M15 21l1 4-1 4 1-4-1 4" stroke="#777" strokeWidth="2" fill="none"/>}
    </svg>
  );
}

function EyeIcon({ color='#5CC8F0', size=18 }) {
  return (
    <svg width={size} height={size*0.75} viewBox="0 0 18 14" fill="none">
      <path d="M1 7S4 1 9 1s8 6 8 6-3 6-8 6S1 7 1 7z" stroke={color} strokeWidth="1.5"/>
      <circle cx="9" cy="7" r="2.5" stroke={color} strokeWidth="1.5"/>
    </svg>
  );
}

function EditIcon({ color='#F5C518', size=18 }) {
  return (
    <svg width={size} height={size} viewBox="0 0 18 18" fill="none">
      <path d="M2 14l.7-3.5L11 2l2.8 2.8L5.5 13.3 2 14z" stroke={color} strokeWidth="1.5"/>
      <path d="M10 3.5l2.5 2.5" stroke={color} strokeWidth="1.5"/>
    </svg>
  );
}

function AtletaIcon() {
  return (
    <svg width="48" height="60" viewBox="0 0 48 60" fill="white">
      <circle cx="24" cy="8" r="7"/>
      <path d="M18 18c-2 4-3 10 0 14l-6 20h6l5-14 5 14h6l-6-20c3-4 2-10 0-14z"/>
      <line x1="16" y1="28" x2="8" y2="38" stroke="white" strokeWidth="2.5"/>
    </svg>
  );
}

function AlunoIcon() {
  return (
    <svg width="44" height="58" viewBox="0 0 44 58" fill="white">
      <circle cx="22" cy="8" r="6"/>
      <path d="M16 16c-2 3-1 8 2 12L12 52h5l4-14 4 14h5L24 28c3-4 4-9 2-12z"/>
      <path d="M28 22l8-4-2 8" stroke="white" strokeWidth="2" fill="none"/>
    </svg>
  );
}

function ProfessorIcon() {
  return (
    <svg width="52" height="58" viewBox="0 0 52 58" fill="white">
      <circle cx="18" cy="8" r="6"/>
      <path d="M12 16c-2 3-1 8 2 12L8 52h5l4-14 4 14h5l-6-24c3-4 4-9 2-12z"/>
      <rect x="30" y="10" width="20" height="16" rx="2" stroke="white" strokeWidth="2" fill="none"/>
      <line x1="34" y1="15" x2="46" y2="15" stroke="white" strokeWidth="1.5"/>
      <line x1="34" y1="19" x2="46" y2="19" stroke="white" strokeWidth="1.5"/>
      <line x1="28" y1="26" x2="32" y2="26" stroke="white" strokeWidth="2"/>
    </svg>
  );
}

function ArenaIcon() {
  return (
    <svg width="54" height="48" viewBox="0 0 54 48" fill="white">
      <path d="M4 30 Q27 10 50 30" stroke="white" strokeWidth="2.5" fill="none"/>
      <rect x="8" y="28" width="38" height="14" rx="2" fill="white"/>
      <rect x="18" y="36" width="18" height="6" rx="1" fill={C.blue === '#5CC8F0' ? '#5CC8F0' : '#5CC8F0'}/>
      <rect x="4" y="14" width="3" height="16" fill="white"/>
      <rect x="47" y="14" width="3" height="16" fill="white"/>
      <path d="M4 14 L27 4 L50 14" stroke="white" strokeWidth="2" fill="none"/>
    </svg>
  );
}

function TechIcon() {
  return (
    <svg width="44" height="50" viewBox="0 0 44 50" fill="white">
      <rect x="8" y="2" width="28" height="36" rx="3" stroke="white" strokeWidth="2" fill="none"/>
      <line x1="14" y1="12" x2="30" y2="12" stroke="white" strokeWidth="2"/>
      <line x1="14" y1="18" x2="30" y2="18" stroke="white" strokeWidth="2"/>
      <line x1="14" y1="24" x2="24" y2="24" stroke="white" strokeWidth="2"/>
      <path d="M28 28l4 4-8 8-4-8 8-12z" fill="white"/>
    </svg>
  );
}

function TreinoIcon() {
  return (
    <svg width="42" height="48" viewBox="0 0 42 48" fill="white">
      <rect x="4" y="4" width="34" height="40" rx="3" stroke="white" strokeWidth="2" fill="none"/>
      <line x1="10" y1="14" x2="32" y2="14" stroke="white" strokeWidth="2"/>
      <line x1="10" y1="20" x2="32" y2="20" stroke="white" strokeWidth="2"/>
      <line x1="10" y1="26" x2="24" y2="26" stroke="white" strokeWidth="2"/>
      <path d="M24 32l4-4 2 2-6 4z" fill="white"/>
      <path d="M30 26l4 4" stroke="white" strokeWidth="2"/>
    </svg>
  );
}

function AvaliacaoIcon() {
  return (
    <svg width="42" height="48" viewBox="0 0 42 48" fill="white">
      <rect x="4" y="4" width="34" height="40" rx="3" stroke="white" strokeWidth="2" fill="none"/>
      <rect x="10" y="12" width="4" height="4" rx="1" stroke="white" strokeWidth="1.5"/>
      <line x1="17" y1="14" x2="30" y2="14" stroke="white" strokeWidth="1.5"/>
      <rect x="10" y="20" width="4" height="4" rx="1" stroke="white" strokeWidth="1.5"/>
      <line x1="17" y1="22" x2="30" y2="22" stroke="white" strokeWidth="1.5"/>
      <rect x="10" y="28" width="4" height="4" rx="1" stroke="white" strokeWidth="1.5"/>
      <line x1="17" y1="30" x2="30" y2="30" stroke="white" strokeWidth="1.5"/>
      <path d="M11 13l1.5 1.5 2.5-2.5" stroke="white" strokeWidth="1.2"/>
    </svg>
  );
}

function EditarPerfilIcon() {
  return (
    <svg width="44" height="44" viewBox="0 0 44 44" fill="white">
      <rect x="4" y="4" width="30" height="36" rx="3" stroke="white" strokeWidth="2" fill="none"/>
      <path d="M26 28l8-8 4 4-8 8H26v-4z" stroke="white" strokeWidth="1.5" fill="none"/>
      <line x1="10" y1="14" x2="24" y2="14" stroke="white" strokeWidth="2"/>
      <line x1="10" y1="20" x2="22" y2="20" stroke="white" strokeWidth="2"/>
    </svg>
  );
}

function AlternarPerfilIcon() {
  return (
    <svg width="44" height="44" viewBox="0 0 44 44" fill="white">
      <path d="M8 20 A14 14 0 0 1 36 20" stroke="white" strokeWidth="3" fill="none" strokeLinecap="round"/>
      <path d="M36 24 A14 14 0 0 1 8 24" stroke="white" strokeWidth="3" fill="none" strokeLinecap="round"/>
      <path d="M32 14l4 6-6 1z" fill="white"/>
      <path d="M12 30l-4-6 6-1z" fill="white"/>
    </svg>
  );
}

function EstatisticasIcon() {
  return (
    <svg width="44" height="44" viewBox="0 0 44 44" fill="white">
      <rect x="6" y="26" width="6" height="14" rx="1" fill="white"/>
      <rect x="16" y="18" width="6" height="22" rx="1" fill="white"/>
      <rect x="26" y="10" width="6" height="30" rx="1" fill="white"/>
      <path d="M4 6l10 10 10-6 12-6" stroke="white" strokeWidth="2.5" fill="none" strokeLinecap="round" strokeLinejoin="round"/>
    </svg>
  );
}

function AdicionarJogoIcon() {
  return (
    <svg width="44" height="44" viewBox="0 0 44 44" fill="white">
      <circle cx="22" cy="22" r="18" stroke="white" strokeWidth="2.5" fill="none"/>
      <line x1="22" y1="12" x2="22" y2="32" stroke="white" strokeWidth="3" strokeLinecap="round"/>
      <line x1="12" y1="22" x2="32" y2="22" stroke="white" strokeWidth="3" strokeLinecap="round"/>
    </svg>
  );
}

function CalendarioIcon() {
  return (
    <svg width="44" height="44" viewBox="0 0 44 44" fill="white">
      <rect x="4" y="8" width="36" height="32" rx="3" stroke="white" strokeWidth="2" fill="none"/>
      <line x1="4" y1="18" x2="40" y2="18" stroke="white" strokeWidth="1.5"/>
      <line x1="14" y1="4" x2="14" y2="14" stroke="white" strokeWidth="2.5" strokeLinecap="round"/>
      <line x1="30" y1="4" x2="30" y2="14" stroke="white" strokeWidth="2.5" strokeLinecap="round"/>
      <rect x="10" y="22" width="5" height="4" rx="1" fill="white"/>
      <rect x="19" y="22" width="5" height="4" rx="1" fill="white"/>
      <rect x="28" y="22" width="5" height="4" rx="1" fill="white"/>
      <rect x="10" y="30" width="5" height="4" rx="1" fill="white"/>
      <rect x="19" y="30" width="5" height="4" rx="1" fill="white"/>
    </svg>
  );
}

function DuplasIcon() {
  return (
    <svg width="56" height="44" viewBox="0 0 56 44" fill="white">
      <circle cx="16" cy="7" r="5"/>
      <path d="M10 14c-2 3-1 7 2 10L8 40h5l3-10 3 10h5l-4-16c3-3 4-7 2-10z"/>
      <circle cx="40" cy="7" r="5"/>
      <path d="M34 14c-2 3-1 7 2 10L32 40h5l3-10 3 10h5l-4-16c3-3 4-7 2-10z"/>
    </svg>
  );
}

function SimplesIcon() {
  return (
    <svg width="40" height="58" viewBox="0 0 40 58" fill="white">
      <circle cx="20" cy="8" r="6"/>
      <path d="M14 16c-2 3-1 8 2 12L10 52h5l4-14 4 14h5L22 28c3-4 4-9 2-12z"/>
      <path d="M24 20l8-5" stroke="white" strokeWidth="2.5" strokeLinecap="round"/>
    </svg>
  );
}

function NotifBadge({ children, count, color='#E53935' }) {
  return (
    <div style={{ position:'relative', display:'inline-flex' }}>
      {children}
      {count > 0 && (
        <div style={{ position:'absolute', top:-6, right:-6, background:color, color:'white', borderRadius:'50%', width:17, height:17, fontSize:10, display:'flex', alignItems:'center', justifyContent:'center', fontWeight:'bold' }}>{count}</div>
      )}
    </div>
  );
}

function ProfTecnicoNotifs() {
  return (
    <div style={{ display:'flex', gap:4 }}>
      <NotifBadge count={3}>
        <svg width="22" height="22" viewBox="0 0 22 22" fill="none">
          <path d="M11 1l1.5 4h4.5l-3.5 2.5 1.5 4-4-3-4 3 1.5-4L5 5h4.5z" stroke={C.blue} strokeWidth="1.5" fill={C.blue}/>
          <circle cx="11" cy="11" r="9" stroke={C.blue} strokeWidth="1.5" fill="none"/>
        </svg>
      </NotifBadge>
      <NotifBadge count={5}>
        <svg width="22" height="22" viewBox="0 0 22 22" fill="none">
          <circle cx="8" cy="8" r="4" stroke={C.blue} strokeWidth="1.5"/>
          <path d="M2 20c0-4 2.7-6 6-6s6 2 6 6" stroke={C.blue} strokeWidth="1.5" fill="none"/>
          <circle cx="15" cy="7" r="3" stroke={C.blue} strokeWidth="1.5"/>
          <path d="M15 13c2.5 0 5 1.5 5 5" stroke={C.blue} strokeWidth="1.5" fill="none"/>
        </svg>
      </NotifBadge>
    </div>
  );
}

function SearchBar({ placeholder, onPlus }) {
  return (
    <div style={{ display:'flex', alignItems:'center', gap:8, padding:'8px 12px' }}>
      <div style={{ flex:1, display:'flex', alignItems:'center', background:'#EBEBEB', borderRadius:20, padding:'7px 12px', gap:6 }}>
        <svg width="14" height="14" viewBox="0 0 14 14" fill="none">
          <circle cx="6" cy="6" r="5" stroke="#aaa" strokeWidth="1.5"/>
          <line x1="10" y1="10" x2="13" y2="13" stroke="#aaa" strokeWidth="1.5" strokeLinecap="round"/>
        </svg>
        <input placeholder={placeholder} style={{ border:'none', background:'transparent', fontSize:12, color:'#666', outline:'none', flex:1 }}/>
      </div>
      {onPlus && (
        <button onClick={onPlus} style={{ background:'none', border:'none', cursor:'pointer', color:C.blue, fontSize:24, fontWeight:'bold', lineHeight:1, padding:'0 4px' }}>+</button>
      )}
    </div>
  );
}

Object.assign(window, {
  C, StatusBar, ProfileHeader, BottomBar, Input, PillInput, Btn, GridBtn,
  SectionTitle, TableHeader, ListRow, Modal, PhotoPlaceholder, ScoreDisplay,
  PersonIcon, EyeIcon, EditIcon,
  AtletaIcon, AlunoIcon, ProfessorIcon, ArenaIcon, TechIcon,
  TreinoIcon, AvaliacaoIcon, EditarPerfilIcon, AlternarPerfilIcon,
  EstatisticasIcon, AdicionarJogoIcon, CalendarioIcon, DuplasIcon, SimplesIcon,
  NotifBadge, ProfTecnicoNotifs, SearchBar,
});
