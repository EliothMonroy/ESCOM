import javax.swing.*;
import java.awt.event.*;
import java.awt.*;
public class Examen extends JFrame implements ActionListener, Runnable{
    JLabel menu, pregunta, tiempo;
    int contador;
    Pregunta[] p;
    float calificacion;
    JRadioButton[] respuestas;
    ButtonGroup res;
    JButton siguiente;
    Thread temporizador;
    boolean[] continuar;
    public Examen(){
        setTitle("Examen");
        contador=0;
        calificacion=0;
        p=new Pregunta[4];
        respuestas=new JRadioButton[4];
        res=new ButtonGroup();
        inicializarPreguntas();
        pregunta=new JLabel("");
        tiempo=new JLabel("");
        continuar=new boolean[4];
        for(int i=0;i<4;i++){
            respuestas[i]=new JRadioButton("");
            respuestas[i].setBounds(100*(i+1),170,50,40);
            res.add(respuestas[i]);
            add(respuestas[i]);
            continuar[i]=true;
        }
        siguiente=new JButton("Siguiente Pregunta");
        siguiente.setBounds(100,270,300,50);
        pregunta.setBounds(100,100,200,40);
        tiempo.setBounds(500,100,200,40);
        setLayout(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        menu=new JLabel("");
        menu.setBounds(100,20,200,50);
        add(menu);
        add(pregunta);
        add(siguiente);
        add(tiempo);
        siguiente.addActionListener(this);
        temporizador=new Thread(this);
        crearPregunta();
    }
    public void inicializarPreguntas(){
        //Para la pregunta 1
        String pregunta="Cuanto es 1+1?";
        String[] respuesta0={"1","2","3","5"};
        int correcta=1;
        p[0]=new Pregunta(pregunta,respuesta0,correcta);
        //Pregunta 2
        pregunta="Cuanto es 1*1?";
        String[] respuesta1={"1","2","3","6"};
        correcta=0;
        p[1]=new Pregunta(pregunta,respuesta1,correcta);
        //Pregunta 3
        pregunta="Cuanto es 1-1?";
        String[] respuesta2={"0","1","2","7"};
        correcta=0;
        p[2]=new Pregunta(pregunta,respuesta2,correcta);
        //Pregunta 4
        pregunta="Cuanto es 1/1?";
        String[] respuesta3={"1","2","3","8"};
        correcta=0;
        p[3]=new Pregunta(pregunta,respuesta3,correcta);
    }
    public void crearPregunta(){
        menu.setText("Pregunta: "+(contador+1));
    	System.out.println("Entre a crearPregunta");
    	pregunta.setText(p[contador].getPregunta());
        System.out.println(p[contador].getPregunta());
        for (int i=0; i<(p[contador].getRespuesta()).length; i++) {
            respuestas[i].setText(p[contador].getRespuesta()[i]);
            respuestas[i].setSelected(true);
        }
        if(temporizador==null){
            System.out.println("Estoy creando un hilo");
            temporizador=new Thread(this);
            continuar[contador]=true;
        }
        temporizador.start();
    }
    public void actionPerformed(ActionEvent e){
        stop();
    }
    public void obtenerRespuesta(){
        for (JRadioButton radio : respuestas) {
            if(radio.isSelected()){
                if(radio.getText().equals(p[contador].getCorrecta())){
                    calificacion+=2.5;
                }
                contador+=1;
                System.out.println(calificacion);
            }
        }
        if(contador==3){
            siguiente.setText("Resultado");
        }
        if(contador==4){
            Resultado resul=new Resultado(calificacion);
            resul.setBounds(100,100,400,300);
            resul.setVisible(true);
            resul.setResizable(true);
            this.setVisible(false);
            this.dispose();
        }else{
            crearPregunta();
        }
    }
    public void run(){
        System.out.println("Estoy en run");
        int tiempo_contestar=10;
        int aux=contador;
        while(tiempo_contestar>0 && continuar[aux]==true){
            tiempo.setText("Tiempo restante: "+tiempo_contestar);
            try{
                temporizador.sleep(1000);
            }catch(Exception e){
                System.out.println("Excepcion problema"+e);
            }
            tiempo_contestar-=1;
        }
        if (tiempo_contestar==0) {
            System.out.println("Se acabo el tiempo");
            stop();
        }
    }
    public void stop(){
        System.out.println("Entre a stop");
        temporizador=null;
        if (contador==0) {
            continuar[0]=false;
        }else{
            if (contador==1) {
                continuar[1]=false;
            }else{
                if (contador==2) {
                    continuar[2]=false;
                }else{
                    continuar[3]=false;
                }
            }
        }
        obtenerRespuesta();
    }
}
