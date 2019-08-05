package com.example.devicelist;

import android.support.annotation.NonNull;
import android.support.v7.widget.RecyclerView;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ImageView;
import android.widget.TextView;

import java.util.ArrayList;


public class SensorAdapter extends RecyclerView.Adapter<SensorAdapter.ViewHolder> {
    private ArrayList<Sensor> sensors;

    public SensorAdapter(ArrayList<Sensor> sensors) {
        this.sensors = sensors;
    }

    @NonNull
    @Override
    public ViewHolder onCreateViewHolder(@NonNull ViewGroup viewGroup, int i) {
        View view = LayoutInflater.from(viewGroup.getContext()).inflate(R.layout.sensor_item, viewGroup, false);
        return new ViewHolder(view);
    }

    @Override
    public void onBindViewHolder(@NonNull ViewHolder viewHolder, int i) {
        Sensor sensor= sensors.get(viewHolder.getAdapterPosition());
        viewHolder.img.setImageResource(sensor.getImg());
        viewHolder.title.setText(sensor.getTitle());
        viewHolder.type.setText(sensor.getType());
        viewHolder.value.setText(sensor.getValue());
    }

    @Override
    public int getItemCount() {
        return sensors.size();
    }

    public static class ViewHolder extends RecyclerView.ViewHolder{
        private ImageView img;
        private TextView title;
        private TextView type;
        private TextView value;

        public ViewHolder(@NonNull View itemView) {
            super(itemView);
            img = itemView.findViewById(R.id.iv_img);
            title = itemView.findViewById(R.id.tv_title);
            type = itemView.findViewById(R.id.tv_type);
            value = itemView.findViewById(R.id.tv_value);
        }
    }
}
