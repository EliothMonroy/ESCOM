package com.durazno.accelerometer.utils;

import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.TextView;

import androidx.annotation.NonNull;
import androidx.recyclerview.widget.RecyclerView;

import com.durazno.accelerometer.R;
import com.durazno.accelerometer.entities.BluetoothDevice;

import java.util.List;

import butterknife.BindView;
import butterknife.ButterKnife;

public class BluetoothDeviceAdapter extends RecyclerView.Adapter<BluetoothDeviceAdapter.BluetoothDevicesHolder> {

    List<BluetoothDevice> bluetoothDevices;

    public BluetoothDeviceAdapter(List<BluetoothDevice> bluetoothDevices) {
        this.bluetoothDevices = bluetoothDevices;
    }

    @NonNull
    @Override
    public BluetoothDevicesHolder onCreateViewHolder(@NonNull ViewGroup parent, int viewType) {
        return new BluetoothDevicesHolder(LayoutInflater.from(parent.getContext()).inflate(R.layout.item_bluetooth_device, parent, false));
    }

    @Override
    public void onBindViewHolder(@NonNull BluetoothDevicesHolder holder, int position) {
        holder.name.setText(bluetoothDevices.get(position).getName());
        holder.address.setText(bluetoothDevices.get(position).getAddress());
    }

    @Override
    public int getItemCount() {
        return bluetoothDevices.size();
    }

    public class BluetoothDevicesHolder extends RecyclerView.ViewHolder{

        @BindView(R.id.tv_name)
        TextView name;
        @BindView(R.id.tv_address)
        TextView address;

        public BluetoothDevicesHolder(@NonNull View itemView) {
            super(itemView);
            ButterKnife.bind(this, itemView);
        }
    }

}
