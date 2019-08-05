var c=document.getElementById("myCanvas");
var chart = document.getElementById("myChart");
var chart2=document.getElementById("myChart2");
var ctx=c.getContext("2d");
var longitud=680;
var tam=100;
var escala=longitud/tam;
var random;
var generacion=0;
var numero_blancos=0;
var numero_negros=0;
var numero_hormigas=0;
var numero_reinas=0;
var numero_soldados=0;
var numero_obreras=0;
var intervalo;
var log;
var array;
var array2;
var x;
var y;
var coordenadas;
var hormigas;
var hormigas2;
var direccion;
var direccion2;
var matar;
var generacion_grafica=[];
var obreras_grafica=[];
var soldados_grafica=[];
var reinas_grafica=[];
var hormigas_grafica=[];
var color_negro='#000000';
var color_blanco='#ffffff';
var color_norte='#ff0000';
var color_este='#ffff00';
var color_sur='#0000ff';
var color_oeste='#00cc00';
var color_reina="#3366ff";
var color_soldado="#66ff33";
var color_obrera=color_blanco;
var probabilidad=.05;
var colores_direcciones=[color_norte,color_este,color_sur,color_oeste];

//1-> Obrera
//2-> Soldado
//3-> Reina
var tipos_hormiga=[1,2,3];
var colores=[color_obrera,color_soldado,color_reina];
var probabilidades_hormiga=[.9,.08,.02];
probabilidades_hormiga.sort(function(a, b){return b-a});

//Modificar valor del slider en pantalla
document.getElementById("distribucion_valor").innerHTML = document.getElementById("distribucion").value;
document.getElementById("distribucion").oninput = function(e) {
	e.preventDefault();
	document.getElementById("distribucion_valor").innerHTML = this.value;
}

//Direcciones:
//0->norte, 1->este, 2->sur, 3->oeste

