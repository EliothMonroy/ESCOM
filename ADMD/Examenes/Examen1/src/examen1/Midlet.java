/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package examen1;

import javax.microedition.lcdui.Command;
import javax.microedition.lcdui.CommandListener;
import javax.microedition.lcdui.Display;
import javax.microedition.lcdui.Displayable;
import javax.microedition.lcdui.Form;
import javax.microedition.lcdui.TextField;
import javax.microedition.midlet.*;

/**
 * @author IEUser
 */
public class Midlet extends MIDlet implements CommandListener{
    Display d;
    Command cSalir;
    Command cPintar;
    Command cRegresar;
    Espiral es;
    private Form  f;
    private TextField color1;
    private TextField color2;
    private TextField color3;
    private TextField speed;
    private TextField show;
    
    public Midlet(){
        d = Display.getDisplay(this);
        f  = new Form ("Dibujar espiral");
        es=new Espiral();
        cSalir = new Command("Salir", Command.EXIT, 2);
        cPintar = new Command("Pintar", Command.SCREEN, 1);
        cRegresar = new Command("Regresar", Command.SCREEN, 1);
        color1 = new TextField("Color1:", "50", 10, TextField.ANY);
        color2 = new TextField("Color2:", "200", 10, TextField.ANY);
        color3 = new TextField("Color3:", "100", 10, TextField.ANY);
        speed = new TextField("Speed (msecs):", "100", 10, TextField.NUMERIC);
        show = new TextField("Show (secs):", "2", 10, TextField.NUMERIC);
        
        f.append(color1);
        f.append(color2);
        f.append(color3);
        f.append(speed);
        f.append(show);
        
        f.addCommand(cSalir);
        f.addCommand(cPintar);
        f.setCommandListener(this);
        
        es.addCommand(cRegresar);
        es.setCommandListener(this);
    }

    public void startApp() {
        d.setCurrent(f);
    }
    
    public void pauseApp() {
    }
    
    public void destroyApp(boolean unconditional) {
    }

    public void commandAction(Command c, Displayable ddsss) {
        if (cSalir == c) {
            destroyApp(false);
            notifyDestroyed();
        } else if (cRegresar == c) {
            d.setCurrent(f);
        } else if (cPintar == c) {
            es = new Espiral();
            es.color1 = Integer.parseInt(color1.getString());
            es.color2 = Integer.parseInt(color2.getString());
            es.color3 = Integer.parseInt(color3.getString());
            es.speed = Integer.parseInt(speed.getString());
            es.show = Integer.parseInt(show.getString());
            es.addCommand(cRegresar);
            es.setCommandListener(this);
            
            d.setCurrent(es);
            //p.repaint();
            
        }
    }
}
