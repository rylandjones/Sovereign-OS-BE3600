const $=q=>document.querySelector(q);
$("#homeBtn").onclick=()=>switchView('home'); $("#proBtn").onclick=()=>switchView('pro'); $("#emfBtn").onclick=()=>switchView('emf');
function switchView(v){document.querySelectorAll('.view').forEach(el=>el.classList.remove('active')); $("#"+v).classList.add('active');
  document.querySelectorAll('nav button').forEach(b=>b.classList.remove('active')); (v==='home'?$("#homeBtn"):v==='pro'?$("#proBtn"):$("#emfBtn")).classList.add('active');}
$("#soundToggle").onchange=async(e)=>{const enabled=e.target.checked; await ubus("sovereign","sound.toggle",{"enabled":enabled,"volume":30});};
$("#wellness").onclick=async()=>{await ubus("sovereign","wellness.night",{"enabled":true});};
async function ubus(obj,method,params){try{const r=await fetch('/ubus',{method:'POST',headers:{'content-type':'application/json'},
  body:JSON.stringify({"jsonrpc":"2.0","id":1,"method":"call","params":["",obj,method,params]})}); return await r.json();}catch(e){return null}}
let txSeries=[], sparkSeries=[];
function drawLine(c,data){const x=c.getContext('2d'); const W=c.width=c.clientWidth; const H=c.height=c.height; x.clearRect(0,0,W,H);
  if(data.length<2) return; const min=Math.min(...data), max=Math.max(...data); const range=(max-min)||1; x.beginPath(); x.strokeStyle="#2cc3b5"; x.lineWidth=2;
  data.forEach((v,i)=>{const px=i*(W/(data.length-1)); const py=H-((v-min)/range)*H; i?x.lineTo(px,py):x.moveTo(px,py)}); x.stroke();}
async function tick(){ let clients=Math.floor(Math.random()*8), tx=5+Math.floor(Math.random()*15), busy=20+Math.random()*60, peers=1+Math.floor(Math.random()*3);
  $("#wanStatus").textContent="online"; $("#clients").textContent=clients; sparkSeries.push(tx); if(sparkSeries.length>60) sparkSeries.shift(); drawLine($("#spark"),sparkSeries);
  txSeries.push(tx); if(txSeries.length>120) txSeries.shift(); drawLine($("#txChart"),txSeries); $("#meshKPIs").textContent=`peers: ${peers} | busy: ${busy.toFixed(1)}%`; $("#devList").textContent=`${clients} device(s) connected`; requestAnimationFrame(()=>{}); }
setInterval(tick,1000); tick();