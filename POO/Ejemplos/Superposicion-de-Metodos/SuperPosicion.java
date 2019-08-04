class Imprime{
	int x=0;
	int y=1;
	public void imprime(){
		System.out.println("x es: "+x);
		System.out.println("y es : "+y);
	}
}
class SubClaseImprime extends Imprime{
	int z=3;
	public static void main(String[] args) {
		SubClaseImprime obj=new SubClaseImprime();
		obj.imprime();
	}
}
class SubClaseImprime2 extends Imprime{
	int z=3;
	public void imprime(){
		System.out.println("x es: "+x);
		System.out.println("y es: "+y);
		System.out.println("z es: "+z);
	}
	public static void main(String[] args) {
		SubClaseImprime2 obj=new SubClaseImprime2();
		obj.imprime();
	}
}