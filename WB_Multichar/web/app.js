const res='WB_Multichar';let state={characters:[],max:4};
window.addEventListener('message',e=>{if(e.data.action==='open'){state=e.data.data||state;render();document.getElementById('app').style.display='flex'} if(e.data.action==='close')document.getElementById('app').style.display='none'});
function post(n,d={}){return fetch(`https://${res}/${n}`,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(d)})}
function render(){let box=document.getElementById('chars');box.innerHTML='';(state.characters||[]).forEach(c=>{box.innerHTML+=`<div class='card'><h3>${c.firstname} ${c.lastname}</h3><p>${c.dateofbirth} · ${c.sex} · ${c.job||'unemployed'}</p><button onclick='post("select",{id:${c.id}})'>Spielen</button> <button class='danger' onclick='post("delete",{id:${c.id}})'>Löschen</button></div>`})}
function createChar(){post('create',{firstname:fn.value,lastname:ln.value,dateofbirth:dob.value,sex:sex.value,height:height.value})}
function closeUi(){post('close')}
