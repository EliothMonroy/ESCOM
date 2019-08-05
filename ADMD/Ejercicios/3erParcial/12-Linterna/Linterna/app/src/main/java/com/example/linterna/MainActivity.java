package com.example.linterna;

import android.content.Context;
import android.content.pm.PackageManager;
import android.hardware.Camera;
import android.hardware.camera2.CameraManager;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class MainActivity extends AppCompatActivity {

    private boolean isLighOn = false;
    private Camera camera;
    private Button button;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        getSupportActionBar().setTitle("Linterna");

        button = findViewById(R.id.buttonFlashlight);
        Context context = this;
        PackageManager pm = context.getPackageManager();
        if (!pm.hasSystemFeature(PackageManager.FEATURE_CAMERA)) {
            Log.e("err", "Device has no camera!");
            return;
        }
        button.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View arg0) {
                if (isLighOn) {
                    try{
                        CameraManager camManager = (CameraManager) getSystemService(Context.CAMERA_SERVICE);
                        String cameraId = camManager.getCameraIdList()[0]; // usualmente la camara delantera esta en la posicion 0
                        camManager.setTorchMode(cameraId, false);
                        isLighOn=false;
                    }catch (Exception e){
                        e.printStackTrace();
                    }

                } else {
                    try{
                        CameraManager camManager = (CameraManager) getSystemService(Context.CAMERA_SERVICE);
                        String cameraId = camManager.getCameraIdList()[0]; // usualmente la camara delantera esta en la posicion 0
                        camManager.setTorchMode(cameraId, true);
                        isLighOn=true;
                    }catch (Exception e){
                        e.printStackTrace();
                    }
                }
            }
        });

    }

}
