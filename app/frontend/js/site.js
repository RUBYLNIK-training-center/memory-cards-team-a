import '../js/bootstrap_js_files.js'

setTimeout(function(){
  if(document.getElementById('message') != null) {
	  document.getElementById('message').style.display = 'none';
  }
}, 5000);

let collors = ['bg-primary', 'bg-secondary', 'bg-success', 'bg-danger', 'bg-warning text-dark'];
setTimeout(function(){
  if(document.getElementById('premium') != null) {
    let num = Math.floor(Math.random() * 5);
    document.getElementById('premium').className = `badge rounded-pill ${collors[num]}`;
  }
}, 10000);
