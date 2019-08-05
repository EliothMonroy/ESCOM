package com.example.barrabusqueda;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.SeekBar;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    private SeekBar sb = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getSupportActionBar().setTitle("Barra de búsqueda");

        sb = findViewById(R.id.xsb2);
        sb.setOnSeekBarChangeListener(new SeekBar.OnSeekBarChangeListener() {
            int i = 0;
            public void onProgressChanged(SeekBar sb, int n, boolean b){
                i = n;
            }
            public void onStartTrackingTouch(SeekBar sb) { }
            public void onStopTrackingTouch(SeekBar sb) {
                Toast.makeText(MainActivity.this,"Volumen: " + i, Toast.LENGTH_SHORT).show();
            }
        });

    }
}
