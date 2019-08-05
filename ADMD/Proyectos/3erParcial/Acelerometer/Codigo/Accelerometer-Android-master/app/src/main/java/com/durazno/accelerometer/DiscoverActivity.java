package com.durazno.accelerometer;

import android.bluetooth.BluetoothAdapter;
import android.bluetooth.BluetoothDevice;
import android.content.Intent;
import android.os.Bundle;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Toast;

import androidx.appcompat.app.AppCompatActivity;
import androidx.appcompat.widget.Toolbar;
import androidx.recyclerview.widget.DefaultItemAnimator;
import androidx.recyclerview.widget.DividerItemDecoration;
import androidx.recyclerview.widget.LinearLayoutManager;
import androidx.recyclerview.widget.RecyclerView;

import com.durazno.accelerometer.utils.BluetoothDeviceAdapter;
import com.durazno.accelerometer.utils.RecyclerTouchListener;

import java.util.ArrayList;
import java.util.List;
import java.util.Set;

import butterknife.BindView;
import butterknife.ButterKnife;

public class DiscoverActivity extends AppCompatActivity {
    public static final String EXTRA_ADDRESS = "device_address";

    private BluetoothDeviceAdapter deviceAdapter;
    private BluetoothAdapter mBluetooth = null;


    private List<com.durazno.accelerometer.entities.BluetoothDevice> bluetoothDevices;

    @BindView(R.id.rv_devices)
    RecyclerView devices;
    @BindView(R.id.toolbar)
    Toolbar toolbar;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_discover);

        ButterKnife.bind(this);

        setSupportActionBar(toolbar);

        mBluetooth = BluetoothAdapter.getDefaultAdapter();

        bluetoothDevices = new ArrayList<>();


        deviceAdapter = new BluetoothDeviceAdapter(bluetoothDevices);

        devices.setLayoutManager(new LinearLayoutManager(getApplicationContext(), RecyclerView.VERTICAL, false));
        devices.addItemDecoration(new DividerItemDecoration(this, DividerItemDecoration.VERTICAL));
        devices.setItemAnimator(new DefaultItemAnimator());
        devices.setAdapter(deviceAdapter);

        devices.addOnItemTouchListener(new RecyclerTouchListener(getApplicationContext(), (view, position) ->
                startActivity(new Intent(DiscoverActivity.this, MainActivity.class)
                        .putExtra(EXTRA_ADDRESS, bluetoothDevices.get(position).getAddress()))
        ));

        if (mBluetooth == null) {
            //Show a mensag. that the device has no bluetooth adapter
            Toast.makeText(getApplicationContext(), "Bluetooth Device Not Available", Toast.LENGTH_LONG).show();
        } else if (!mBluetooth.isEnabled()) {
            //Ask to the user turn the bluetooth on
            Intent turnBTon = new Intent(BluetoothAdapter.ACTION_REQUEST_ENABLE);
            startActivityForResult(turnBTon, 1);
        }

        pairedDevicesList();
    }

    private void pairedDevicesList() {
        Set<BluetoothDevice> pairedDevices = mBluetooth.getBondedDevices();

        if (!pairedDevices.isEmpty()) {
            for (BluetoothDevice bt : pairedDevices) {
                bluetoothDevices.add(new com.durazno.accelerometer.entities.BluetoothDevice(bt.getName(), bt.getAddress()));
            }
        } else {
            Toast.makeText(getApplicationContext(), "No Paired Bluetooth Devices Found.", Toast.LENGTH_LONG).show();
        }
        deviceAdapter.notifyDataSetChanged();
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_refresh) {
            bluetoothDevices = new ArrayList<>();
            pairedDevicesList();
        }

        return super.onOptionsItemSelected(item);
    }
}