//Función para descargar
function descargar(){
	var fileContents = log;
	var fileName = "log.txt";
	var pp = document.createElement('a');
	pp.setAttribute('href', 'data:text/plain;charset=utf-8,' + encodeURIComponent(fileContents));
	pp.setAttribute('download', fileName);
	pp.click();
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
	if(hormigas2[i][j].length>0){
		if(hormigas2[i][j].length==2){
			if((hormigas2[i][j][0]==2 && hormigas2[i][j][1]==3) || (hormigas2[i][j][0]==3 && hormigas2[i][j][1]==2)){
				//Hacemos que nazca una nueva hormiga
				random=Math.floor((Math.random() * 4) + 0);
				numero_hormigas++;
				direccion[i][j].push(random);
				direccion2[i][j].push(random);
				obtenerTipoHormiga(i,j);
				matar[i][j]=0;
			}
		}
		for(var k=0;k<hormigas2[i][j].length;k++){
			var tipo_hormiga=hormigas[i][j].splice(0, 1);
			direccion[i][j].splice(0, 1);
			//Blanco
			if(estado==1){
				if(k==0){
					numero_negros++;
				}
				array[i][j]=0;
				if(hormigas[i][j].length<1){
					ctx.clearRect(0+(j*(escala)),0+(i*(escala)),escala,escala);
					ctx.fillStyle=color_negro;//Negro
					ctx.fillRect(0+(j*(escala)),0+(i*(escala)),escala,escala);
					ctx.stroke();
				}
				if(direccion2[i][j][k]==0){
					if(j==0){
						hormigas[i][tam-1].push(tipo_hormiga);
						direccion[i][tam-1].push(3);
						ctx.clearRect(0+((tam-1)*(escala)),0+(i*(escala)),escala,escala);
						ctx.fillStyle=color_oeste;
						ctx.fillRect(0+((tam-1)*(escala)),0+(i*(escala)),escala,escala);
					}else{
						hormigas[i][j-1].push(tipo_hormiga);
						direccion[i][j-1].push(3);
						ctx.clearRect(0+((j-1)*(escala)),0+(i*(escala)),escala,escala);
						ctx.fillStyle=color_oeste;
						ctx.fillRect(0+((j-1)*(escala)),0+(i*(escala)),escala,escala);
					}
					ctx.stroke();
				}else if(direccion2[i][j][k]==1){
					if(i==0){
						hormigas[tam-1][j].push(tipo_hormiga);
						direccion[tam-1][j].push(0);
						ctx.clearRect(0+((j)*(escala)),0+((tam-1)*(escala)),escala,escala);
						ctx.fillStyle=color_norte;
						ctx.fillRect(0+((j)*(escala)),0+((tam-1)*(escala)),escala,escala);
					}else{
						hormigas[i-1][j].push(tipo_hormiga);
						direccion[i-1][j].push(0);
						ctx.clearRect(0+((j)*(escala)),0+((i-1)*(escala)),escala,escala);
						ctx.fillStyle=color_norte;
						ctx.fillRect(0+((j)*(escala)),0+((i-1)*(escala)),escala,escala);
					}
					ctx.stroke();
				}else if(direccion2[i][j][k]==2){
					if(j==tam-1){
						hormigas[i][0].push(tipo_hormiga);
						direccion[i][0].push(1);
						ctx.clearRect(0+((0)*(escala)),0+((i)*(escala)),escala,escala);
						ctx.fillStyle=color_este;
						ctx.fillRect(0+((0)*(escala)),0+((i)*(escala)),escala,escala);
					}else{
						hormigas[i][j+1].push(tipo_hormiga);
						direccion[i][j+1].push(1);
						ctx.clearRect(0+((j+1)*(escala)),0+((i)*(escala)),escala,escala);
						ctx.fillStyle=color_este;
						ctx.fillRect(0+((j+1)*(escala)),0+((i)*(escala)),escala,escala);
					}
					ctx.stroke();
				}else if(direccion2[i][j][k]==3){
					if(i==tam-1){
						hormigas[0][j].push(tipo_hormiga);
						direccion[0][j].push(2);
						ctx.clearRect(0+((j)*(escala)),0+((0)*(escala)),escala,escala);
						ctx.fillStyle=color_sur;
						ctx.fillRect(0+((j)*(escala)),0+((0)*(escala)),escala,escala);
					}else{
						hormigas[i+1][j].push(tipo_hormiga);
						direccion[i+1][j].push(2);
						ctx.clearRect(0+((j)*(escala)),0+((i+1)*(escala)),escala,escala);
						ctx.fillStyle=color_sur;
						ctx.fillRect(0+((j)*(escala)),0+((i+1)*(escala)),escala,escala);
					}
					ctx.stroke();
				}
			}else{//Negro
				if(k==0){
					numero_negros--;
				}
				array[i][j]=1;
				if(hormigas[i][j].length<1){
					ctx.clearRect(0+(j*(escala)),0+(i*(escala)),escala,escala);
					//Aquí se pinta dependiendo del tipo de hormiga
					ctx.fillStyle=colores[tipo_hormiga-1];//Color correspondiente
					ctx.fillRect(0+(j*(escala)),0+(i*(escala)),escala,escala);
					ctx.stroke();
				}
				if(direccion2[i][j][k]==0){
					if(j==tam-1){
						hormigas[i][0].push(tipo_hormiga);
						direccion[i][0].push(1);
						ctx.clearRect(0+((0)*(escala)),0+(i*(escala)),escala,escala);
						ctx.fillStyle=color_este;
						ctx.fillRect(0+((0)*(escala)),0+(i*(escala)),escala,escala);
					}else{
						hormigas[i][j+1].push(tipo_hormiga);
						direccion[i][j+1].push(1);
						ctx.clearRect(0+((j+1)*(escala)),0+(i*(escala)),escala,escala);
						ctx.fillStyle=color_este;
						ctx.fillRect(0+((j+1)*(escala)),0+(i*(escala)),escala,escala);
					}
					ctx.stroke();
				}else if(direccion2[i][j][k]==1){
					if(i==tam-1){
						hormigas[0][j].push(tipo_hormiga);
						direccion[0][j].push(2);
						ctx.clearRect(0+((j)*(escala)),0+((0)*(escala)),escala,escala);
						ctx.fillStyle=color_sur;
						ctx.fillRect(0+((j)*(escala)),0+((0)*(escala)),escala,escala);
					}else{
						hormigas[i+1][j].push(tipo_hormiga);
						direccion[i+1][j].push(2);
						ctx.clearRect(0+((j)*(escala)),0+((i+1)*(escala)),escala,escala);
						ctx.fillStyle=color_sur;
						ctx.fillRect(0+((j)*(escala)),0+((i+1)*(escala)),escala,escala);
					}
					ctx.stroke();
				}else if(direccion2[i][j][k]==2){
					if(j==0){
						hormigas[i][tam-1].push(tipo_hormiga);
						direccion[i][tam-1].push(3);
						ctx.clearRect(0+((tam-1)*(escala)),0+((i)*(escala)),escala,escala);
						ctx.fillStyle=color_oeste;
						ctx.fillRect(0+((tam-1)*(escala)),0+((i)*(escala)),escala,escala);
					}else{
						hormigas[i][j-1].push(tipo_hormiga);
						direccion[i][j-1].push(3);
						ctx.clearRect(0+((j-1)*(escala)),0+((i)*(escala)),escala,escala);
						ctx.fillStyle=color_oeste;
						ctx.fillRect(0+((j-1)*(escala)),0+((i)*(escala)),escala,escala);
					}
					ctx.stroke();
				}else if(direccion2[i][j][k]==3){
					if(i==0){
						hormigas[tam-1][j].push(tipo_hormiga);
						direccion[tam-1][j].push(0);
						ctx.clearRect(0+((j)*(escala)),0+((tam-1)*(escala)),escala,escala);
						ctx.fillStyle=color_norte;
						ctx.fillRect(0+((j)*(escala)),0+((tam-1)*(escala)),escala,escala);
					}else{
						hormigas[i-1][j].push(tipo_hormiga);
						direccion[i-1][j].push(0);
						ctx.clearRect(0+((j)*(escala)),0+((i-1)*(escala)),escala,escala);
						ctx.fillStyle=color_norte;
						ctx.fillRect(0+((j)*(escala)),0+((i-1)*(escala)),escala,escala);
					}
					ctx.stroke();
				}
			}
		}
	}
}

