class Vector2D{
	protected int x,y;
	public Vector2D(int x, int y){
		this.x=x;
		this.y=y;
	}
	public void multEscalar(int esc){
		this.x=x*esc;
		this.y=y*esc;
		System.out.print("x = "+x+", y = "+y);
	}
}