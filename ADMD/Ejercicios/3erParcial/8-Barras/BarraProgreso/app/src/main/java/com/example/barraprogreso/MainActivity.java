package com.example.barraprogreso;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ProgressBar;

public class MainActivity extends AppCompatActivity implements View.OnClickListener {

    ProgressBar jpb1, jpb2;
    Button jbn1;
    int i = 0;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getSupportActionBar().setTitle("Barra de progreso");

        jpb1 = findViewById(R.id.xpb1);
        jpb2 = findViewById(R.id.xpb2);
        jbn1 = findViewById(R.id.xbn); jbn1.setOnClickListener(this);

    }

    public void onClick(View v){
        if (i == 0 || i == 10) {
            jpb1.setVisibility(View.VISIBLE); jpb1.setMax(200);
            jpb2.setVisibility(View.VISIBLE);
        }else if ( i< jpb1.getMax() ) {
            jpb1.setProgress(i);
            jpb1.setSecondaryProgress(i + 1);
        }else {
            jpb1.setProgress(0);
            jpb1.setSecondaryProgress(0);
            i = 0;
            jpb1.setVisibility(View.GONE);
            jpb2.setVisibility(View.GONE);
        }
        i = i + 10;
    }

}
