import javax.swing.*;
import java.awt.event.*;
import java.awt.*;
public class Ejercicio1 extends JFrame implements ActionListener{
	private JButton asientos[];
	private JButton cuarenta_y_cinco, limpiar;
	private GridLayout layout;
	private JLabel total_reservados;
	private String asientosOcupados;
	public Ejercicio1(){
		asientos=new JButton[44];
		layout=new GridLayout(0,4);
		setLayout(layout);
		for (int i=0;i<44;i++) {
			asientos[i]=new JButton(""+(i+1));
			asientos[i].addActionListener(this);
			add(asientos[i]);
		}
		asientosOcupados="";
		total_reservados=new JLabel("");
		cuarenta_y_cinco=new JButton("Ver todos");
		limpiar=new JButton("Desocupar todos");
		cuarenta_y_cinco.addActionListener(this);
		cuarenta_y_cinco.setBounds(300,300,300,300);
		total_reservados.setBounds(300,300,300,300);
		limpiar.setBackground(Color.YELLOW);
		cuarenta_y_cinco.setBackground(Color.GREEN);
		limpiar.addActionListener(this);
		add(total_reservados);
		add(cuarenta_y_cinco);
		add(limpiar);
	}
	public void actionPerformed(ActionEvent e){
		for(int i=0;i<44;i++){
			if(e.getSource().equals(asientos[i])){
				System.out.println("Presionaron el boton "+(i+1));
				asientosOcupados+=""+(i+1)+" ";
				asientos[i].setText("Ocupado");
				asientos[i].setBackground(Color.RED);
			}
		}
		if(e.getSource().equals(cuarenta_y_cinco)){
			total_reservados.setText("Asientos ocupados: "+asientosOcupados);
		}else{
			if (e.getSource().equals(limpiar)) {
				for (int i=0;i<44;i++) {
					if (asientos[i].getText().equals("Ocupado")) {
						asientos[i].setText(""+(i+1));
						asientos[i].setBackground(null);
					}
				}
			}
		}
	}
	public static void main(String[] args) {
		Ejercicio1 e=new Ejercicio1();
		e.setBounds(10,0,1200,1000);
		e.setVisible(true);
		e.setResizable(true);
	}
}