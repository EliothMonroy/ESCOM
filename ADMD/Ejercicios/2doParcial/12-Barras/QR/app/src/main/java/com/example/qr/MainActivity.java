package com.example.qr;

import android.app.Activity;
import android.content.ActivityNotFoundException;
import android.content.Intent;
import android.net.Uri;
import android.support.annotation.Nullable;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.support.v7.app.AlertDialog;
import android.content.DialogInterface;
import android.widget.Toast;

public class MainActivity extends AppCompatActivity {

    private static final String ACTION_SCAN = "com.google.zxing.client.android.SCAN";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

    }

    public void scanBarra(View v){
        try {
            Intent intent = new Intent(ACTION_SCAN);
            intent.putExtra("SCAN_MODE", "PRODUCT_MODE");
            startActivityForResult(intent, 0);
        } catch (ActivityNotFoundException e) {
            showDialog(MainActivity.this, "No hay scanner", "Descargar scanner?", "Si", "No").show();
        }
    }

    public void scanQR(View v){
        try {
            Intent intent = new Intent(ACTION_SCAN);
            intent.putExtra("SCAN_MODE", "QR_CODE_MODE");
            startActivityForResult(intent, 0);
        } catch (ActivityNotFoundException e) {
            showDialog(MainActivity.this, "No hay scanner", "Descargar scanner?", "Si", "No").show();
        }
    }

    private static AlertDialog showDialog(final Activity a, CharSequence st, CharSequence mn, CharSequence bnSi, CharSequence bnNo) {
        AlertDialog.Builder adb = new AlertDialog.Builder(a);
        adb.setTitle(st);
        adb.setMessage(mn);
        adb.setPositiveButton(bnSi, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {
                Uri uri = Uri.parse("market://search?q=pname:" + "com.google.zxing.client.android");
                Intent in = new Intent(Intent.ACTION_VIEW, uri);
                a.startActivity(in);
            }
        });
        adb.setNegativeButton(bnNo, new DialogInterface.OnClickListener() {
            @Override
            public void onClick(DialogInterface dialog, int which) {

            }
        });
        return adb.show();
    }

    @Override
    protected void onActivityResult(int requestCode, int resultCode, @Nullable Intent data) {
        super.onActivityResult(requestCode, resultCode, data);
        if (requestCode == 0) {
            if (resultCode == RESULT_OK) {
                String sr = data.getStringExtra("SCAN_RESULT");
                String sf = data.getStringExtra("SCAN_RESULT_FORMAT");
                Toast t = Toast.makeText(this, "Content: " + sr + " Format: " + sf, Toast.LENGTH_LONG);
                t.show();
            }
        }
    }
}
