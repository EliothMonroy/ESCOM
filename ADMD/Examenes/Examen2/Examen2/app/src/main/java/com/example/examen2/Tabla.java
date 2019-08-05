package com.example.examen2;

import android.content.Intent;
import android.support.v4.app.FragmentManager;
import android.support.v4.app.FragmentTransaction;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TableLayout;
import android.widget.TableRow;
import android.widget.TextView;
import android.widget.Toast;

public class Tabla extends AppCompatActivity {
    Bundle bundle;
    //TextView a,b;
    TableLayout tabla1,tabla2;
    EditText a[][];
    EditText b[][];
    int [][]valores1;
    int [][]valores2;
    int producto[][]=new int[10][10];
    int a1,a2,b1,b2;
    Button button;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_tabla);
        bundle=getIntent().getExtras();
        button=findViewById(R.id.boton);
        a1=Integer.parseInt(bundle.getString("a1"));
        a2=Integer.parseInt(bundle.getString("a2"));
        b1=Integer.parseInt(bundle.getString("b1"));
        b2=Integer.parseInt(bundle.getString("b2"));
        getSupportActionBar().setTitle("Examen 2");

        tabla1=findViewById(R.id.tabla1);
        tabla2=findViewById(R.id.tabla3);
        a=new EditText[a1][a2];
        b=new EditText[b1][b2];
        for(int i=0;i<a1;i++){
            TableRow tableRow1=new TableRow(this);
            for (int j=0;j<a2;j++){
                a[i][j]=new EditText(this);
                tableRow1.addView(a[i][j]);
            }
            tabla1.addView(tableRow1);
        }
        for(int i=0;i<b1;i++){
            TableRow tableRow1=new TableRow(this);
            for (int j=0;j<b2;j++){
                b[i][j]=new EditText(this);
                tableRow1.addView(b[i][j]);
            }
            tabla2.addView(tableRow1);
        }

        button.setOnClickListener(new View.OnClickListener(){
            @Override
            public void onClick(View v) {
                valores1=new int[a1][a2];
                valores2=new int[b1][b2];
                producto=new int[a1][b2];
                for (int i=0;i<a1;i++){
                    for(int j=0;j<a2;j++){
                        valores1[i][j]=Integer.parseInt(a[i][j].getText().toString());

                    }
                }
                for (int i=0;i<b1;i++){
                    for(int j=0;j<b2;j++){

                        valores2[i][j]=Integer.parseInt(b[i][j].getText().toString());
                    }
                }
                int c=0;

                for (int i = 0; i < a1; i++) {
                    for (int j = 0; j < b2; j++) {
                        producto[i][j] = 0;
                        for (int k = 0; k < a2; k++) {
                            producto[i][j]+=valores1[i][k]*valores2[k][j];
                        }
                    }
                }

                //Log.d("mensaje:",""+producto);
                //Toast.makeText(getBaseContext(),"Producto terminado",Toast.LENGTH_LONG).show();

                FragmentManager fm=getSupportFragmentManager();
                Resultado resultado=new Resultado();
                Bundle bundle=new Bundle();
                bundle.putSerializable("RESULTADO",producto);
                resultado.setArguments(bundle);
                FragmentTransaction ft=fm.beginTransaction();
                ft.add(R.id.frame,resultado,"String");
                ft.commit();
            }
        });

        //this.setContentView(tableLayout, new TableLayout.LayoutParams(ViewGroup.LayoutParams.MATCH_PARENT, TableLayout.LayoutParams.MATCH_PARENT));
    }
    public void regresar(View view){
        startActivity(new Intent(this,MainActivity.class));
    }

}
