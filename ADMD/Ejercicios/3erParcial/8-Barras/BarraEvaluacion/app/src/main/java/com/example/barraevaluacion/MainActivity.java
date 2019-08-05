package com.example.barraevaluacion;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.RatingBar;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    RatingBar   jrb1;
    TextView jtv3;
    Button jbn1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getSupportActionBar().setTitle("Barra de evaluación");
        addListenerOnRatingBar();
        addListenerOnButton();
    }

    public void addListenerOnRatingBar() {
        jrb1 = findViewById(R.id.xrb1);
        jtv3 = findViewById(R.id.xtv3);
        jrb1.setOnRatingBarChangeListener(new RatingBar.OnRatingBarChangeListener() {
            public void onRatingChanged(RatingBar rb, float f, boolean bo) {
                jtv3.setText(String.valueOf(f));
            }
        });
    }
    public void addListenerOnButton() {
        jrb1 = findViewById(R.id.xrb1);
        jbn1 = findViewById(R.id.xbn1); jbn1.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                Toast.makeText(MainActivity.this, "Evaluación: " + jrb1.getRating(), Toast.LENGTH_SHORT).show();
            }
        });
    }

}
