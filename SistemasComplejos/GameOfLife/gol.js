var c=document.getElementById("myCanvas");
var chart = document.getElementById("myChart");
var longitud=680;
var tam=100;
var escala=longitud/tam;
var ctx=c.getContext("2d");
ctx.lineWidth = "0.1";
var random;
var x,y;
var regla1=2;
var regla2=3;
var regla3=3;
var regla4=3;
var generacion=0;
var numero_vivos=0;
var numero_muertos=0;
var color_vivo="#66ff66";
var color_muerto="#FF0000";
var vecindad=new Array(8);
var intervalo;
var log;
var generacion_grafica=[];
var vivos_grafica=[];
var total_vivos=0;
var array;
var array2;
var coordenadas;
var distribucion=50;

//Función para descargar
function descargar(){
	var fileContents = log;
	var fileName = "log.txt";
	var pp = document.createElement('a');
	pp.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(fileContents));
	pp.setAttribute('download', fileName);
	pp.click();
}

//Modificar valor del slider en pantalla
document.getElementById("distribucion_valor").innerHTML = document.getElementById("distribucion").value;
document.getElementById("distribucion").oninput = function(e) {
	e.preventDefault();
	document.getElementById("distribucion_valor").innerHTML = this.value;
}

function Create2DArray(rows) {
	var arr = new Array(rows);
	for (var i=0;i<rows;i++) {
		arr[i] = new Array(rows);
	}
	return arr;
}

