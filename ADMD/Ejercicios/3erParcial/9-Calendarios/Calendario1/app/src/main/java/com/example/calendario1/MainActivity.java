package com.example.calendario1;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.CalendarView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    CalendarView cv;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getSupportActionBar().setTitle("Calendario 1");

        cv = findViewById(R.id.xcv);
        cv.setOnDateChangeListener(new CalendarView.OnDateChangeListener() {
            @Override
            public void onSelectedDayChange(CalendarView cv, int y, int m, int d) {
                Toast.makeText(getBaseContext(), "Fecha seleccionada:\n\n" + d + " / " + (m+1) + " / " + y, Toast.LENGTH_LONG).show();
            }
        });

    }
}
