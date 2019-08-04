import java.io.Serializable;
public class Dato implements Serializable{
	//Si agregamos el modificar trasient a las variables, el valor de las mismas no se envía al momento de enviar el objeto
	String v1;
	int v2;
	float v3;
	long v4;
	public Dato(String v1, int v2, float v3, long v4){
		this.v1=v1;
		this.v2=v2;
		this.v3=v3;
		this.v4=v4;
	}
	String getV1(){
		return this.v1;
	}
	int getV2(){
		return this.v2;
	}
	float getV3(){
		return this.v3;
	}
	long getV4(){
		return this.v4;
	}
}