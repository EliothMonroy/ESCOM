var c=document.getElementById("myCanvas");
var ctx=c.getContext("2d");
var longitud=680;
var tam=100;
var escala=longitud/tam;
var random;
var generacion=0;
var numero_blancos=0;
var numero_negros=0;
var numero_hormigas=0;
var distribucion=50;
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
var color_negro='#000000';
var color_blanco='#ffffff';
var color_norte='#ff0000';
var color_este='#ffff00';
var color_sur='#0000ff';
var color_oeste='#00cc00';

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
	if(hormigas2[i][j].length>0){
		for(var k=0;k<hormigas2[i][j].length;k++){
			hormigas[i][j].splice(0, 1);
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
						hormigas[i][tam-1].push(1);
						direccion[i][tam-1].push(3);
						ctx.clearRect(0+((tam-1)*(escala)),0+(i*(escala)),escala,escala);
						ctx.fillStyle=color_oeste;
						ctx.fillRect(0+((tam-1)*(escala)),0+(i*(escala)),escala,escala);
					}else{
						hormigas[i][j-1].push(1);
						direccion[i][j-1].push(3);
						ctx.clearRect(0+((j-1)*(escala)),0+(i*(escala)),escala,escala);
						ctx.fillStyle=color_oeste;
						ctx.fillRect(0+((j-1)*(escala)),0+(i*(escala)),escala,escala);
					}
					ctx.stroke();
				}else if(direccion2[i][j][k]==1){
					if(i==0){
						hormigas[tam-1][j].push(1);
						direccion[tam-1][j].push(0);
						ctx.clearRect(0+((j)*(escala)),0+((tam-1)*(escala)),escala,escala);
						ctx.fillStyle=color_norte;
						ctx.fillRect(0+((j)*(escala)),0+((tam-1)*(escala)),escala,escala);
					}else{
						hormigas[i-1][j].push(1);
						direccion[i-1][j].push(0);
						ctx.clearRect(0+((j)*(escala)),0+((i-1)*(escala)),escala,escala);
						ctx.fillStyle=color_norte;
						ctx.fillRect(0+((j)*(escala)),0+((i-1)*(escala)),escala,escala);
					}
					ctx.stroke();
				}else if(direccion2[i][j][k]==2){
					if(j==tam-1){
						hormigas[i][0].push(1);
						direccion[i][0].push(1);
						ctx.clearRect(0+((0)*(escala)),0+((i)*(escala)),escala,escala);
						ctx.fillStyle=color_este;
						ctx.fillRect(0+((0)*(escala)),0+((i)*(escala)),escala,escala);
					}else{
						hormigas[i][j+1].push(1);
						direccion[i][j+1].push(1);
						ctx.clearRect(0+((j+1)*(escala)),0+((i)*(escala)),escala,escala);
						ctx.fillStyle=color_este;
						ctx.fillRect(0+((j+1)*(escala)),0+((i)*(escala)),escala,escala);
					}
					ctx.stroke();
				}else if(direccion2[i][j][k]==3){
					if(i==tam-1){
						hormigas[0][j].push(1);
						direccion[0][j].push(2);
						ctx.clearRect(0+((j)*(escala)),0+((0)*(escala)),escala,escala);
						ctx.fillStyle=color_sur;
						ctx.fillRect(0+((j)*(escala)),0+((0)*(escala)),escala,escala);
					}else{
						hormigas[i+1][j].push(1);
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
					ctx.fillStyle=color_blanco;//Blanco
					ctx.fillRect(0+(j*(escala)),0+(i*(escala)),escala,escala);
					ctx.stroke();
				}
				if(direccion2[i][j][k]==0){
					if(j==tam-1){
						hormigas[i][0].push(1);
						direccion[i][0].push(1);
						ctx.clearRect(0+((0)*(escala)),0+(i*(escala)),escala,escala);
						ctx.fillStyle=color_este;
						ctx.fillRect(0+((0)*(escala)),0+(i*(escala)),escala,escala);
					}else{
						hormigas[i][j+1].push(1);
						direccion[i][j+1].push(1);
						ctx.clearRect(0+((j+1)*(escala)),0+(i*(escala)),escala,escala);
						ctx.fillStyle=color_este;
						ctx.fillRect(0+((j+1)*(escala)),0+(i*(escala)),escala,escala);
					}
					ctx.stroke();
				}else if(direccion2[i][j][k]==1){
					if(i==tam-1){
						hormigas[0][j].push(1);
						direccion[0][j].push(2);
						ctx.clearRect(0+((j)*(escala)),0+((0)*(escala)),escala,escala);
						ctx.fillStyle=color_sur;
						ctx.fillRect(0+((j)*(escala)),0+((0)*(escala)),escala,escala);
					}else{
						hormigas[i+1][j].push(1);
						direccion[i+1][j].push(2);
						ctx.clearRect(0+((j)*(escala)),0+((i+1)*(escala)),escala,escala);
						ctx.fillStyle=color_sur;
						ctx.fillRect(0+((j)*(escala)),0+((i+1)*(escala)),escala,escala);
					}
					ctx.stroke();
				}else if(direccion2[i][j][k]==2){
					if(j==0){
						hormigas[i][tam-1].push(1);
						direccion[i][tam-1].push(3);
						ctx.clearRect(0+((tam-1)*(escala)),0+((i)*(escala)),escala,escala);
						ctx.fillStyle=color_oeste;
						ctx.fillRect(0+((tam-1)*(escala)),0+((i)*(escala)),escala,escala);
					}else{
						hormigas[i][j-1].push(1);
						direccion[i][j-1].push(3);
						ctx.clearRect(0+((j-1)*(escala)),0+((i)*(escala)),escala,escala);
						ctx.fillStyle=color_oeste;
						ctx.fillRect(0+((j-1)*(escala)),0+((i)*(escala)),escala,escala);
					}
					ctx.stroke();
				}else if(direccion2[i][j][k]==3){
					if(i==0){
						hormigas[tam-1][j].push(1);
						direccion[tam-1][j].push(0);
						ctx.clearRect(0+((j)*(escala)),0+((tam-1)*(escala)),escala,escala);
						ctx.fillStyle=color_norte;
						ctx.fillRect(0+((j)*(escala)),0+((tam-1)*(escala)),escala,escala);
					}else{
						hormigas[i-1][j].push(1);
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
	distribucion = parseInt(document.getElementById("distribucion").value)/100;
	distribucion = parseFloat(distribucion.toFixed(2));
}

function obtenerConfiguracion(){
	obtenerTamano();
	obtenerDistribucion();
}

function limpiar(){
	ctx.clearRect(0, 0, ctx.width, ctx.height);
	console.clear();
	generacion=0;
	numero_blancos=0;
	numero_negros=0;
	numero_hormigas=0;
	log="";
	document.getElementById('generacion').innerHTML ="Generación: 0";
}

function iniciar(){
	limpiar();
	obtenerConfiguracion();
	for (var i = 0; i < tam; i++) {
		for(var j=0;j<tam;j++){
			// random=Math.floor((Math.random() * 2) + 0);
			if (Math.random() < distribucion){
				random=Math.floor((Math.random() * 4) + 0);
				// random=3;
				array[i][j]=1;
				array2[i][j]=1;
				numero_hormigas++;
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
			}
			else{
				array[i][j]=0;
				array2[i][j]=0;
				ctx.fillStyle=color_negro;
				numero_negros++;
			}
			x=0+j*escala;
			y=0+i*escala;
			coordenadas[i][j]=x+","+y+","+(x+escala)+","+(y+escala);
			ctx.fillRect(x,y,escala,escala);
			ctx.stroke();
		}
	}
	console.log(numero_negros+","+generacion);
	log=numero_negros+","+generacion+"\n";
	document.getElementById('vivas').innerHTML ="Total de hormigas: "+numero_hormigas;
}

function ejecutar(){
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
}

function pausa(){
	clearInterval(intervalo);
}
function siguiente(){
	ejecutar();
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
						numero_hormigas--;
						numero_negros++;
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
	document.getElementById('vivas').innerHTML ="Total de hormigas: "+numero_hormigas;
}