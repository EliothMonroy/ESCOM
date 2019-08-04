class Vector3D extends Vector2D{
	int z;
	public Vector3D(int x, int y,int z){
		super(x,y);
		this.z=z;
	}
	public void multEscalar(int esc){
		x=x*esc;
		y=y*esc;
		System.out.print("Estoy en el metodo superpuesto\n");
		System.out.print("x = "+x+", y = "+y);
	}
	public static void main(String[] args) {
		Vector3D vec=new Vector3D(1,2,3);
		vec.multEscalar(10);
	}
}