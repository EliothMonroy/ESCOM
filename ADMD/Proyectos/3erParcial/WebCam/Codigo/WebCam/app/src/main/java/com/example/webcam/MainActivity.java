package com.example.webcam;

import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Handler;
import android.os.StrictMode;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.ImageView;

import com.bumptech.glide.Glide;
import com.bumptech.glide.RequestBuilder;
import com.bumptech.glide.load.DataSource;
import com.bumptech.glide.load.engine.DiskCacheStrategy;
import com.bumptech.glide.load.engine.GlideException;
import com.bumptech.glide.request.RequestListener;
import com.bumptech.glide.request.target.Target;
import com.bumptech.glide.request.target.ViewTarget;
import com.nostra13.universalimageloader.core.ImageLoader;
import com.nostra13.universalimageloader.core.ImageLoaderConfiguration;
import com.nostra13.universalimageloader.core.assist.FailReason;
import com.nostra13.universalimageloader.core.listener.ImageLoadingListener;
import com.nostra13.universalimageloader.core.listener.SimpleImageLoadingListener;

import java.io.InputStream;
import java.net.Socket;

public class MainActivity extends AppCompatActivity {

    public final String url="http://10.100.64.27:5000/static/image.jpg";
    ImageView imagen;
    ImageLoader imageLoader;
    public Socket cliente;
    public String HOST="10.100.64.27";
    public int PUERTO=8485;
    InputStream socketInputStream;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getSupportActionBar().setTitle("Proyecto 2");

        imageLoader = ImageLoader.getInstance(); // Get singleton instance

        imagen=findViewById(R.id.image);

        ImageLoader.getInstance().init(ImageLoaderConfiguration.createDefault(MainActivity.this));

        imageLoader.displayImage(url, imagen);

        //Sockets

        /*int SDK_INT = android.os.Build.VERSION.SDK_INT;
        if (SDK_INT > 8)
        {
            StrictMode.ThreadPolicy policy = new StrictMode.ThreadPolicy.Builder()
                    .permitAll().build();
            StrictMode.setThreadPolicy(policy);
            //your codes here
            try{
                cliente=new Socket(HOST,PUERTO);
                Log.e("Socket","ME CONECTE");
            }catch (Exception e){
                Log.e("Socket","NO ME CONECTE");
                e.printStackTrace();
            }
        }*/

        continuar();

    }

    public void continuar(){

        // Create the Handler
        final Handler handler = new Handler();

// Define the code block to be executed

        final Runnable runnable[]=new Runnable[1];

        runnable[0] = new Runnable() {
            @Override
            public void run() {
                // Insert custom code here

                try{
                    imageLoader.displayImage(url, imagen);
                }catch (Exception e){
                    e.printStackTrace();
                }
                /*final int val[]=new int[1];
                val[0]=1;

                byte buffer[]=new byte[4096];
                try{
                    int respuesta=0;
                    socketInputStream=cliente.getInputStream();
                    Bitmap im=BitmapFactory.decodeStream(socketInputStream);
                    imagen.setImageBitmap(im);
                }catch (Exception e){
                    e.printStackTrace();
                }*/
                // Repeat every 2 seconds
                handler.postDelayed(runnable[0], 100);
            }
        };

// Start the Runnable immediately
        handler.post(runnable[0]);

    }

}
