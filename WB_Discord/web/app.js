const resource = (typeof GetParentResourceName === 'function') ? GetParentResourceName() : 'WB_Framework';
const $ = (id) => document.getElementById(id);
function post(action, data = {}) {
  return fetch(`https://${resource}/${action}`, {method:'POST', headers:{'Content-Type':'application/json'}, body:JSON.stringify(data)}).catch(()=>{});
}
function showPage(visible=true){ document.body.style.display = visible ? 'block' : 'none'; }
function closeUI(){ post('close'); showPage(false); }
window.closeUI=closeUI; window.closeInventory=closeUI; window.closeJobs=closeUI; window.closeBank=closeUI; window.closePhone=closeUI; window.closeHospital=closeUI;
document.addEventListener('keyup', e => { if(e.key === 'Escape') closeUI(); });
window.addEventListener('message', (event) => {
  const d = event.data || {};
  if (d.action === 'open') showPage(true);
  if (d.action === 'close') showPage(false);
  if (d.balance !== undefined && $('balance')) $('balance').textContent = '$' + Number(d.balance).toLocaleString('de-DE');
  if (d.cash !== undefined && $('cash')) $('cash').textContent = '$' + Number(d.cash).toLocaleString('de-DE');
  if (d.job && $('jobTitle')) $('jobTitle').textContent = d.job.label || d.job.name || 'Arbeitslos';
  if (d.items && $('inventoryGrid')) renderItems(d.items);
  if (d.jobs && $('jobsGrid')) renderJobs(d.jobs);
  if (d.characters && $('charactersGrid')) renderCharacters(d.characters);
});
function renderItems(items){
  const grid=$('inventoryGrid'); if(!grid) return; grid.innerHTML='';
  items.forEach(it=>{ const div=document.createElement('div'); div.className='inventory-item'; div.innerHTML=`<b>${it.label||it.name||it.item}</b><span>x${it.count||1}</span>`; div.onclick=()=>post('useItem', it); grid.appendChild(div); });
}
function renderJobs(jobs){
  const grid=$('jobsGrid'); if(!grid) return; grid.innerHTML='';
  jobs.forEach(j=>{ const div=document.createElement('div'); div.className='job-card'; div.innerHTML=`<h3>${j.label||j.id}</h3><p>${j.description||''}</p><button>Auswählen</button>`; div.querySelector('button').onclick=()=>post('setJob',{job:j.id||j.name,grade:0}); grid.appendChild(div); });
}
function renderCharacters(chars){
  const grid=$('charactersGrid') || $('characterList'); if(!grid) return; grid.innerHTML='';
  chars.forEach(c=>{ const div=document.createElement('div'); div.className='character-card'; div.innerHTML=`<h3>${c.firstname} ${c.lastname}</h3><p>${c.job||'unemployed'}</p><button>Spielen</button>`; div.querySelector('button').onclick=()=>post('selectCharacter',{id:c.id}); grid.appendChild(div); });
}
const btn=document.getElementById('actionButton'); if(btn) btn.onclick=()=>post('action');
const createForm=document.getElementById('createForm'); if(createForm){ createForm.addEventListener('submit', e=>{e.preventDefault(); post('createCharacter',{firstname:$('firstname').value,lastname:$('lastname').value,dateofbirth:$('dateofbirth').value,sex:$('sex').value,height:$('height').value});}); }
showPage(false);
