import javax.swing.JFrame;
import java.awt.event.ActionEvent;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.ImageIcon;
import java.net.Socket;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Stream;
import javax.swing.JOptionPane;
import java.lang.Thread;
public class Carrito implements ActionListener{
	Socket cl;
	List<Producto> carrito;
	JFrame frame;
	public Carrito(List<Producto> carrito, Socket cl){
		this.cl=cl;
		this.carrito=carrito;
		frame=new JFrame("Carrito de compras");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setBounds(100, 100, 700, 500);
		frame.setVisible(true);
		JLabel[] etiquetas=new JLabel[carrito.size()];
		JLabel[] precios=new JLabel[carrito.size()];
		JLabel[] existencias=new JLabel[carrito.size()];
		JButton comprar=new JButton("Comprar todo");
		comprar.setBounds(500, 100, 150, 30);
		comprar.addActionListener(this);
		frame.add(comprar);
		for(int i=0; i<carrito.size();i++){
			etiquetas[i]=new JLabel(carrito.get(i).getNombre(),new ImageIcon(carrito.get(i).getImagen()),JLabel.RIGHT);
			etiquetas[i].setBounds(0, 100*i, 200, 100);
			precios[i]=new JLabel("Precio: "+ carrito.get(i).getPrecio());
			precios[i].setBounds(220, 100*i, 100, 50);
			existencias[i]=new JLabel("Existencia: "+ carrito.get(i).getExistencia());
			existencias[i].setBounds(220, 50+(100*i), 200, 50);
			frame.add(etiquetas[i]);
			frame.add(precios[i]);
			frame.add(existencias[i]);
		}
		JLabel producto4=new JLabel("");
		producto4.setBounds(0, 400, 80, 80);
		frame.add(producto4);
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		try{
			System.out.println("Se ha iniciado el proceso de compra");
			ObjectOutputStream oos = new ObjectOutputStream(cl.getOutputStream());
			Integer total=carrito.size();
			oos.writeObject(total);
			oos.flush();
			for(int i=0;i<carrito.size();i++){
				oos.writeObject(carrito.get(i));
				oos.flush();
			}
			JOptionPane.showMessageDialog(null, "Compra exitosa !");
			frame.setVisible(false);
			
			try {
				cl.close();
				oos.close();
			} catch (Exception ex) {
				ex.printStackTrace();
			}
			System.exit(0);
			//new Cliente();
			
		}catch(Exception ex) {
			ex.printStackTrace();
		}
	}
}