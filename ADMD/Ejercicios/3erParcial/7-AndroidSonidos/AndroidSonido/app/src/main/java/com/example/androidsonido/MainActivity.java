package com.example.androidsonido;

import android.media.MediaPlayer;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    MediaPlayer mp;
    Button jbn1, jbn2, jbn3, jbn4;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        jbn1 = findViewById(R.id.xbn1);
        jbn2 = findViewById(R.id.xbn2);
        jbn3 = findViewById(R.id.xbn3);
        jbn4 = findViewById(R.id.xbn4);
        jbn1.setOnClickListener(this);
        jbn2.setOnClickListener(this);
        jbn3.setOnClickListener(this);
        jbn4.setOnClickListener(this);
    }
    public void onClick(View v) {
        if (v.getId() == R.id.xbn1) {
            reproducir(R.raw.adele_hello);
        }
        if (v.getId() == R.id.xbn2) {
            reproducir(R.raw.you_got_it);
        }
        if (v.getId() == R.id.xbn3) {
            reproducir(R.raw.ahhh);
        }
        if (v.getId() == R.id.xbn4) {
            reproducir(R.raw.aplauso);
        }
    }
    void reproducir(int cancion){
        if(mp != null) mp.release();
        mp = MediaPlayer.create(this, cancion);
        mp.seekTo(0);
        mp.start();
    }
    public void onPause(){
        super.onPause();
        if(mp != null)
            mp.release();
    }
}
