class Rueda{
		private int radio;
		private Rueda rueda;
		private int cuentaVuelta;
	public Rueda(int radio){
		this.radio=radio;
		cuentaVuelta=0;
		rueda=null;
	}
	public void conectar(Rueda r){
		if(radio>r.getRadio())
			rueda=r;
	}
	public void girar(){
		int razon=0;
		cuentaVuelta+=1;
		if (rueda!=null)
			razon=radio/rueda.getRadio;
		for (int i=0; i<razon;i++)
			rueda.girar();//Delegación
	}
	public int getRadio(){
		return radio;
	}
	public int getCuentaVueltas(){
		return cuentaVuelta;
	}
}
public class Relog{
	Rueda horas, minutos, segundos;
	public Relog(){
		horas=new Rueda(3600);
		minutos=new Rueda(60);
		segundos=new Rueda(1);
		horas.conectar(minutos);
		minutos.conectar(segundos);
		horas.girar();
		System.out.println(segundos.getCuentaVueltas());
	}
}
public static void main(String[] args) {
	new Relog();
}