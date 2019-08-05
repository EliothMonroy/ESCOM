var hexas;
var contador=1;
var combinacion=[];
class LineaHexa{
	constructor(tipo){
		this.tipo=tipo;
		this.lineas={
			// 6:"<hr style='width:50px, height:10px'>X<hr style='width:50px, height:10px'>",
			6:"_______x_______",
			7:"_______________",
			8:"_______ _______",
			9:"<span style='text-decoration: underline; white-space: pre;'>            o            </span>"
		};
	}
	get obtenerTipo(){
		return this.tipo;
	}
	get obtenerLinea(){
		return this.lineas[this.tipo];
	}
}

class Hexagrama{
	constructor(clave){
		this.clave=clave;
		this.combinaciones={
			"777777":"1. Ch'ien.",
			"888888":"2. K'un.",
			"788878":"3. Chun.",
			"878887":"4. Meng.",
			"777878":"5. Hsü.",
			"878777":"6. Sung.",
			"878888":"7. Shih.",
			"888878":"8. Pi",
			"777877":"9. Hsiao Ch'u",
			"778777":"10. Lü",
			"777888":"11. T'ai",
			"888777":"12. P'i",
			"787777":"13. T'ung Jen",
			"777787":"14. Ta Yu",
			"887888":"15. Ch'ien",
			"888788":"16. Yü",
			"788778":"17. Sui",
			"877887":"18. Ku",
			"778888":"19. Lin",
			"888877":"20. Kuan",
			"788787":"21. Shih Ho",
			"787887":"22. Pi",
			"888887":"23. Po",
			"788888":"24. Fu",
			"788777":"25. Wu Wang",
			"777887":"26. Ta Chu'u",
			"788887":"27. I",
			"877778":"28. Ta Kuo",
			"878878":"29. K'an",
			"787787":"30. Li",
			"887778":"31. Hsien",
			"877788":"32. Heng",
			"887777":"33. Tun",
			"777788":"34. Ta Chuang",
			"888787":"35. Chin",
			"787888":"36. Ming I",
			"778787":"37. Chian Jen",
			"778787":"38. K'uei",
			"887878":"39. Chien",
			"878788":"40. Hsieh",
			"778887":"41. Sun",
			"788877":"42. I",
			"777778":"43. Kuai",
			"877777":"44. Kou",
			"888778":"45. Ts'ui",
			"877888":"46. Sheng",
			"878778":"47. K'un",
			"877878":"48. Ching",
			"787778":"49. Ko",
			"877787":"50. Ting",
			"788788":"51. Chen",
			"887887":"52. Ken",
			"887877":"53. Chien",
			"778788":"54. Kuei Mei",
			"787788":"55. Feng",
			"887787":"56. Lü",
			"877877":"57. Sun",
			"778778":"58. Tui",
			"878877":"59. Huan",
			"778878":"60. Chieh",
			"778877":"61. Chung Fu",
			"887788":"62. Hsiao Kuo",
			"787878":"63. Chi Chi",
			"878787":"64. Wei Chi"
		};
		this.descripciones={
			"777777":"Cielo. Lo creativo. El principio generador",
			"888888":"Tierra. Lo receptivo. El principio pasivo",
			"788878":"Acumular. El obstáculo inicial. La dificultad del comienzo",
			"878887":"Juventud. El joven necio. La inmadurez.",
			"777878":"Esperar. La espera. La maduración.",
			"878777":"Disputar. El conflicto. El pleito.",
			"878888":"Ejército. La legión.",
			"888878":"Solidaridad. La unión",
			"777877":"Animalito doméstico. La pequeña fuerza",
			"778777":"Caminar. El porte. El paso cauteloso",
			"777888":"Prosperidad. La paz. La armonía.",
			"888777":"Cierre. El estancamiento. Lo inerte.",
			"787777":"Hombres Reunidos. La unión comunitaria",
			"777787":"Gran dominio. La gran posesión. Lo que se tiene de más.",
			"887888":"Condescendencia. La modestia. La humildad",
			"888788":"Ocuparse. El entusiasmo. La algarabía.",
			"788778":"Conformarse. La continuidad. El seguimiento.",
			"877887":"Conformarse. La continuidad. El seguimiento.",
			"778888":"Acercarse. Lo que va llegando.",
			"888877":"Observar. La contemplación.",
			"788787":"Quebrar mordiendo. La dentellada. La filosa mordedura",
			"787887":"Adornar. La elegancia. La gracia.",
			"888887":"Resquebrajar. La desintegración. El derrumbe",
			"788888":"Regresar. El retorno. Lo que vuelve.",
			"788777":"Sinceridad. La inocencia. La naturalidad.",
			"777887":"Fuerza educadora. El poder de lo fuerte. La gran acumulación.",
			"788887":"Fuerza educadora. El poder de lo fuerte. La gran acumulación.",
			"877778":"Excesos. La preponderancia de lo grande.",
			"878878":"Peligro. Lo abismal. La caida.",
			"787787":"Distinguir. El resplandor. Lo adherente.",
			"887778":"Unir. La influencia.La atracción.",
			"877788":"Luna Creciente. La duración. La permanencia.",
			"887777":"Retirarse. EL repliegue.",
			"777788":"Gran fuerza. El gran vigor.",
			"888787":"Progresar. El avance.",
			"787888":"Luz que se apaga. El oscurecimiento.",
			"778787":"Gente de familia. El clan.",
			"778787":"Contraste. La oposición. El antagonismo.",
			"887878":"Dificultad. El obstáculo. El impedimento.",
			"878788":"Explicar. La liberación. El alivio.",
			"778887":"Perder. La disminución.",
			"788877":"Evolución. El aumento. La ganancia.",
			"777778":"Decidir. El desbordamiento. La resolución.",
			"877777":"Encontrarse. El acoplamiento.",
			"888778":"Cosechar. La reunión. La convergencia.",
			"877888":"Subir. El ascenso. La escalada.",
			"878778":"Angustia. La pesadumbre. El agotamiento.",
			"877878":"El pozo de agua. La fuente.",
			"787778":"Renovar. La revolución. El cambio",
			"877787":"La caldera. Lo alquímico",
			"788788":"Trueno. La conmoción. Lo suscitativo.",
			"887887":"Cimientos. La quietud. La detención.",
			"887877":"Evolución. El progreso gradual.",
			"778788":"Desposar a la hija menor. La doncella.",
			"787788":"Abundancia. La plenitud.",
			"887787":"Viajero. El andariego",
			"877877":"Viento. Lo penetrante. Lo suave.",
			"778778":"Recogerse. La serenidad. La satisfacción.",
			"878877":"Confusión. La dispersión. La disolución",
			"778878":"Moderación. La restricción. La limitación",
			"778877":"Fe Interior. La verdad interior. La sinceridad interna.",
			"887788":"Pequeñas cosas importantes. La pequeña preponderancia.",
			"787878":"Conclusiones. Después de la realización.",
			"878787":"Inconcluso. Antes de la realización."
		};
	}
	get obtenerNombre(){
		return this.combinaciones[this.clave];
	}
	get obtenerDescripcion(){
		return this.descripciones[this.clave];
	}
}

