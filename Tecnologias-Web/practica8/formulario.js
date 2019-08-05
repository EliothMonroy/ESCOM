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