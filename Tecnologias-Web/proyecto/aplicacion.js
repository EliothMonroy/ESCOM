//Sirve para recorrer el arreglo de cartas
var indice=0;
var cartasManoCompu=[]
var cartas_faltantes_usuario=0;
//Arreglo que contiene los id's de las cartas
var cartas=['AC','AD','AH','AS','2C','2D','2H','2S','3C','3D','3H','3S','4C','4D','4H','4S','5C','5D','5H','5S','6C','6D','6H','6S','7C','7D','7H','7S','8C','8D','8H','8S','9C','9D','9H','9S','TC','TD','TH','TS','JC','JD','JH','JS','QC','QD','QH','QS','KC','KD','KH','KS'];
//Función para revolver las cartas:
Array.prototype.revolver=function(){
	var i=this.length,j,temp;
	while(--i>0){
		j=Math.floor(Math.random()*(i+1));
		temp=this[j];
		this[j]=this[i];
		this[i]=temp;
	}
}

function iniciar(){
	cartas.revolver();
	darCartasCompu(3);
	darCartasUsuario(3);
	ponerCentro();
	ponerDeck();
	// alert(cartas[0]);
}

//Función que da una o más cartas al jugador
function darCartasCompu(total){
	var cartasCompu=document.getElementById("cartas_compu");
	// var deck=document.getElementById("deck");
	// deck.setAttribute("class","darCartaUsuario");
	//wait(2000);
	for (var i = 0; i < total; i++) {
		darCartaCompu(cartasCompu);
	}
	// setTimeout(darCartaUsuario(cartasUsuario),2000);
}
function darCartaCompu(cartasCompu){
	if(indice==52){
		alert("Empate");
	}else{
		var aux=document.createElement("img");
		aux.setAttribute("id",cartas[indice]);
		cartasManoCompu.push(cartas[indice]);
		aux.setAttribute("draggable","false");
		aux.setAttribute("src","images/"+cartas[indice++]+".png");
		cartasCompu.appendChild(aux);
	}
}
//Función que da una o más cartas al jugador
function darCartasUsuario(total){
	var cartasUsuario=document.getElementById("cartas_usuario");
	// var deck=document.getElementById("deck");
	// deck.setAttribute("class","darCartaUsuario");
	//wait(2000);
	for (var i = 0; i < total; i++) {
		darCartaUsuario(cartasUsuario);
	}
	// setTimeout(darCartaUsuario(cartasUsuario),2000);
}
function darCartaUsuario(cartasUsuario){
	var aux=document.createElement("img");
	aux.setAttribute("id",cartas[indice]);
	aux.setAttribute("draggable","true");
	aux.setAttribute("ondragstart","drag(event)");
	aux.setAttribute("src","images/"+cartas[indice++]+".png");
	cartasUsuario.appendChild(aux);
	cartas_faltantes_usuario++;
}
function ponerCentro(){
	var cartaCentro=document.getElementById("centro");
	var aux=document.createElement("img");
	aux.setAttribute("id",cartas[indice]);
	aux.setAttribute("draggable","false");
	aux.setAttribute("src","images/"+cartas[indice++]+".png");
	cartaCentro.appendChild(aux);
}
function ponerDeck(){
	var cartaCentro=document.getElementById("deck");
	var aux=document.createElement("img");
	aux.setAttribute("id",cartas[indice]);
	aux.setAttribute("draggable","false");
	aux.setAttribute("src","images/"+cartas[indice++]+".png");
	aux.setAttribute("onclick","darCartaUsuarioClick()");
	cartaCentro.appendChild(aux);
}

//Función que le da una carta al jugador cuando da click
function darCartaUsuarioClick(){
	var cartasUsuario=document.getElementById("cartas_usuario");
	var deck=document.getElementById("deck");
	var carta=deck.lastChild;
	//Agregamos carta al usuario
	var aux=document.createElement("img");
	aux.setAttribute("id",carta.id);
	aux.setAttribute("draggable","true");
	aux.setAttribute("ondragstart","drag(event)");
	aux.setAttribute("src","images/"+carta.id+".png");
	cartasUsuario.appendChild(aux);
	cartas_faltantes_usuario++;
	//cambiamos carta
	carta.id=cartas[indice]
	if(indice==52){
		alert("Empate");
	}
	carta.src="images/"+cartas[indice++]+".png";
}

function allowDrop(ev) {
	ev.preventDefault();
}

function drag(ev) {
	// alert(ev.target.id);
	ev.dataTransfer.setData("text", ev.target.id);
}

function drop(ev) {
	ev.preventDefault();
	// alert(ev.target.id);
	var nodo=document.getElementById(ev.target.id);
	// alert(nodo.src);
	var nodoPadre=document.getElementById(nodo.parentElement.id);
	// alert(nodoPadre);
	// alert(cartas.length);
	var data = ev.dataTransfer.getData("text");
	if(validarCarta(data)){
		ev.target.appendChild(document.getElementById(data));
		nodo.src=document.getElementById(data).src;
		nodo.id=data;
		cartas_faltantes_usuario--;
		hacerTirarCompu();
	}else{
		alert("No es posible hacer esta jugada");
	}
	if (cartas_faltantes_usuario==0) {
		alert("Has ganado el juego");
	}
}

function validarCarta(id){
	var centro=document.getElementById("centro");
	var cartaCentro=centro.lastChild.id;
	if(id.charAt(0)==cartaCentro.charAt(0)){
		return true;
	}else{
		if(id.charAt(1)==cartaCentro.charAt(1)){
			return true;
		}else{
			return false;
		}
	}
}

function hacerTirarCompu(){
	// var centro=document.getElementById("centro");
	// var cartaCentro=centro.lastChild.id;
	var tiro=0,remover;
	for (var i = 0; i < cartasManoCompu.length; i++) {
		if(validarCarta(cartasManoCompu[i])){
			tiro=1;
			var centro=document.getElementById("centro");
			var cartaCentro=centro.lastChild;
			cartaCentro.src=document.getElementById(cartasManoCompu[i]).src;
			cartaCentro.id=cartasManoCompu[i];
			remover=cartasManoCompu.indexOf(cartasManoCompu[i]);
			var cartasCompu=document.getElementById("cartas_compu");
			cartasCompu.removeChild(document.getElementById(cartasManoCompu[i]));
			cartasManoCompu.splice(remover,1);
			break;
		}
	}
	if(cartasManoCompu.length==0){
		alert("La computadora gano");
	}else{
		if (tiro==0){
			darCartasCompu(1);
			hacerTirarCompu();
		}
	}
}