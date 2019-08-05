function escribirHeader(){
	document.write("<html>");
	document.write("<body>");
}
function escribirFooder(){
	document.write("</body>");
	document.write("</html>");
}
function colorLetra(){
	document.getElementById("tabla").style.color = prompt("Ingresa un color de letra");
}
function tipoLetra(){
	document.getElementById("tabla").style.fontFamily = prompt("Ingresa un tipo de letra");
}
function colorFondo(){
	document.getElementById("tabla").style.backgroundColor = prompt("Ingresa un color de fondo");
}
function escribirBotones(){
	document.write("<input type='button' onclick='colorLetra()' value='Color letra'/>");
	document.write("<input type='button' onclick='tipoLetra()' value='Tipo letra'/>");
	document.write("<input type='button' onclick='colorFondo()' value='Color fondo'/>");
}
function factorial(val){
	if (val==0) {
		return 1;
	}else{
		return val*factorial(val-1);
	}
}
function main(){
	escribirHeader();
	var num=prompt("Por favor ingrese un número");
	document.open();
	document.write("<table id='tabla' border='1'><tr><td>Valor</td><td>Factorial</td></tr>");
	var factoriales=new Array(parseInt(num));
	for (var i = 0; i <= num; i++) {
		factoriales[i]=factorial(i);
	}
	for(var i=0;i<=num;i++){
		document.write("<tr><td>"+i+"</td><td>"+factoriales[i]+"</td></tr>");
	}
	escribirBotones();
	escribirFooder();
	document.close();
}