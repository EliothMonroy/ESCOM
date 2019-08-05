package com.example.examenmatrices;

import android.content.Intent;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    EditText a1,a2,b1,b2;
    Intent intent;
    Bundle bundle;
    Button button;
    String a1Texto,a2Texto,b1Texto,b2Texto;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getSupportActionBar().setTitle("Examen 3");
        a1=findViewById(R.id.editText);
        a2=findViewById(R.id.editText2);
        b1=findViewById(R.id.editText3);
        b2=findViewById(R.id.editText4);
        button=findViewById(R.id.button);
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                bundle=new Bundle();
                a1Texto=a1.getText().toString();
                a2Texto=a2.getText().toString();
                b1Texto=b1.getText().toString();
                b2Texto=b2.getText().toString();
                if(a2Texto.equals(b1Texto)){
                    //Toast.makeText(getBaseContext(),"Todo correcto",Toast.LENGTH_LONG).show();
                    bundle.putString("a1",a1Texto);
                    bundle.putString("a2",a2Texto);
                    bundle.putString("b1",b1Texto);
                    bundle.putString("b2",b2Texto);
                    intent=new Intent(MainActivity.this,Tabla.class);
                    intent.putExtras(bundle);
                    startActivity(intent);
                }else{
                    Toast.makeText(getBaseContext(),"Las dimensiones de las matrices no coinciden",Toast.LENGTH_LONG).show();
                }
            }
        });
    }
}