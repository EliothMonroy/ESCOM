function push(){
	var nodo=document.getElementById("pila");
	var nuevo=document.createElement("div");
	var texto=document.createTextNode(document.getElementById("valor-pila").value);
	nuevo.appendChild(texto);
	nodo.appendChild(nuevo);
}
function pop(){
	var nodo=document.getElementById("pila");
	nodo.removeChild(nodo.lastChild);
}
function insertar(){
	var nodo=document.getElementById("cola");
	var nuevo=document.createElement("div");
	var texto=document.createTextNode(document.getElementById("valor-cola").value);
	nuevo.appendChild(texto);
	nodo.appendChild(nuevo);
}
function eliminar(){
	var nodo=document.getElementById("cola");
	nodo.removeChild(nodo.firstChild);
}