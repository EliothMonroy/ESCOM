function obtenerNombreTipoValor(){
	var elemento;
	var mensaje="";
	var formulario=document.forms[0];
	for (var i=0; i < formulario.length; i++) {
		elemento=formulario.elements[i];
			if(elemento.id){
				mensaje+="name: "+elemento.name+"    Tipo: "+elemento.type+"    Valor: "+elemento.value+"\n";
			}
		}
	alert(mensaje);
}
function validarCampos(){
	var formulario=document.forms[0];
	var elemento;
	for (var i=0; i < formulario.length; i++) {
		elemento=formulario.elements[i];
			if(elemento.type=="text" || elemento.type=="textarea" || elemento.type=="email"){
				if(elemento.value==""){
					return false;
				}
			}
			if(elemento.type=="email"){
				var email=elemento.value;
				var exp1=/\w@\w/
				var exp2=/.\w/
				if(email.includes(" ") || !exp1.test(email) || !exp2.test(email)){
					alert("El correo no es valido");
					return true
				}
			}
		}
		return true;
}
function validarRadiosCheckbox(){
	if(!(document.querySelector('input[name="sexo"]:checked') && document.querySelector('input[name="lenguaje"]:checked') && document.querySelector('input[name="pasatiempos"]:checked'))){
		return false;
	}
	return true;
}
function validarFecha(){
	var formulario=document.forms[0];
	var anio=parseInt(formulario.elements[4].value);
	var mes=parseInt(formulario.elements[5].value);
	var dia=parseInt(formulario.elements[6].value);
	var fecha=new Date(anio,mes,dia);
	if(fecha.getFullYear()==anio && fecha.getMonth()==mes && fecha.getDate()==dia){
		return true;
	}
	return false;
}
function validarFormulario(){
	if(!(validarCampos() && validarRadiosCheckbox())){
		alert("Debe ingresar todos los datos que el formulario pide");
	}else{
		if(!validarFecha()){
			alert("La fecha no es valida");
		}else{
			alert("Formulario valido");
		}
	}
}
function guardar(){
	var cokie="";
	for (var i = 0; i < document.forms[0].length; i++) {
		if(document.forms[0].elements[i].value){
			cokie+="i="+i+"; value="+document.forms[0].elements[i].value+"; ";
		}
	}
	document.cookie=escape(cokie);
}
function leer(){
	var cokie=unescape(document.cookie);
	if (cokie) {
		console.log("Existe una cookie");
		var arreglo=cokie.split("; ");
		var arreglo2, arreglo3;
		arreglo2=arreglo[0].split("=");
		for(var i=0;i<arreglo.length;i+=2){
			arreglo2=arreglo[i].split("=");
			if(i+1<arreglo.length){
				arreglo3=arreglo[i+1].split("=");
				document.forms[0].elements[parseInt(arreglo2[1])].value=arreglo3[1];
				console.log(document.forms[0].elements[parseInt(arreglo2[1])]);
				console.log(i);
				if(i==58){
					document.body.style.color=arreglo3[1];
				}else if(i==60){
					document.body.style.backgroundColor=arreglo3[1];
				}else if(i==62){
					document.body.style.fontSize=arreglo3[1];
				}else if(i==64){
					document.body.style.textDecoration=arreglo3[1];
				}
			}
		}
	}
}