package com.example.devicelist;

import android.os.Bundle;
import android.provider.Settings;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.view.Menu;
import android.view.MenuItem;

import android.bluetooth.BluetoothSocket;
import android.content.Intent;
import android.view.View;
import android.widget.Button;
import android.widget.SeekBar;
import android.widget.TextView;
import android.widget.Toast;
import android.app.ProgressDialog;
import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.os.AsyncTask;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.UUID;
import android.os.Handler;



public class ledControl extends AppCompatActivity {
    Button btnDis;
    SeekBar brightness;
    TextView labelTemperatura, labelPote, labelHall, labelMotor;
    String address = null;
    private ProgressDialog progress;
    BluetoothAdapter myBluetooth = null;
    BluetoothSocket btSocket = null;
    private boolean isBtConnected = false;
    InputStream socketInputStream;
    OutputStream socketOutputStream;
    //SPP UUID. Look for it
    static final UUID myUUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");

    private ArrayList<Sensor> sensors;
    private RecyclerView recyclerView;
    private SensorAdapter sensorAdapter;

    @Override
    protected void onCreate(Bundle savedInstanceState)
    {
        super.onCreate(savedInstanceState);

        Intent newint = getIntent();
        address = newint.getStringExtra(MainActivity.EXTRA_ADDRESS); //receive the address of the bluetooth device

        //view of the ledControl
        setContentView(R.layout.activity_led_control);

        /*btnDis = (Button)findViewById(R.id.button4);

        labelTemperatura=(TextView)findViewById(R.id.labelTemperatura);
        labelPote=(TextView)findViewById(R.id.labelPote);
        labelHall=(TextView)findViewById(R.id.labelHall);
        labelMotor=(TextView)findViewById(R.id.labelMotor);*/

        //Call the class to connect

        new ConnectBT().execute();

        sensors = new ArrayList<Sensor>();
        sensors.add(new Sensor("℃", "Temperatura", "0", R.drawable.temperature));
        sensors.add(new Sensor("V", "Potentiometer", "0", R.drawable.potentiometer));
        sensors.add(new Sensor("mT", "Efecto Hall", "0", R.drawable.magnetic));
        sensors.add(new Sensor("RPM", "Tachometer", "0", R.drawable.tacometer));

        recyclerView = findViewById(R.id.rv_sensors);
        sensorAdapter = new SensorAdapter(sensors);

        LinearLayoutManager linearLayoutManager = new LinearLayoutManager(ledControl.this);
        linearLayoutManager.setOrientation(LinearLayoutManager.VERTICAL);
        recyclerView.setLayoutManager(linearLayoutManager);

        /*btnDis.setOnClickListener(new View.OnClickListener()
        {
            @Override
            public void onClick(View v)
            {
                Disconnect(); //close connection
            }
        });*/

        recyclerView.setAdapter(sensorAdapter);
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


    // fast way to call Toast
    private void msg(String s)
    {
        Toast.makeText(getApplicationContext(),s,Toast.LENGTH_LONG).show();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_led_control, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }

    private class ConnectBT extends AsyncTask<Void, Void, Void>  // UI thread
    {
        private boolean ConnectSuccess = true; //if it's here, it's almost connected

        @Override
        protected void onPreExecute()
        {
            progress = ProgressDialog.show(ledControl.this, "Connecting...", "Please wait!!!");  //show a progress dialog
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
                System.out.println("Error al conectarse: ");
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
                msg("Connection Failed. Is it a SPP Bluetooth? Try again.");
                finish();
            }
            else
            {
                System.out.println("Me conecte");
                msg("Connected.");
                isBtConnected = true;

                try{
                    socketOutputStream =  btSocket.getOutputStream();
                    socketInputStream =  btSocket.getInputStream();
                    socketOutputStream.write('1');
                    socketOutputStream.flush();
                }catch (Exception e){
                    e.printStackTrace();
                }

                final Handler handler = new Handler();

                final Runnable [] runnables = new Runnable[1];

                // Define the code block to be executed

                runnables[0]=new Runnable() {
                    @Override
                    public void run() {
                        // Insert custom code here
                        try {
                            String readMessage="";
                            String aux="";
                            String array[];
                            byte[] buffer;
                            int bytes;
                            //Primero leemos temperatura (int)
                            buffer = new byte[60];
                            bytes = socketInputStream.read(buffer);            //read bytes from input buffer
                            readMessage = new String(buffer, 0, bytes);
                            readMessage=readMessage.replace("\n","");
                            array=readMessage.split(";");
                            //readMessage=
                            // Send the obtained bytes to the UI Activity via handler

                            try{
                                sensors.get(0).setType(array[0]);
                                sensors.get(1).setType(array[1]);
                                sensors.get(2).setType(array[2]);
                                sensors.get(3).setType(array[3]);

                                sensorAdapter.notifyDataSetChanged();
                            }catch(Exception e){
                                e.printStackTrace();
                            }

                        } catch (IOException e) {
                            e.printStackTrace();
                        }

                        // Repeat every 1 seconds
                        handler.postDelayed(runnables[0], 1000);
                    }
                };
                handler.post(runnables[0]);

            }
            progress.dismiss();
        }
    }
}
