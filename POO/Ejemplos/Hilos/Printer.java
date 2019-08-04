class Printer implements Runnable{
	Thread hilo;
	int count;
	String s;
	int sleepTime;
	public Printer(String string, int howMany,int sleep){
		count=howMany;
		s=string;
		sleepTime=sleep;
		hilo=new Thread(this);
		hilo.start();
	}
	public void run(){
		while ((count--)!=0) {
			System.out.print(s+"\n");
			try{
				Thread.sleep(sleepTime);
			}catch (Exception e) {
				return ;
			}
		}
	}
	public static void main(String[] args) {
		new Printer("Ping",5,500);
		new Printer("Pong",5,300);
	}
}