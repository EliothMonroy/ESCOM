import java.net.*;
import java.io.*;
import java.util.Scanner;

public class Cliente {

    private Socket socket = null;
    private FileOutputStream fos = null;
    private DataInputStream din = null;
    private PrintStream pout = null;
    private Scanner scan = null;

    public Cliente(InetAddress address, int port) throws IOException
    {
        System.out.println("Initializing Client");
        socket = new Socket(address, port);
        scan = new Scanner(System.in);
        din = new DataInputStream(socket.getInputStream());
        pout = new PrintStream(socket.getOutputStream());
    }

    public void send(String msg) throws IOException
    {
        pout.print(msg);
        pout.flush();
    }

    public String recv() throws IOException
    {
        byte[] bytes = new byte[1024];
        din.read(bytes);
        String reply = new String(bytes, "UTF-8");
        System.out.println("Inside recv(): ");
        return reply;
    }

    public void closeConnections() throws IOException
    {
        // Clean up when a connection is ended
        socket.close();
        din.close();
        pout.close();
        scan.close();
    }

    public void chat() throws IOException 
    {    
        String response = "s";

        System.out.println("Initiating Chat Sequence");
        while(!response.equals("QUIT")){
            System.out.print("Client: ");
            String message = scan.nextLine();
            send(message);
            if(message.equals("QUIT"))
                break;
            response = recv();
            System.out.println("Server: " + response);
        }
        closeConnections();
    }

    // Request a specific file from the server
    public void getFile(String filename)
    {
        System.out.println("Requested File: "+filename);
        try {
            File file = new File("JAVA_"+filename);
            // Create new file if it does not exist
            // Then request the file from server
            if(!file.exists()){
                file.createNewFile();
                System.out.println("Created New File: "+filename);
            }
            fos = new FileOutputStream(file);
            send(filename);

            // Get content in bytes and write to a file
            byte[] buffer = new byte[8192];
            for(int counter=0; (counter = din.read(buffer, 0, buffer.length)) >= 0;)
            {
                    fos.write(buffer, 0, counter);
            }
            fos.flush();
            fos.close();

        } catch (IOException e) {
            e.printStackTrace();
        }

    }
}