function addResaltar(id){
	var elemento=document.getElementById("f"+id);
	elemento.classList.add("resaltar");
}

function quitarResaltar(){
	var tabla=document.getElementsByTagName("figure");
	for(var i=0;i<tabla.length;i++){
		if(tabla[i].classList.contains("resaltar")){
			tabla[i].classList.remove("resaltar");
			tabla[i].classList.remove("sin-resaltar");
		}
	}
}

function obtenerEquivalente1(combinacion){
	return combinacion.replace(/6/g, "8").replace(/9/g, "7");
}

function obtenerEquivalente2(combinacion){
	return combinacion.replace(/6/g, "7").replace(/9/g, "8");
}

function addTitulo(contenedor,texto){
	var conte=document.getElementById(contenedor);
	conte.innerHTML=texto;
	conte.classList.add("revelar-texto");
}

function borrarTitulo(contenedor){
	var conte=document.getElementById(contenedor);
	conte.innerHTML="";
	conte.classList.remove("revelar-texto");
}

function addDescripcion(contenedor,texto){
	var conte=document.getElementById(contenedor);
	conte.innerHTML=texto;
}

function borrarDescripcion(contenedor){
	var conte=document.getElementById(contenedor);
	conte.innerHTML="";
}

function mostrarDescripcion(contenedor){
	var conte=document.getElementById(contenedor);
	conte.classList.add("revelar-texto");
}

function quitarDescripcion(contenedor){
	var conte=document.getElementById(contenedor);
	conte.style.opacity=0;
	conte.classList.remove("revelar-texto");
}

