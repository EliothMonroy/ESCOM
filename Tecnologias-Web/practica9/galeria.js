function inicio(){
	document.images[0].src="img/01.jpg";
}
function fin(){
	document.images[0].src="img/15.jpg";
}
function siguiente(){
	var imagen=document.images[0].src
	var index=parseInt(imagen.substring(70,72));
	if(index==15){
		inicio();
	}else{
		if(index<10){
			document.images[0].src="img/0"+(index+1)+".jpg";
		}else{
			document.images[0].src="img/"+(index+1)+".jpg";
		}
	}
}
function anterior(){
	var imagen=document.images[0].src
	var index=parseInt(imagen.substring(70,72));
	if(index==1){
		fin();
	}else{
		if(index<10){
			document.images[0].src="img/0"+(index-1)+".jpg";
		}else{
			document.images[0].src="img/"+(index-1)+".jpg";
		}
	}
}