function copiar(arr){
	var aux=Create2DArray(tam);
	for(var i=0; i<tam;i++){
		for(var j=0;j<tam;j++){
			aux[i][j]=arr[i][j];
		}
	}
	return aux;
}

function copiar2(arr){
	var aux=Create2DArray(tam);
	for(var i=0; i<tam;i++){
		for(var j=0;j<tam;j++){
			aux[i][j]=[];
			for(var k=0;k<arr[i][j].length;k++){
				aux[i][j][k]=arr[i][j][k];
			}
		}
	}
	return aux;
}

function obtenerTamano(){
	tam = parseInt(document.getElementById("tam").value);
	escala=longitud/tam;
	array=Create2DArray(tam);
	array2=Create2DArray(tam);
	hormigas=Create2DArray(tam);
	hormigas2=Create2DArray(tam);
	coordenadas=Create2DArray(tam);
	direccion=Create2DArray(tam);
	direccion2=Create2DArray(tam);
	matar=Create2DArray(tam);
	vida=Create2DArray(tam);
	for(var i=0;i<tam;i++){
		for(var j=0;j<tam;j++){
			hormigas[i][j]=[];
			hormigas2[i][j]=[];
			direccion[i][j]=[];
			direccion2[i][j]=[];
		}
	}
}

function obtenerDistribucion(){
	probabilidad = parseInt(document.getElementById("distribucion").value)/100;
	probabilidad = parseFloat(probabilidad.toFixed(2));
}

