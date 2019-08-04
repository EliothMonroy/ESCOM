import javax.swing.*;
import java.awt.event.*;
import java.awt.*;
class Inicio extends JFrame implements ActionListener {
    private JButton iniciar, salir;
    private JLabel menu;
    public Inicio(){
        setLayout(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        setTitle("Inicio");
        iniciar=new JButton("Iniciar examen");
        salir=new JButton("Salir");
        menu=new JLabel("Escoga una opcion");
        menu.setBounds(100,100,300,50);
        add(menu);
        iniciar.setBounds(100,200,200,50);
        add(iniciar);
        salir.setBounds(350,200,200,50);
        add(salir);
        iniciar.addActionListener(this);
        salir.addActionListener(this);
    }
    public void actionPerformed(ActionEvent e){
        if (e.getSource().equals(iniciar)){
            Examen exa=new Examen();
            exa.setBounds(10,0,800,500);
            exa.setVisible(true);
            exa.setResizable(true);
            this.setVisible(false);
            this.dispose();
        }else {
            this.setVisible(false);
            this.dispose();
        }
    }
}
