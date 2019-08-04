import java.io.*;
import java.net.*;
import javax.swing.*;
import java.awt.event.WindowEvent;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
public class ModoJuego implements ActionListener{
	Socket cliente;
	BufferedReader br;
	PrintWriter pw;
	String modoJuego;
	JFrame frameModoJuego;
	public ModoJuego(Socket cliente, BufferedReader br, PrintWriter pw){
		this.cliente=cliente;
		this.br=br;
		this.pw=pw;
		Empezar();
	}
	public void Empezar(){
		try{
			//Frame y botones para seleccionar el modo de juego
			frameModoJuego=new JFrame("Seleccionar modo juego");
			frameModoJuego.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			frameModoJuego.setBounds(100, 100, 400, 400);
			frameModoJuego.setVisible(true);

			JButton botonConcepto=new JButton("Concepto");
			botonConcepto.setBounds(100, 50, 100, 50);
			botonConcepto.addActionListener(this);
			botonConcepto.setName("concepto");
			
			JButton botonAnagrama=new JButton("Anagrama");
			botonAnagrama.setBounds(100, 200, 100, 50);
			botonAnagrama.addActionListener(this);
			botonAnagrama.setName("anagrama");
			
			frameModoJuego.add(botonConcepto);
			frameModoJuego.add(botonAnagrama);

			//Este label es para que los botones se pongan bien en su lugar xD
			JLabel nada=new JLabel("");
			nada.setBounds(0, 400, 80, 80);
			frameModoJuego.add(nada);

		}catch(Exception e){
			e.printStackTrace();
		}
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		//Obtenemos el nombre del boton que se presiono
		String nombre=((JButton)(e.getSource())).getName();
		if (nombre.equals("concepto") || nombre.equals("anagrama")){
			try{
				pw.println(nombre);
				pw.flush();
				System.out.println("Modo de juego seleccionado: "+nombre);
				new Dificultad(cliente,br,pw,modoJuego);
				frameModoJuego.setVisible(false);
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}else{
			try{
				br.close();
				pw.close();
				cliente.close();
				System.exit(0);
			}catch(Exception ex){
				ex.printStackTrace();
			}
		}
	}
}