function borrar(){
	if(contador>1){
		contador--;
		var contenedor=document.getElementById("contenedor1");
		var elemento=contenedor.lastChild;
		combinacion.pop();
		elemento.classList.add("ocultar-texto");
		contenedor.removeChild(elemento);

		contenedor=document.getElementById("contenedor2");
		while(contenedor.lastChild){
			contenedor.removeChild(contenedor.lastChild);
		}
		var titulo=document.createElement("div");
		titulo.id="titulo2";
		contenedor.appendChild(titulo);

		contenedor=document.getElementById("contenedor3");
		while(contenedor.lastChild){
			contenedor.removeChild(contenedor.lastChild);
		}
		titulo=document.createElement("div");
		titulo.id="titulo3";
		contenedor.appendChild(titulo);

		borrarTitulo("titulo1");
		addDescripcion("uno","Aún no soy un hexagrama :/");
		borrarDescripcion("dos");
		borrarDescripcion("tres");
		quitarResaltar();
	}else{
		alert("Para poder borrar una linea, primero debes agregar una");
	}
}

function borrarTodo(){
	if(contador>1){
		var contenedor=document.getElementById("contenedor1");
		while(contador>1){
			contador--;
			combinacion.pop();
			var elemento=contenedor.lastChild;
			contenedor.removeChild(elemento);
		}
		contenedor=document.getElementById("contenedor2");
		while(contenedor.lastChild){
			contenedor.removeChild(contenedor.lastChild);
		}
		var titulo=document.createElement("div");
		titulo.id="titulo2";
		contenedor.appendChild(titulo);

		contenedor=document.getElementById("contenedor3");
		while(contenedor.lastChild){
			contenedor.removeChild(contenedor.lastChild);
		}
		titulo=document.createElement("div");
		titulo.id="titulo3";
		contenedor.appendChild(titulo);

		borrarTitulo("titulo1");
		addDescripcion("uno","Aún no soy un hexagrama :/");
		borrarDescripcion("dos");
		borrarDescripcion("tres");
		quitarResaltar();
	}else{
		alert("Para poder borrar el hexagrama, debes tener al menos una linea");
	}
}

function agregarLinea(contenedor, texto){
	var conte=document.getElementById(contenedor);
	var elemento=document.createElement("div");
	elemento.innerHTML=texto;
	elemento.classList.add("revelar-texto");
	conte.appendChild(elemento);
}

function agregar(){
	if(document.getElementById("campo1").value && document.getElementById("campo2").value && document.getElementById("campo3").value){
		if (!(contador>6)){
			var tipo=Number(document.getElementById("campo1").value)+Number(document.getElementById("campo2").value)+Number(document.getElementById("campo3").value);
			if(!(tipo<6 || tipo>10)){
				combinacion.push(tipo);
				var linea=new LineaHexa(tipo);
				agregarLinea("contenedor1",linea.obtenerLinea);
				if(contador==6){
					var comb=combinacion.join("");
					var hexa, num;
					if(comb.indexOf("6") > -1 || comb.indexOf("9")> -1){
						var combinacion1=obtenerEquivalente1(comb);
						var combinacion2=obtenerEquivalente2(comb);
						var arreglo1=Array.from(combinacion1);
						var arreglo2=Array.from(combinacion2);
						for(var i=0;i<6;i++){
							linea=new LineaHexa(Number(arreglo1[i]));
							agregarLinea("contenedor2",linea.obtenerLinea);
							linea=new LineaHexa(Number(arreglo2[i]));
							agregarLinea("contenedor3",linea.obtenerLinea);
						}
						hexa=new Hexagrama(combinacion1);
						addDescripcion("uno","Soy un hexagrama especial");
						addTitulo("titulo2",hexa.obtenerNombre);
						num=hexa.obtenerNombre.split(".");
						addResaltar(num[0]);
						addDescripcion("dos",hexa.obtenerDescripcion);
						hexa=new Hexagrama(combinacion2);
						addTitulo("titulo3",hexa.obtenerNombre);
						num=hexa.obtenerNombre.split(".");
						addResaltar(num[0]);
						addDescripcion("tres",hexa.obtenerDescripcion);
					}else{
						hexa=new Hexagrama(comb);
						addTitulo("titulo1",hexa.obtenerNombre);
						num=hexa.obtenerNombre.split(".");
						addResaltar(num[0]);
						addDescripcion("uno",hexa.obtenerDescripcion);
					}
				}
				contador++;
			}else{
				alert("La sumatoria no es valida, por favor verifique que el valor se mantenga entre 6 y 9");
			}
		}else{
			alert("No puedes agregar más lineas, primero borra el hexagrama anterior");
		}
	}else{
		alert("Por favor llena los 3 campos");
	}
}