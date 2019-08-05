package com.example.androidvideo;

import android.net.Uri;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.widget.MediaController;
import android.widget.VideoView;

public class MainActivity extends AppCompatActivity {

    VideoView videoView;
    MediaController mediaController;
    Uri uri;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        videoView=findViewById(R.id.videoView);
        mediaController=new MediaController(this);

        String uriPath = "android.resource://"+getPackageName()+"/"+R.raw.video;

        uri=Uri.parse(uriPath);
        videoView.setVideoURI(uri);

        videoView.setMediaController(mediaController);
        videoView.start();

    }
}
