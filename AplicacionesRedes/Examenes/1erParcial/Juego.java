import java.io.*;
import java.net.*;
import javax.swing.*;
import java.awt.event.WindowEvent;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.Color;
import java.util.Date;
import java.text.*;
import java.util.Arrays;
import java.util.Random;
public class Juego implements ActionListener{
	Socket cliente;
	BufferedReader br;
	PrintWriter pw;
    String modoJuego;
    String dificultad;
	String sopaLetras;
	String concepto;
	String[] palabras=new String[15];
	String[][] sopa=new String[15][15];
	Integer[][] matriz=new Integer[15][15];
	Integer[][] aux=new Integer[15][15];
	JFrame frameJuego;
	JButton[][] letras=new JButton[15][15];
	JLabel[] etiquetas=new JLabel[15];
	int segundos=0;
	public Juego(Socket cliente, BufferedReader br, PrintWriter pw, String dificultad){
		this.cliente=cliente;
		this.br=br;
        this.pw=pw;
		this.dificultad=dificultad;
		Recibir();
	}
	public void Empezar(){
		//Frame principal
		frameJuego=new JFrame("Sopa de Letras");
		frameJuego.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frameJuego.setBounds(20, 20, 1300, 700);
		System.out.println("Empezó el juego");
		JPanel panel=new JPanel();
		panel.setBounds(20, 20, 800, 600);
		panel.setLayout(new java.awt.GridLayout(15, 15));
		if (dificultad.equals("facil")){
			for(int i=0;i<15;i++){
				etiquetas[i]=new JLabel(palabras[i]);
				etiquetas[i].setBounds(900, 50+(30*i), 130, 20);
				frameJuego.add(etiquetas[i]);
				for(int j=0;j<15;j++){
					aux[i][j]=0;
					letras[i][j]=new JButton(sopa[i][j]);
					letras[i][j].setBounds(0+(j+6),0+(i+6),6,6);
					letras[i][j].addActionListener(this);
					letras[i][j].setName(i+","+j);
					panel.add(letras[i][j]);
				}
			}
		}else if(dificultad.equals("medio")){
			for(int i=0;i<15;i++){
				String texto="";
				for(int k=0;k<palabras[i].length();k++){
					texto+="_";
				}
				etiquetas[i]=new JLabel(texto);
				etiquetas[i].setBounds(900, 50+(30*i), 130, 20);
				frameJuego.add(etiquetas[i]);
				for(int j=0;j<15;j++){
					aux[i][j]=0;
					letras[i][j]=new JButton(sopa[i][j]);
					letras[i][j].setBounds(0+(j+6),0+(i+6),6,6);
					letras[i][j].addActionListener(this);
					letras[i][j].setName(i+","+j);
					panel.add(letras[i][j]);
				}
			}
		}else{
			for(int i=0;i<15;i++){
				String texto=desordenar(palabras[i]);
				etiquetas[i]=new JLabel(texto);
				etiquetas[i].setBounds(900, 50+(30*i), 130, 20);
				frameJuego.add(etiquetas[i]);
				for(int j=0;j<15;j++){
					aux[i][j]=0;
					letras[i][j]=new JButton(sopa[i][j]);
					letras[i][j].setBounds(0+(j+6),0+(i+6),6,6);
					letras[i][j].addActionListener(this);
					letras[i][j].setName(i+","+j);
					panel.add(letras[i][j]);
				}
			}
		}
		JLabel labelPalabras=new JLabel("LISTA DE PALABRAS");
		labelPalabras.setBounds(900, 10, 150, 30);
		JLabel labelConcepto=new JLabel("CONCEPTO: "+concepto);
		labelConcepto.setBounds(1050, 10, 200, 30);
		JLabel tiempo=new JLabel("");
		tiempo.setBounds(900, 530, 130, 30);
        ActionListener timerListener = new ActionListener()
        {
            public void actionPerformed(ActionEvent e)
            {
                String time = "Segundos: "+segundos;
				tiempo.setText(time);
				segundos+=1;
            }
        };
        Timer timer = new Timer(1000, timerListener);
        timer.setInitialDelay(0);
		timer.start();
		frameJuego.add(tiempo);
		JButton validar=new JButton("Validar");
		validar.setBounds(950, 580, 80, 30);
		validar.setName("Validar");
		validar.addActionListener(this);
		// System.out.println("Termine de crear los botones");
		//Este label es para que los botones se pongan bien en su lugar xD
		frameJuego.add(validar);
		frameJuego.add(panel);
		frameJuego.add(labelPalabras);
		frameJuego.add(labelConcepto);
		JLabel nada=new JLabel("");
		nada.setBounds(0, 620, 80, 80);
		frameJuego.add(nada);
		frameJuego.pack();
		frameJuego.setVisible(true);
		
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		//Obtenemos el nombre del boton que se presionó
		JButton boton=(JButton)(e.getSource());
		if(boton.getName().equals("Validar")){
			int continuar=1;
			if(dificultad.equals("facil")){
				for(int i=0;i<15;i++){
					if(!Arrays.equals(matriz[i], aux[i])){
						continuar=0;
						break;
					}
				}
				if(continuar==0){
					JOptionPane.showMessageDialog(null, "Aun te faltan palabras");
				}else{
					JOptionPane.showMessageDialog(null, "Has ganado !");
					EnviarFinal();
				}
			}else if(dificultad.equals("medio")){
				for(int i=0;i<15;i++){
					if(!Arrays.equals(matriz[i], aux[i])){
						continuar=0;
						break;
					}
				}
				if(continuar==0){
					JOptionPane.showMessageDialog(null, "Aún te faltan palabras");
					mostrarLetra();
				}else{
					JOptionPane.showMessageDialog(null, "Has ganado !");
					EnviarFinal();
				}
			}else{
				for(int i=0;i<15;i++){
					if(!Arrays.equals(matriz[i], aux[i])){
						continuar=0;
						break;
					}
				}
				if(continuar==0){
					JOptionPane.showMessageDialog(null, "Aun te faltan palabras");
				}else{
					JOptionPane.showMessageDialog(null, "Has ganado !");
					EnviarFinal();
				}
			}
		}else{
			String nombre=boton.getName();
			String[] coordenadas = nombre.split(",");
			int i =Integer.valueOf(coordenadas[0]);
			int j =Integer.valueOf(coordenadas[1]);
			if(aux[i][j]==0){
				boton.setBackground(Color.red);
				boton.setOpaque(true);
				aux[i][j]=1;
			}else{
				boton.setBackground(new JButton().getBackground());
				boton.setOpaque(false);
				aux[i][j]=0;
			}
		}
		
	}
	public void Recibir(){
		System.out.println("Voy a empezar a recibir la info");
		try {
			// pw.println("Empezar a recibir");
			// System.out.println("Ya mande un mensaje");
			concepto=br.readLine();
			System.out.println("Concepto: "+concepto);
			for(int i=0;i<15;i++){
				palabras[i]=br.readLine();
				// System.out.println(palabras[i]);
			}
			for(int i=0;i<15;i++){
				for(int j=0;j<15;j++){
					sopa[i][j]=br.readLine();
					matriz[i][j]=Integer.valueOf(br.readLine());
					// System.out.print(sopa[i][j]);
				}
				// System.out.println("");
			}
			// pw=new PrintWriter(new OutputStreamWriter(cliente.getOutputStream()));
			pw.println("Ya recibi todo, gracias");
			Empezar();

		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public void EnviarFinal(){
		pw.println("Final");
		// frameJuego.dispose();
		// new Reinicio();
	}
	public void mostrarLetra(){
		Random rand=new Random();
		int  n = rand.nextInt(palabras.length) + 0;
		String texto=etiquetas[n].getText();
		int index=texto.indexOf("_");
		char caracter=palabras[n].charAt(index);
		etiquetas[n].setText(texto.substring(0,index)+caracter+texto.substring(index+1));
	}
	public String desordenar(String palabra){
		Random rand=new Random();
		String retorno="";
		String[] num=new String[palabra.length()];
		for(int i=0;i<palabra.length();i++){
			num[i]="";
			int  n = rand.nextInt(palabra.length()) + 0;
			if(Arrays.asList(num).contains(String.valueOf(n))){
				i--;
			}else{
				num[i]=String.valueOf(n);
				retorno+=palabra.charAt(n);
			}
		}
		return retorno;
	}
}