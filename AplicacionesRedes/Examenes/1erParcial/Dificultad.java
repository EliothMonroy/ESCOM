import java.io.*;
import java.net.*;
import javax.swing.*;
import java.awt.event.WindowEvent;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
public class Dificultad implements ActionListener{
	Socket cliente;
	BufferedReader br;
	PrintWriter pw;
	JFrame frameDificultad;
    String modoJuego;
	String dificultad;
	public Dificultad(Socket cliente, BufferedReader br, PrintWriter pw){
		this.cliente=cliente;
		this.br=br;
        this.pw=pw;
		Empezar();
	}
	public void Empezar(){
		try{
			//Frame y botones para seleccionar la dificultad
			frameDificultad=new JFrame("Seleccionar dificultad");
			frameDificultad.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
			frameDificultad.setBounds(100, 100, 500, 500);
			frameDificultad.setVisible(true);


			JButton botonFacil=new JButton("Facil");
			botonFacil.setBounds(100, 50, 100, 50);
			botonFacil.addActionListener(this);
			botonFacil.setName("facil");
			
			JButton botonMedio=new JButton("Medio");
			botonMedio.setBounds(100, 200, 100, 50);
			botonMedio.addActionListener(this);
			botonMedio.setName("medio");

			JButton botonDificil=new JButton("Dificil");
			botonDificil.setBounds(100, 350, 100, 50);
			botonDificil.addActionListener(this);
			botonDificil.setName("dificil");
			

			frameDificultad.add(botonFacil);
			frameDificultad.add(botonMedio);
			frameDificultad.add(botonDificil);

			//Este label es para que los botones se pongan bien en su lugar xD
			JLabel nada=new JLabel("");
			nada.setBounds(0, 400, 80, 80);
			frameDificultad.add(nada);

		}catch(Exception e){
			e.printStackTrace();
		}
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		//Obtenemos el nombre del boton que se presiono
		String nombre=((JButton)(e.getSource())).getName();
		if (nombre.equals("facil") || nombre.equals("medio") || nombre.equals("dificil")){
			try{
				pw.println(nombre);
				pw.flush();
				System.out.println("Dificultad seleccionada: "+nombre);
				frameDificultad.dispose();;
				new Juego(cliente,br,pw,nombre);
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