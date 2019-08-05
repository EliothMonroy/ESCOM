package com.example.dibujoamano;
import android.content.Context;
import android.graphics.*;  // Canvas, Color, Paint, Path;
import android.view.*;      //MotionEvent, View;
class MiLienzo extends View {
    float   x=50, y=50;
    String  s="";
    Path pa=new Path();
    public MiLienzo(Context c){
        super(c);
    }
    @Override
    protected void onDraw(Canvas c){
        //c.drawColor(Color.rgb(200, 200, 200));
        c.drawColor(Color.WHITE);
        Paint p = new Paint();
        p.setStyle(Paint.Style.STROKE);
        p.setStrokeWidth(6);
        p.setColor(Color.RED);
        if(s=="abajo") pa.moveTo(x, y);
        if(s=="mover") pa.lineTo(x, y);
        c.drawPath(pa, p);
    }
    @Override
    public boolean onTouchEvent(MotionEvent me){
        x = me.getX();
        y = me.getY();
        if(me.getAction()==MotionEvent.ACTION_DOWN) s = "abajo";
        if(me.getAction()==MotionEvent.ACTION_MOVE) s = "mover";
        invalidate();
        return true;
    }
}