function obtenerProbas(){
	probabilidades_hormiga[0] = parseInt(document.getElementById("obrera").value)/100;
	probabilidades_hormiga[0] = parseFloat(probabilidades_hormiga[0].toFixed(2));
	probabilidades_hormiga[1] = parseInt(document.getElementById("soldado").value)/100;
	probabilidades_hormiga[1] = parseFloat(probabilidades_hormiga[1].toFixed(2));
	probabilidades_hormiga[2] = parseInt(document.getElementById("reina").value)/100;
	probabilidades_hormiga[2] = parseFloat(probabilidades_hormiga[2].toFixed(2));
}

function obtenerConfiguracion(){
	obtenerTamano();
	obtenerDistribucion();
	obtenerProbas();
}

function limpiar(){
	ctx.clearRect(0, 0, ctx.width, ctx.height);
	console.clear();
	generacion=0;
	numero_blancos=0;
	numero_negros=0;
	numero_hormigas=0;
	numero_reinas=0;
	numero_soldados=0;
	numero_obreras=0;
	log="";
	document.getElementById('generacion').innerHTML ="Generación: 0";
}

function iniciar(){
	limpiar();
	obtenerConfiguracion();
	for (var i = 0; i < tam; i++){
		for(var j=0;j<tam;j++){
			hormigas[i][j]=[];
			hormigas2[i][j]=[];
			direccion[i][j]=[];
			direccion2[i][j]=[];
			vida[i][j]=[];
			ctx.fillStyle=obtenerTipoCasilla(i,j);
			x=0+j*escala;
			y=0+i*escala;
			coordenadas[i][j]=x+","+y+","+(x+escala)+","+(y+escala);
			ctx.fillRect(x,y,escala,escala);
			ctx.stroke();
			//console.log(numero_negros+","+generacion);
			log=numero_negros+","+generacion+"\n";
		}
	}
	console.log("Generación: "+generacion);
	console.log("Número negras: "+numero_negros);
	console.log("Número hormigas: "+numero_hormigas);
	console.log("Número obreras: "+numero_obreras);
	console.log("Número soldados: "+numero_soldados);
	console.log("Número reinas: "+numero_reinas);
}

function obtenerTipoCasilla(i,j){
	var num=Math.random();
	if(num <= probabilidad) {
		random=Math.floor((Math.random() * 4) + 0);
		numero_hormigas++;
		array[i][j]=1;
		array2[i][j]=1;
		direccion[i][j].push(random);
		direccion2[i][j].push(random);
		matar[i][j]=0;
		obtenerTipoHormiga(i,j);
		return colores_direcciones[random];
	}
	else{
		numero_negros++;
		array[i][j]=0;
		array2[i][j]=0;
		return color_negro;
	}
}

function obtenerTipoHormiga(i,j){
	var num=Math.random();
	if(num<=probabilidades_hormiga[0]){
		numero_obreras++;
		hormigas[i][j].push(tipos_hormiga[0]);
		hormigas2[i][j].push(tipos_hormiga[0]);
	}else if(num<=probabilidades_hormiga[0]+probabilidades_hormiga[1]){
		numero_soldados++;
		hormigas[i][j].push(tipos_hormiga[1]);
		hormigas2[i][j].push(tipos_hormiga[1]);
	}else{
		numero_reinas++;
		hormigas[i][j].push(tipos_hormiga[2]);
		hormigas2[i][j].push(tipos_hormiga[2]);
	}
}