function evaluar(i,j){
	var estado=array2[i][j];
	var cantidad_vivos=0;
	var cantidad_muertos=0;
	if (i==0){
		vecindad[0]=array2[tam-1][j];//superior
		vecindad[1]=array2[i+1][j];//inferior
		if (j==0){
			vecindad[2]=array2[tam-1][tam-1];//superior izquierdo
			vecindad[3]=array2[tam-1][j+1];//superior derecho
			vecindad[4]=array2[i][tam-1];//izquierdo
			vecindad[5]=array2[i][j+1];//derecho
			vecindad[6]=array2[i+1][tam-1];//inferior izquierdo
			vecindad[7]=array2[i+1][j+1];//inferior derecho
		}
		else if (j==tam-1){
			vecindad[2]=array2[tam-1][j-1];//superior izquierdo
			vecindad[3]=array2[tam-1][0];//superior derecho
			vecindad[4]=array2[i][j-1];//izquierdo
			vecindad[5]=array2[i][0];//derecho
			vecindad[6]=array2[i+1][j-1];//inferior izquierdo
			vecindad[7]=array2[i+1][0];//inferior derecho
		}
		else{
			vecindad[2]=array2[tam-1][j-1];//superior izquierdo
			vecindad[3]=array2[tam-1][j+1];//superior derecho
			vecindad[4]=array2[i][j-1];//izquierdo
			vecindad[5]=array2[i][j+1];//derecho
			vecindad[6]=array2[i+1][j-1];//inferior izquierdo
			vecindad[7]=array2[i+1][j+1];//inferior derecho
		}
	}
	else if (i==tam-1){
		vecindad[0]=array2[i-1][j];//superior
		vecindad[1]=array2[0][j];//inferior
		if (j==0){
			vecindad[2]=array2[i-1][tam-1];//superior izquierdo
			vecindad[3]=array2[i-1][j+1];//superior derecho
			vecindad[4]=array2[i][tam-1];//izquierdo
			vecindad[5]=array2[i][j+1];//derecho
			vecindad[6]=array2[0][tam-1];//inferior izquierdo
			vecindad[7]=array2[0][j+1];//inferior derecho
		}
		else if (j==tam-1){
			vecindad[2]=array2[i-1][j-1];//superior izquierdo
			vecindad[3]=array2[i-1][0];//superior derecho
			vecindad[4]=array2[i][j-1];//izquierdo
			vecindad[5]=array2[i][0];//derecho
			vecindad[6]=array2[0][j-1];//inferior izquierdo
			vecindad[7]=array2[0][0];//inferior derecho
		}
		else{
			vecindad[2]=array2[i-1][j-1];//superior izquierdo
			vecindad[3]=array2[i-1][j+1];//superior derecho
			vecindad[4]=array2[i][j-1];//izquierdo
			vecindad[5]=array2[i][j+1];//derecho
			vecindad[6]=array2[0][j-1];//inferior izquierdo
			vecindad[7]=array2[0][j+1];//inferior derecho
		}
	}
	else{
		vecindad[0]=array2[i-1][j];//superior
		vecindad[1]=array2[i+1][j];//inferior
		if (j==0){
			vecindad[2]=array2[i-1][tam-1];//superior izquierdo
			vecindad[3]=array2[i-1][j+1];//superior derecho
			vecindad[4]=array2[i][tam-1];//izquierdo
			vecindad[5]=array2[i][j+1];//derecho
			vecindad[6]=array2[i+1][tam-1];//inferior izquierdo
			vecindad[7]=array2[i+1][j+1];//inferior derecho
		}
		else if (j==tam-1){
			vecindad[2]=array2[i-1][j-1];//superior izquierdo
			vecindad[3]=array2[i-1][0];//superior derecho
			vecindad[4]=array2[i][j-1];//izquierdo
			vecindad[5]=array2[i][0];//derecho
			vecindad[6]=array2[i+1][j-1];//inferior izquierdo
			vecindad[7]=array2[i+1][0];//inferior derecho
		}
		else{
			vecindad[2]=array2[i-1][j-1];//superior izquierdo
			vecindad[3]=array2[i-1][j+1];//superior derecho
			vecindad[4]=array2[i][j-1];//izquierdo
			vecindad[5]=array2[i][j+1];//derecho
			vecindad[6]=array2[i+1][j-1];//inferior izquierdo
			vecindad[7]=array2[i+1][j+1];//inferior derecho
		}
	}
	for(var k=0;k<8;k++){
		if(vecindad[k]==1){
			cantidad_vivos++;
		}else{
			cantidad_muertos++;
		}
	}
	if(estado==1){
		if (!((cantidad_vivos >= regla1) && (cantidad_vivos <= regla2))){
			array[i][j]=0;
			numero_vivos--;
			numero_muertos++;
			ctx.fillStyle=color_muerto;
			ctx.fillRect(0+(j*(escala)),0+(i*(escala)),escala,escala);
		}
	}else{
		if ((cantidad_vivos >= regla3) && (cantidad_vivos <= regla4)){
			array[i][j]=1;
			numero_vivos++;
			numero_muertos--;
			ctx.fillStyle=color_vivo;
			ctx.fillRect(0+(j*(escala)),0+(i*(escala)),escala,escala);
		}
	}
	ctx.stroke();
}

function copiar(array){
	var aux=Create2DArray(tam);
	for(var i=0; i<tam;i++){
		for(var j=0;j<tam;j++){
			aux[i][j]=array[i][j];
		}
	}
	return aux;
}

function obtenerTamano(){
	tam = parseInt(document.getElementById("tam").value);
	//console.log(tam);
	array=Create2DArray(tam);
	array2=Create2DArray(tam);
	coordenadas=Create2DArray(tam);
	escala=longitud/tam;
}

function obtenerRegla(){
	regla1 = parseInt(document.getElementById("b1").value);
	regla2 = parseInt(document.getElementById("b2").value);
	regla3 = parseInt(document.getElementById("s1").value);
	regla4 = parseInt(document.getElementById("s2").value);
}

function obtenerDistribucion(){
	distribucion = parseInt(document.getElementById("distribucion").value)/100;
	distribucion = parseFloat(distribucion.toFixed(2));
}

function obtenerColores(){
	color_vivo=document.getElementById("color_vivo").value;
	color_muerto=document.getElementById("color_muerto").value;
}

function obtenerConfiguracion(){
	obtenerTamano();
	obtenerRegla();
	obtenerDistribucion();
	obtenerColores();
}

function limpiar(){
	ctx.clearRect(0, 0, ctx.width, ctx.height);
	console.clear();
	new Chart(chart,{});
	numero_vivos=0;
	numero_muertos=0;
	generacion=0;
	document.getElementById('generacion').innerHTML ="Generación: 0";
	generacion_grafica=[];
	vivos_grafica=[];
	log="";
}

