package com.example.proyectorecuperacion;

import android.app.ProgressDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Handler;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStream;
import java.util.UUID;

public class Tacometro extends AppCompatActivity {

    String address = null;
    private ProgressDialog progress;
    BluetoothAdapter myBluetooth = null;
    BluetoothSocket btSocket = null;
    private boolean isBtConnected = false;
    InputStream socketInputStream;
    OutputStream socketOutputStream;
    //SPP UUID. Look for it
    static final UUID myUUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");


    TextView velocidadView;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tacometro);
        getSupportActionBar().setTitle("Tacómetro");

        Intent newint = getIntent();
        address = newint.getStringExtra(MainActivity.EXTRA_ADDRESS); //receive the address of the bluetooth device

        velocidadView=findViewById(R.id.velocidadView);

        new ConnectBT().execute();

    }

    // fast way to call Toast
    private void msg(String s)
    {
        Toast.makeText(getApplicationContext(),s,Toast.LENGTH_LONG).show();
    }

    private void Disconnect()
    {
        if (btSocket!=null) //If the btSocket is busy
        {
            try
            {
                btSocket.close(); //close connection
            }
            catch (IOException e)
            { msg("Error");}
        }
        finish(); //return to the first layout

    }


    private class ConnectBT extends AsyncTask<Void, Void, Void>  // UI thread
    {
        private boolean ConnectSuccess = true; //if it's here, it's almost connected

        @Override
        protected void onPreExecute()
        {
            progress = ProgressDialog.show(Tacometro.this, "Conectando...", "Por favor espere");  //show a progress dialog
        }

        @Override
        protected Void doInBackground(Void... devices) //while the progress dialog is shown, the connection is done in background
        {
            try
            {
                if (btSocket == null || !isBtConnected)
                {
                    myBluetooth = BluetoothAdapter.getDefaultAdapter();//get the mobile bluetooth device
                    BluetoothDevice dispositivo = myBluetooth.getRemoteDevice(address);//connects to the device's address and checks if it's available
                    btSocket = dispositivo.createInsecureRfcommSocketToServiceRecord(myUUID);//create a RFCOMM (SPP) connection
                    BluetoothAdapter.getDefaultAdapter().cancelDiscovery();
                    btSocket.connect();//start connection
                }
            }
            catch (IOException e)
            {
                Log.d("Tacometro","Error al conectarse: ");
                e.printStackTrace();
                ConnectSuccess = false;//if the try failed, you can check the exception here
            }
            return null;
        }
        @Override
        protected void onPostExecute(Void result) //after the doInBackground, it checks if everything went fine
        {
            super.onPostExecute(result);

            if (!ConnectSuccess)
            {
                msg("La conexión falló, tiene Bluetooth el dispositivo?");
                finish();
            }
            else
            {
                Log.d("Tacometro","Me conecté");
                msg("Conectado.");
                isBtConnected = true;

                try{
                    socketOutputStream =  btSocket.getOutputStream();
                    socketInputStream =  btSocket.getInputStream();
                    //TODO: Mandamos un valor para que empiece a enviar el bluetooth
                    socketOutputStream.write('1');
                    socketOutputStream.flush();
                }catch (Exception e){
                    e.printStackTrace();
                }

                final Handler handler = new Handler();

                final Runnable [] runnables = new Runnable[1];

                // Define the code block to be executed
                final BufferedReader br=new BufferedReader(new InputStreamReader(socketInputStream));


                runnables[0]=new Runnable() {
                    @Override
                    public void run() {
                        // Insert custom code here
                        try {
                            String readMessage="";
                            byte[] buffer;
                            int bytes;

                            //buffer = new byte[10];
                            //bytes = socketInputStream.read(buffer);            //read bytes from input buffer
                            readMessage=br.readLine();
                            //readMessage = new String(buffer, 0, bytes);
                            //readMessage tiene el valor del tacometro
                            velocidadView.setText("Velocidad= "+readMessage+" rpm");


                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                        // Repeat every 1 seconds
                        handler.postDelayed(runnables[0], 100);
                    }
                };
                handler.post(runnables[0]);

            }
            progress.dismiss();
        }
    }
}