function ejecutar(){
	generacion_grafica.push(generacion);
	hormigas_grafica.push(numero_hormigas);
	obreras_grafica.push(numero_obreras);
	soldados_grafica.push(numero_soldados);
	reinas_grafica.push(numero_reinas);
	generacion++;
	for(var i=0; i<tam;i++){
		for(var j=0;j<tam;j++){
			evaluar(i,j);
		}
	}
	console.log(numero_negros+","+generacion);
	document.getElementById('generacion').innerHTML ="Generación: "+generacion;
	log+=numero_negros+","+generacion+"\n";
	array2=copiar(array);
	hormigas2=copiar2(hormigas);
	direccion2=copiar2(direccion);
}

function continuar(){
	intervalo=setInterval(ejecutar, 10);
	intervalo2=setInterval(graficar, 1000);
	intervalo3=setInterval(graficar2, 1000);
}

function pausa(){
	clearInterval(intervalo);
	clearInterval(intervalo2);
	clearInterval(intervalo3);
}
function siguiente(){
	ejecutar();
	graficar();
	graficar2();
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
				if(hormigas2[i][j].length<1){
					console.log("Soy:"+i+","+j);
					random=Math.floor((Math.random() * 4) + 0);
					// random=3;
					numero_hormigas++;
					numero_negros--;
					hormigas[i][j].push(1);
					hormigas2[i][j].push(1);
					direccion[i][j].push(random);
					direccion2[i][j].push(random);
					matar[i][j]=0;
					if(random==0){
						//Norte -> Rojo
						ctx.fillStyle=color_norte;
						
					}else if(random==1){
						//Este -> Amarillo
						ctx.fillStyle=color_este;
					}else if(random==2){
						//Sur -> Azul
						ctx.fillStyle=color_sur;
					}else{
						//Oeste -> Verde
						ctx.fillStyle=color_oeste;
					}
				}else{
					if(matar[i][j]==4){
						hormigas[i][j].pop();
						hormigas2[i][j].pop();
						direccion[i][j].pop();
						direccion2[i][j].pop();
						ctx.fillStyle=color_negro;
						matar[i][j]=0;
					}else if(direccion[i][j][0]==0){
						direccion[i][j][0]=1;
						direccion2[i][j][0]=1;
						ctx.fillStyle=color_este;
						matar[i][j]++;
					}else if(direccion[i][j][0]==1){
						direccion[i][j][0]=2;
						direccion2[i][j][0]=2;
						ctx.fillStyle=color_sur;
						matar[i][j]++;
					}else if(direccion[i][j][0]==2){
						direccion[i][j][0]=3;
						direccion2[i][j][0]=3;
						ctx.fillStyle=color_oeste;
						matar[i][j]++;
					}else if(direccion[i][j][0]==3){
						direccion[i][j][0]=0;
						direccion2[i][j][0]=0;
						ctx.fillStyle=color_norte;
						matar[i][j]++;
					}
				}
				ctx.fillRect(x,y,escala,escala);
				ctx.stroke();
				break;
			}
		}
	}
}

function graficar(){
	new Chart(chart, {
		type: 'line',
		data: {
			labels: generacion_grafica,
			datasets: [{ 
				data: hormigas_grafica,
				label: "Generación: "+generacion+"    Número de hormigas: "+ numero_hormigas,
				borderColor: "red",
				fill: false
			}]
		},
		options: {
			title: {
				display: true,
				text: 'Cantidad de hormigas'
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

function graficar2(){
	new Chart(chart2, {
		type: 'line',
		data: {
			labels: generacion_grafica,
			datasets: [
				{ 
					data: obreras_grafica,
					label: "Obreras: "+numero_obreras,
					borderColor: "red",
					fill: false
				},
				{
					data: soldados_grafica,
					label: "Soldados: "+numero_soldados,
					borderColor: "blue",
					fill: false
				},
				{
					data: reinas_grafica,
					label: "Reinas: "+numero_reinas,
					borderColor: "green",
					fill: false
				}
			]
		},
		options: {
			title: {
				display: true,
				text: 'Cantidad de hormigas'
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