function iniciar(){
	limpiar();
	obtenerConfiguracion();
	for (var i = 0; i < tam; i++) {
		for(var j=0;j<tam;j++){
			//Checamos la distribución
			if (Math.random() < distribucion){
				array[i][j]=1;
				array2[i][j]=1;
				ctx.fillStyle=color_vivo;
				numero_vivos++;
			}
			else{
				array[i][j]=0;
				array2[i][j]=0;
				ctx.fillStyle=color_muerto;
				numero_muertos++;
			}
			x=0+j*escala;
			y=0+i*escala;
			coordenadas[i][j]=x+","+y+","+(x+escala)+","+(y+escala);
			ctx.fillRect(0+(j*(escala)),0+(i*(escala)),escala,escala);
			ctx.stroke();
		}
	}
	generacion_grafica.push(generacion);
	vivos_grafica.push(numero_vivos);
	console.log(numero_vivos+","+generacion);
	log=numero_vivos+","+generacion+"\n";
}

function ejecutar(){
	obtenerRegla();
	obtenerColores();
	for(var i=0; i<tam;i++){
		for(var j=0;j<tam;j++){
			evaluar(i,j);
		}
	}
	array2=copiar(array);
	generacion++;
	generacion_grafica.push(generacion);
	vivos_grafica.push(numero_vivos);
	total_vivos+=numero_vivos;
	console.log(numero_vivos+","+generacion);
	document.getElementById('generacion').innerHTML ="Generación: "+generacion;
	log+=numero_vivos+","+generacion+"\n";
}

function continuar(){
	intervalo=setInterval(ejecutar, 0);
	intervalo2=setInterval(graficar, 1000);
}

function pausa(){
	clearInterval(intervalo);
	clearInterval(intervalo2);
}
function siguiente(){
	ejecutar();
	graficar();
}

function graficar(){
	new Chart(chart, {
		type: 'line',
		data: {
			labels: generacion_grafica,
			datasets: [{ 
				data: vivos_grafica,
				label: "Generación: "+generacion+"    Número de vivos: "+ numero_vivos+"    Promedio: "+(total_vivos/generacion)+"    Densidad: "+(total_vivos/generacion)/(tam*tam),
				borderColor: "red",
				fill: false
			}]
		},
		options: {
			title: {
				display: true,
				text: 'Gráfica de vivos'
			},
			elements: {
				line: {
					tension: 0, // disables bezier curves
				}
			},
			animation: {
				duration: 0, // general animation time
			},
			hover: {
				animationDuration: 0, // duration of animations when hovering an item
			},
			responsiveAnimationDuration: 0, // animation duration after a resize
			events: [], //Para que no se pueda interactuar con la gráfica
			maintainAspectRatio:true,
			responsive: true,
		}
	});
}

function obtenerCoordenadas(i,j){
	var texto=coordenadas[i][j];
	return texto.split(",");
}

function clickCanvas(event){
	x=event.offsetX;
	y=event.offsetY;
	// console.log(x + "," +y);
	for(var i=0;i<tam;i++){
		for(var j=0;j<tam;j++){
			var arr=obtenerCoordenadas(i,j);
			if(x >= arr[0] && x <= arr[2] && y >= arr[1] && y <= arr[3]){
				x=0+j*escala;
				y=0+i*escala;
				if(array[i][j]==0){
					array[i][j]=1;
					array2[i][j]=1;
					numero_vivos++;
					numero_muertos--;
					ctx.fillStyle=color_vivo;
				}else{
					array[i][j]=0;
					array2[i][j]=0;
					numero_vivos--;
					numero_muertos++;
					ctx.fillStyle=color_muerto;
				}
				ctx.fillRect(x,y,escala,escala);
				ctx.stroke();
				//console.log("Soy: i:"+i+" j:"+j);
				console.log("Número vivos: "+numero_vivos);
				break;
			}
		}
	}
}

//iniciar();
