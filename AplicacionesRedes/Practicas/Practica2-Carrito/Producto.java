import java.io.Serializable;

public class Producto implements Serializable{
	int id;
	String nombre;
	float precio;
	int existencia;
	String imagen;
	public Producto(int id, String nombre, float precio, int existencia, String imagen){
		this.id=id;
		this.nombre=nombre;
		this.precio=precio;
		this.existencia=existencia;
		this.imagen=imagen;
	}
	int getId(){
		return this.id;
	}
	String getNombre(){
		return this.nombre;
	}
	float getPrecio(){
		return this.precio;
	}
	int getExistencia(){
		return this.existencia;
	}
	String getImagen(){
		return this.imagen;
	}
	void setExistencia(int existencia){
		this.existencia=existencia;
	}
}