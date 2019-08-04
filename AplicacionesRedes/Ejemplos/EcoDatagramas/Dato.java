import java.io.Serializable;
public class Dato implements Serializable{
	int n;
	int np;
	byte [] b;
	int tam;
	public Dato(int n, int np, byte []b, int tam){
		this.n=n;
		this.np=np;
		this.b=b;
		this.tam=tam;
	}
	int getN(){
		return this.n;
	}
}