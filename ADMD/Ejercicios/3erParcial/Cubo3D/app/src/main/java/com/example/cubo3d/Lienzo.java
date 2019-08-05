package com.example.cubo3d;

import android.content.Context;
import android.graphics.Canvas;
import android.graphics.Color;
import android.graphics.Paint;
import android.view.MotionEvent;
import android.view.View;

public class Lienzo extends View {
    Paint p;
    int maxX, maxY, centerX, centerY;
    Obj obj = new Obj();
    int x = 0, y = 0;

    public Lienzo(Context c) {
        super(c);
    }

    protected void onDraw(Canvas c) {
        super.onDraw(c); // Canvas pinta atributos
        p = new Paint(); // Paint asigna atributos
        int minMaxXY;
        maxX = getWidth() - 1;
        maxY = getHeight() - 1;
        p.setColor(Color.WHITE);
        c.drawPaint(p);
        minMaxXY = Math.min(maxX, maxY);
        centerX = maxX / 2;
        centerY = maxY / 2;
        obj.d = obj.rho * minMaxXY / obj.objSize;
        obj.eyeAndScreen();
        line(c, p, 0, 1);
        line(c, p, 1, 2);
        line(c, p, 2, 3);
        line(c, p, 3, 0); // aristas horizontales inferiores
        line(c, p, 4, 5);
        line(c, p, 5, 6);
        line(c, p, 6, 7);
        line(c, p, 7, 4); // aristas horizontales superiores
        line(c, p, 0, 4);
        line(c, p, 1, 5);
        line(c, p, 2, 6);
        line(c, p, 3, 7); // aristas verticales
    }

    public boolean onTouchEvent(MotionEvent me) {
        float X = me.getX();
        float Y = me.getY();

        if (me.getAction() == MotionEvent.ACTION_MOVE) {
            x = (int) (X);
            y = (int) (Y);
        }

        obj.theta = (float) getWidth() / x;
        obj.phi = (float) getHeight() / y;
        obj.rho = (obj.phi / obj.theta) * getHeight();
        centerX = x;
        centerY = y;
        invalidate();
        return true;
    }

    void line(Canvas g, Paint pa, int i, int j) {
        Point2D p = obj.vScr[i], q = obj.vScr[j];
        System.out.println(((int) p.x + centerX));
        pa.setColor(Color.BLACK);
        pa.setStrokeWidth(5);
        g.drawLine(centerX + (int) p.x, centerY - (int) p.y, centerX + (int) q.x, centerY - (int) q.y, pa);
    }
}
