import java.io.*;
import java.net.*;
import javax.swing.*;
public class Cliente{
	final static int PUERTO=8080;
	final static String HOST="localhost";
	// String modoJuego;
	// String dificultad;
	static Socket cliente;
	static BufferedReader br;
	static PrintWriter pw;
	public static void main(String[] args) {
		try {
			//Nos conectamos al server de python
			cliente=new Socket(HOST,PUERTO);
			//Escritura y lectura de bytes
			br=new BufferedReader(new InputStreamReader(cliente.getInputStream()));
			pw=new PrintWriter(cliente.getOutputStream(),true);
			new Dificultad(cliente, br, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}