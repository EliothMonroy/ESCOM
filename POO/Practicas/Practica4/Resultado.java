import javax.swing.*;
import java.awt.event.*;
import java.awt.*;
public class Resultado extends JFrame implements ActionListener{
    JLabel resultado;
    JButton finalizar;
    public Resultado(float calificacion){
        setTitle("Resultado");
        setLayout(null);
        setDefaultCloseOperation(JFrame.DISPOSE_ON_CLOSE);
        resultado=new JLabel("Resultado: "+calificacion);
        resultado.setBounds(160,80,200,50);
        add(resultado);
        finalizar=new JButton("Finalizar Examen");
        finalizar.setBounds(130,150,150,50);
        finalizar.addActionListener(this);
        add(finalizar);
    }
    public void actionPerformed(ActionEvent e){
        this.setVisible(false);
        this.dispose();
    }
}
