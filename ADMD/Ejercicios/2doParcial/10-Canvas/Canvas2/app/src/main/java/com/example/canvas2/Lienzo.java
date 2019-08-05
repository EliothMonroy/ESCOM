package com.example.canvas2;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.graphics.Path;
import android.view.View;

public class Lienzo extends View {
    Paint paint;
    Path path;
    int x,y,x0,y0;

    public Lienzo(Context context) {
        super(context);
    }

    @Override
    protected void onDraw(Canvas canvas) {
        super.onDraw(canvas);
        paint=new Paint();
        path=new Path();
        x=canvas.getWidth();
        x0=x/2;
        y=canvas.getHeight();
        y0=y/2;
        paint.setColor(Color.WHITE);//Fondo blanco
        canvas.drawPaint(paint);
        paint.setColor(Color.BLACK);
        paint.setTextSize(40);
        canvas.drawText("0,0",x0+10,y0+20,paint);
        paint.setColor(Color.rgb(0,0,255));//Ejes azules
        canvas.drawLine(x0,0,x0,y,paint);
        canvas.drawLine(0,y0,x,y0,paint);
        paint.setColor(Color.BLUE);
        canvas.drawText("senA",40,40,paint);
        paint.setColor(Color.RED);
        canvas.drawText("cosA",40,80,paint);
        paint.setStyle(Paint.Style.STROKE);
        paint.setStrokeWidth(4);
        paint.setAntiAlias(true);

        path.moveTo(0,0);
        paint.setColor(Color.BLUE);
        for(int i=1;i<x;i++){
            path.lineTo(i,(float)Math.sin(i/15f)*(-60f));
        }
        path.offset(0,y0);
        canvas.drawPath(path,paint);

        path=new Path();
        path.moveTo(0,0);
        paint.setColor(Color.RED);
        for(int i=1;i<x;i++){
            path.lineTo(i,(float)Math.cos(i/15f)*(-80f));
        }
        path.offset(0,y0);
        canvas.drawPath(path,paint);
    }
}
