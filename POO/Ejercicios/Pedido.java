public class Pedido{
	int numero_bolsas;
	public Pedido(int numero_bolsas){
		this.numero_bolsas=numero_bolsas;
	}
	public void reparticion(){
		int residuo=numero_bolsas%20;
		System.out.println("Cajas grandes (20 bolsas): "+(numero_bolsas-residuo)/20);
		if(residuo==0){
			System.out.println("Cajas medianas (10 bolsas): 0");
			System.out.println("Cajas chicas (5 bolsas): 0");
		}else{
			int residuo2=residuo%10;
			System.out.println("Cajas medianas (10 bolsas): "+(residuo-residuo2)/10);
			if (residuo2==0) {
				System.out.println("Cajas chicas (5 bolsas): 0");
			}else{
				if((residuo2/5)>0){
					int residuo3=residuo2%5;
					if(residuo3==0){
						System.out.println("Cajas chicas (5 bolsas): 1");
					}else{
						System.out.println("Cajas chicas (5 bolsas): 2");
					}
				}else{
					System.out.println("Cajas chicas (5 bolsas): 1");
				}
			}
		}
	}
}