import javax.swing.*;
import java.awt.event.*;
import java.util.Calendar;
//Calcular la edad de una persona
class Ejercicio1 extends JFrame implements ActionListener {
    private JLabel instrucciones, resultado;
    private JButton enviar;
    private JTextField edad;
    private Calendar calendario;
    public Ejercicio1(){
        setLayout(null);
        calendario = Calendar.getInstance();
        instrucciones=new JLabel("Por favor ingresa tu anio de nacimiento");
        resultado=new JLabel("Tu edad es: ");
        edad=new JTextField(4);
        enviar=new JButton("Presione aqui para calcular su edad");

        //Agregamos un metodo para quevalide que sean puros numeros
        edad.addKeyListener(new KeyListener(){
            public void keyTyped(KeyEvent e){
                //La longitud maxima debe ser de 4 digitos
                if (edad.getText().length() == 4 )
                    //Ignora la tecla pulsada
                    e.consume();
                //Obtenemos la tecla pulsada
                char caracter = e.getKeyChar();
                //Verificamos si la el caracter es un numero o no
                //La ultima condicion es para la tecla de retroceder (borrar)
                if(((caracter < '0') || (caracter > '9')) && (caracter != '\b')){
                    //Ignora la tecla pulsada
                    e.consume();
                }
            }
            //Tenemos que importar estos metodos porque la clase es abstracta
            public void keyPressed(KeyEvent arg0) {}
            public void keyReleased(KeyEvent arg0) {}
        });
        //Definimos tamaños aquí
        instrucciones.setBounds(20,20,300,20);
        edad.setBounds(20,50,200,20);
        resultado.setBounds(20,100,150,20);
        enviar.setBounds(150,100,300,20);
        //Para el boton
        enviar.addActionListener(this);
        //Agregamos los elementos
        add(instrucciones);
        add(resultado);
        add(edad);
        add(enviar);
    }
    public void actionPerformed(ActionEvent e){
        int edad_numero=0;
        try{
            edad_numero=Integer.parseInt(edad.getText());
        }catch(Exception ex){
            System.out.print("Campo edad esta vacio, pero no trueno");
        }
        resultado.setText("Tu edad es: "+(calendario.get(Calendar.YEAR)-edad_numero));
    }
    public static void main(String[] args) {
        Ejercicio1 e=new Ejercicio1();
        e.setBounds(500,500,500,200);
        e.setVisible(true);
        e.setResizable(false);
    }
}
