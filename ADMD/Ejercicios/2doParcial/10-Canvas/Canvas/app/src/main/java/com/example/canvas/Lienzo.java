package com.example.canvas;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Typeface;
import android.view.View;

public class Lienzo extends View {
    Paint paint;
    int x,y;

    public Lienzo(Context context) {
        super(context);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);//Canvas pinta atributos
        paint=new Paint();//Paint asigna atributos
        x=canvas.getWidth();
        y=canvas.getHeight();
        paint.setColor(Color.WHITE);//Fondo blanco
        canvas.drawPaint(paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(40);
        canvas.drawText("x0="+x/2+" y0="+y/2,x/2+20,y/2-20,paint);
        paint.setColor(Color.rgb(0,0,255));//Ejes azules
        canvas.drawLine(x/2,0,x/2,y/1,paint);//Eje Y
        canvas.drawLine(0,y/2,x/1,y/2,paint);//Eje X

        paint.setTextAlign(Paint.Align.LEFT);
        paint.setTypeface(Typeface.SANS_SERIF);
        canvas.drawText("Eje X",0+10,y/2-10,paint);
        paint.setTextAlign(Paint.Align.CENTER);
        paint.setTypeface(Typeface.MONOSPACE);
        canvas.drawText("Eje Y",x/2+70,40,paint);
        paint.setColor(Color.argb(100,200,100,100));
        //canvas.drawCircle(x/4,3*y/4,200,paint);

        canvas.drawOval(x/4-200,y/4+300, x/4+200, 100,paint);
        canvas.drawRect(3*x/4-200,y/4+200,3*x/4+200,200,paint);
        //canvas.drawRoundRect(x/4,3*y/4,200,paint);
        canvas.drawRoundRect(x/4-200,3*y/4+200,x/4+200,3*y/4-200,200,100,paint);
        canvas.drawArc(3*x/4-200,3*y/4-200,3*x/4+200,3*y/4+200,0,340,true,paint);
    }
}
