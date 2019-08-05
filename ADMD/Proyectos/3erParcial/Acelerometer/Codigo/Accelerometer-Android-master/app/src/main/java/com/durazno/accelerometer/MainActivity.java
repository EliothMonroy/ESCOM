package com.durazno.accelerometer;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.bluetooth.BluetoothSocket;
import android.content.Context;
import android.hardware.Sensor;
import android.hardware.SensorEvent;
import android.hardware.SensorEventListener;
import android.hardware.SensorManager;
import android.os.AsyncTask;
import android.os.Bundle;
import android.os.Handler;
import android.util.Log;
import android.widget.TextView;
import android.widget.Toast;
import android.widget.ToggleButton;

import androidx.appcompat.app.AppCompatActivity;

import com.durazno.accelerometer.entities.ValueSender;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.DecimalFormat;
import java.util.UUID;

import butterknife.BindView;
import butterknife.ButterKnife;

public class MainActivity extends AppCompatActivity implements SensorEventListener {

    private static final String TAG = "MainActivity";
    private static final UUID mUUID = UUID.fromString("00001101-0000-1000-8000-00805F9B34FB");


    private boolean rightAxis = false;
    private boolean leftAxis = false;
    private boolean topAxis = false;
    private boolean bottomAxis = false;
    private boolean topLeftAxis = false;
    private boolean bottomLeftAxis = false;
    private boolean topRightAxis = false;
    private boolean bottomRightAxis = false;
    private boolean isBtConnected = false;
    private boolean centerAxis = false;

    private ValueSender valueSender;
    private String address;

    BluetoothAdapter myBluetooth = null;
    BluetoothSocket btSocket = null;
    InputStream socketInputStream;
    OutputStream socketOutputStream;

    //View Objects
    @BindView(R.id.btn_bottom)
    ToggleButton bottom;
    @BindView(R.id.btn_top)
    ToggleButton top;
    @BindView(R.id.btn_left)
    ToggleButton left;
    @BindView(R.id.btn_right)
    ToggleButton right;
    @BindView(R.id.btn_center)
    ToggleButton center;

    @BindView(R.id.btn_bottomRight)
    ToggleButton bottomRight;
    @BindView(R.id.btn_topRight)
    ToggleButton topRight;
    @BindView(R.id.btn_bottomLeft)
    ToggleButton bottomLeft;
    @BindView(R.id.btn_topLeft)
    ToggleButton topLeft;

    @BindView(R.id.tv_datosX)
    TextView tvDatosX;
    @BindView(R.id.tv_datosY)
    TextView tvDatosY;
    @BindView(R.id.tv_datosZ)
    TextView tvDatosZ;
    @BindView(R.id.tv_datosBt)
    TextView tvDatosBt;


    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        ButterKnife.bind(this);

        SensorManager mSensorManager;
        Sensor sensor;

        address = getIntent().getStringExtra(DiscoverActivity.EXTRA_ADDRESS);

        valueSender = new ValueSender("d0");

        Log.d(TAG, "onCreate: Initializing Sensor Services");
        mSensorManager = (SensorManager) getSystemService(Context.SENSOR_SERVICE);
        sensor = mSensorManager.getDefaultSensor(Sensor.TYPE_ACCELEROMETER);

        mSensorManager.registerListener(this, sensor, SensorManager.SENSOR_DELAY_NORMAL);
        Log.d(TAG, "onCreate: Registered accelerometer");

