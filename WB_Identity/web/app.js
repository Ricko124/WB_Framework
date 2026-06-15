const res='WB_Identity';window.addEventListener('message',e=>{if(e.data.action==='openIdentity'){let d=e.data.data||{};app.style.display='flex';for(const k of ['id','firstname','lastname','dateofbirth','sex','height']) if(document.getElementById(k)) document.getElementById(k).value=d[k]||''} if(e.data.action==='close')app.style.display='none'});
function post(n,d={}){return fetch(`https://${res}/${n}`,{method:'POST',headers:{'Content-Type':'application/json'},body:JSON.stringify(d)})}
function saveIdentity(){post('saveIdentity',{id:id.value,firstname:firstname.value,lastname:lastname.value,dateofbirth:dateofbirth.value,sex:sex.value,height:height.value})}
function closeUi(){post('close')}
