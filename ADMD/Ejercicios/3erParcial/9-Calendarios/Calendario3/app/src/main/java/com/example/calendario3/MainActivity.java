package com.example.calendario3;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.CalendarView;
import android.widget.TextView;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    CalendarView calendarView;
    TextView dateDisplay;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        calendarView = findViewById(R.id.calendarView);
        dateDisplay = findViewById(R.id.date_display);
        dateDisplay.setText("Fecha: ");
        calendarView.setOnDateChangeListener(new CalendarView.OnDateChangeListener() {
            @Override
            public void onSelectedDayChange(CalendarView calendarView, int i, int i1, int i2) {
                dateDisplay.setText("Fecha: " + i2 + " / " + i1 + " / " + i);
                Toast.makeText(getApplicationContext(), "Fecha seleccionada:\n" + "Día = " + i2 + "\n" + "Mes = " + i1 + "\n" + "Año = " + i, Toast.LENGTH_LONG).show();
            }
        });

    }
}