        new ConnectBT(valueSender).execute();

    }

    @Override
    public void onSensorChanged(SensorEvent event) {

        int value = 0;
        String s = "";

        float x = event.values[0];
        float y = event.values[1];
        float z = event.values[2];

        if (x > 0.85) {
            leftAxis = true;
            rightAxis = false;
            value += 8;
        } else if (x < -.85) {
            rightAxis = true;
            leftAxis = false;
            value += 32;
        } else {
            rightAxis = false;
            leftAxis = false;
        }

        if (y > 0.85) {
            bottomAxis = true;
            topAxis = false;
            value += 2;
        } else if (y < -.85) {
            topAxis = true;
            bottomAxis = false;
            value += 128;
        } else {
            topAxis = bottomAxis= false;
        }

        if (topAxis) {
            if (leftAxis) {
                value -= 72;
                topLeftAxis = true;
                topAxis = leftAxis = false;
            }else{
                topLeftAxis = false;
            }

            if (rightAxis) {
                value += 96;
                topRightAxis = true;
                topAxis = rightAxis = false;
            }else{
                topRightAxis = false;
            }
        } else {
            topLeftAxis = topRightAxis = false;
        }

        if (bottomAxis) {
            if (leftAxis) {
                value -= 9;
                bottomLeftAxis = true;
                leftAxis = false;
            }
            if (rightAxis) {
                value -= 30;
                bottomRightAxis = true;
                rightAxis = false;
            }
        } else {
            bottomRightAxis = false;
            bottomLeftAxis = false;
        }
        if (z < 9 || z > 10) {
            centerAxis = true;
            s = "1" + value;
        } else {
            centerAxis = false;
            s = "0" + value;
        }

        valueSender.setValue(s);

        updateToggleButton();

        DecimalFormat decimalFormat = new DecimalFormat();
        decimalFormat.setMaximumFractionDigits(2);

        Log.d(TAG, "onSensorChanged: Z: " + event.values[2]);
        tvDatosX.setText(getString(R.string.X, decimalFormat.format(x)));
        tvDatosY.setText(getString(R.string.Y, decimalFormat.format(y)));
        tvDatosZ.setText(getString(R.string.Z, decimalFormat.format(z)));
        tvDatosBt.setText(getString(R.string.Bt, valueSender.getValue()));

    }

    private void updateToggleButton() {
        top.setChecked(topAxis);
        bottom.setChecked(bottomAxis);
        right.setChecked(rightAxis);
        left.setChecked(leftAxis);
        topLeft.setChecked(topLeftAxis);
        topRight.setChecked(topRightAxis);
        bottomLeft.setChecked(bottomLeftAxis);
        bottomRight.setChecked(bottomRightAxis);
        center.setChecked(centerAxis);
    }

    @Override
    public void onAccuracyChanged(Sensor sensor, int accuracy) {
        Log.d(TAG, "onAccuracyChanged: ");
    }


    private class ConnectBT extends AsyncTask<Void, Void, Void> {


        private boolean connectSuccess = true; //if it's here, it's almost connected

        private ValueSender valueSender;
        String readMessage = "1";

        public ConnectBT(ValueSender valueSender) {
            this.valueSender = valueSender;
        }


        @Override
        protected Void doInBackground(Void... devices) //while the progress dialog is shown, the connection is done in background
        {
            try {
                if (btSocket == null || !isBtConnected) {
                    myBluetooth = BluetoothAdapter.getDefaultAdapter();//get the mobile bluetooth device
                    BluetoothDevice device = myBluetooth.getRemoteDevice(address);//connects to the device's address and checks if it's available
                    btSocket = device.createInsecureRfcommSocketToServiceRecord(mUUID);//create a RFCOMM (SPP) connection
                    BluetoothAdapter.getDefaultAdapter().cancelDiscovery();
                    btSocket.connect();//start connection
                }
            } catch (IOException e) {
                Log.d(TAG, "doInBackground: "+ e.toString());
                connectSuccess = false;//if the try failed, you can check the exception here
            }
            return null;
        }

        @Override
        protected void onPostExecute(Void result) {
            super.onPostExecute(result);

            if (!connectSuccess) {
                msg("Connection Failed. Is it a SPP Bluetooth? Try again.");
                finish();
            } else {
                msg("Connected.");
                isBtConnected = true;

                try {
                    socketOutputStream = btSocket.getOutputStream();
                    socketInputStream = btSocket.getInputStream();
                    socketOutputStream.flush();
                } catch (Exception e) {
                    Log.d(TAG, "onPostExecute: "+e.toString());
                }

                final Handler handler = new Handler();

                final Runnable[] runnables = new Runnable[1];

                runnables[0] = () -> {
                    try {
                        byte[] buffer2 = new byte[60];
                        byte[] buffer = valueSender.getValue().getBytes();
                        int bytes;
                        if (readMessage.charAt(0) == '1') {
                            socketOutputStream.write(buffer);
                            Log.d(TAG, "onPostExecute: " + readMessage);
                            socketOutputStream.flush();
                        }
                        bytes = socketInputStream.read(buffer2);
                        readMessage = new String(buffer2, 0, bytes);
                    } catch (IOException e) {
                        Log.d(TAG, "onPostExecute: "+ e.toString());
                    }

                    // Repeat every 1 seconds
                    handler.postDelayed(runnables[0], 100);
                };
                handler.post(runnables[0]);
            }
        }

        private void msg(String s) {
            Toast.makeText(getApplicationContext(), s, Toast.LENGTH_LONG).show();
        }
    }
}
