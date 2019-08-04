class Revolver{
	private int numeroBalas;
	private boolean cargada;
	private int capacidad;
	public Revolver(capacidad){
		this.capacidad=capacidad;
		numeroBalas=0;
	}
	public void cargar(numeroBalas){
		if(numeroBalas>=capacidad)
			this.numeroBalas=capacidad;
		else
			this.numeroBalas=numeroBalas;
	}
	public void disparar(){
		if(numeroBalas!=0)
			numeroBalas-=1;
		else{
			cargar();
			disparar();
		}
	}
	public void apuntar(String nombre){
		
	}
}