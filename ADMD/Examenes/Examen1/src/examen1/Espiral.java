/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package examen1;

import javax.microedition.lcdui.Canvas;
import javax.microedition.lcdui.Graphics;

/**
 *
 * @author IEUser
 */
public class Espiral extends Canvas{
    String color="";
    int speed=100;
    int show=5;
    int w,h;
    int x=0;
    int color1,color2,color3;
    

    protected void paint(Graphics g) {
        g.setColor(color1, color2, color3);
        w=getWidth();
        h=getHeight();
        try {
            Thread.sleep(show*1000);
            //Thread.sleep(0);
        } catch (InterruptedException ex) {
            ex.printStackTrace();
        }
        //g.drawString("w:"+w+" h:"+h, 50, 50, 0);
        for (int i=0;i<10;i++){
            if(i%2==0){
                g.drawArc(0+x, 30+(x-10), w-(i*20), h-((i+1)*21), 0, 180);
            }else{
                g.drawArc(0+x, 30+(x-10), w-(i*20), h-((i+1)*21), -180, 180);
                x+=20;
            }
            
        }
        
        //g.drawArc(0, 20, w, h-20, 0, 180);
        //g.drawArc(0, 20, w-20, h-40, -180, 180);
        
        
    }
    
}
