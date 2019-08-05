package com.example.camara1;

import android.Manifest;
import android.content.Intent;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.v4.app.ActivityCompat;
import android.support.v4.content.FileProvider;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

import java.io.File;
import java.text.SimpleDateFormat;
import java.util.Date;

public class MainActivity extends AppCompatActivity {


    private File file;
    private Button button;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getSupportActionBar().setTitle("Cámara 1");

        file=new File(Environment
                .getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM), "misfotos");


        ActivityCompat.requestPermissions(MainActivity.this,
                new String[]{Manifest.permission.WRITE_EXTERNAL_STORAGE},23);

        button=findViewById(R.id.boton);
        file.mkdirs();

        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                String s=getCode()+".jpg";
                File f1=new File(file,s);
                try{
                    f1.createNewFile();
                }catch (Exception e){
                    e.printStackTrace();
                }

                Uri u = FileProvider.getUriForFile(getApplicationContext(), BuildConfig.APPLICATION_ID + ".provider", f1);

                //Uri u=Uri.fromFile(f1);
                Intent in=new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                in.putExtra(MediaStore.EXTRA_OUTPUT,u);
                startActivityForResult(in,0);
            }
        });

    }

    private String getCode(){
        SimpleDateFormat simpleDateFormat=new SimpleDateFormat("yyyymmddhhmmss");
        return "pic_"+simpleDateFormat.format(new Date());
    }
}
