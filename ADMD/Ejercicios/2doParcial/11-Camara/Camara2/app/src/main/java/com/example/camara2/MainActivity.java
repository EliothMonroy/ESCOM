package com.example.camara2;

import android.content.Intent;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.media.MediaScannerConnection;
import android.net.Uri;
import android.os.Environment;
import android.provider.MediaStore;
import android.support.annotation.Nullable;
import android.support.v4.content.FileProvider;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RadioButton;

import java.io.BufferedInputStream;
import java.io.File;
import java.io.InputStream;

public class MainActivity extends AppCompatActivity {

    Button jbn;
    RadioButton jrb1,jrb2;
    Intent i;
    int TAKE_PICTURE=1, SELECT_PICTURE=2;
    String s="";
    File file;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getSupportActionBar().setTitle("Cámara 2");

        file=new File(Environment
                .getExternalStoragePublicDirectory(Environment.DIRECTORY_DCIM), "misfotos");

        jbn=findViewById(R.id.xbn1);
        jbn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View v) {
                jrb1=findViewById(R.id.xrb1);
                jrb2=findViewById(R.id.xrb2);
                i=new Intent(MediaStore.ACTION_IMAGE_CAPTURE);
                int code=TAKE_PICTURE;
                if(jrb1.isChecked()){
                    Uri u = FileProvider.getUriForFile(getApplicationContext(), BuildConfig.APPLICATION_ID + ".provider", file);
                    i.putExtra(MediaStore.EXTRA_OUTPUT,u);
                }else if(jrb2.isChecked()){
                    i=new Intent(Intent.ACTION_PICK, MediaStore.Images.Media.INTERNAL_CONTENT_URI);
                    code=SELECT_PICTURE;
                }
                startActivityForResult(i,code);
            }
        });
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        ImageView imageView=findViewById(R.id.xiv1);
        if(requestCode==TAKE_PICTURE){
            if(data!=null){
                if(data!=null){
                    if(data.hasExtra("data")){
                        imageView.setImageBitmap((Bitmap)data.getParcelableExtra("data"));
                    }
                }else{
                    imageView.setImageBitmap(BitmapFactory.decodeFile(file.getAbsolutePath()));


                    new MediaScannerConnection.MediaScannerConnectionClient(){


                        public MediaScannerConnection mediaScannerConnection=new MediaScannerConnection(getApplicationContext(),this);

                        {
                            mediaScannerConnection.connect();
                        }

                        @Override
                        public void onMediaScannerConnected() {
                            mediaScannerConnection.scanFile(file.getAbsolutePath(),null);
                        }

                        @Override
                        public void onScanCompleted(String path, Uri uri) {
                            mediaScannerConnection.disconnect();
                        }
                    };
                }
            }else if(requestCode==SELECT_PICTURE){
                Uri image=data.getData();
                InputStream is;
                try{
                    is=getContentResolver().openInputStream(image);
                    BufferedInputStream bis=new BufferedInputStream(is);
                    Bitmap bitmap=BitmapFactory.decodeStream(bis);
                    imageView.setImageBitmap(bitmap);
                }catch(Exception e){
                    e.printStackTrace();
                }
            }
        }
    }
}
