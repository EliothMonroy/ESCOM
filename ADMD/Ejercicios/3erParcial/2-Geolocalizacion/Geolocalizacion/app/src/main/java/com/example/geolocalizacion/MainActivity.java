package com.example.geolocalizacion;

import android.content.pm.PackageManager;
import android.location.Criteria;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.location.LocationProvider;
import android.os.Build;
import android.support.v4.app.ActivityCompat;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.widget.TextView;

import com.google.android.gms.maps.model.LatLng;

public class MainActivity extends AppCompatActivity {

    TextView txtLatitud, txtLongitud, txtPrecision, txtStatus;
    private LocationManager locationManager = null;
    private LatLng currentLocation = new LatLng(19.504507, -99.146911);
    Location location;
    private int timeUpdateLocation = 10000;
    private float distanceUpateLocation = (float)0.0;
    int precision;
    int status;
    LocationProvider provider;
    boolean altitud;
    int consumoRecursos;
    LocationListener locationListener;
    String provider1;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        Toolbar toolbar=findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);
        getSupportActionBar().setTitle(getText(R.string.app_name));
        getSupportActionBar().setDisplayHomeAsUpEnabled(false);

        //Obtenemos los textviews
        txtLatitud=findViewById(R.id.txtLatitud);
        txtLongitud=findViewById(R.id.txtLongitud);
        txtPrecision=findViewById(R.id.txtPrecision);
        txtStatus=findViewById(R.id.txtStatus);

        //Ubicación
        iniciarUbicacion();

    }

    public void iniciarUbicacion(){
        locationManager=(LocationManager) getSystemService(LOCATION_SERVICE);

        if(Build.VERSION.SDK_INT >= Build.VERSION_CODES.M) {
            if (ActivityCompat.checkSelfPermission(this,
                    android.Manifest.permission.ACCESS_FINE_LOCATION) !=
                    PackageManager.PERMISSION_GRANTED &&
                    ActivityCompat.checkSelfPermission(this,
                            android.Manifest.permission.ACCESS_COARSE_LOCATION) !=
                            PackageManager.PERMISSION_GRANTED) {

                Log.d("initLocationService", "No hay permiso de algo");

                requestPermissions(new String[]{
                        android.Manifest.permission.ACCESS_FINE_LOCATION,
                        android.Manifest.permission.ACCESS_COARSE_LOCATION,
                        android.Manifest.permission.INTERNET
                }, 10);
            } else {
                try {
                    Criteria criteria=new Criteria();
                    criteria.setAccuracy(Criteria.ACCURACY_FINE);
                    criteria.setAltitudeRequired(true);
                    provider1=locationManager.getBestProvider(criteria,false);

                    if(locationManager.isProviderEnabled(provider1)){
                        provider=locationManager.getProvider(provider1);
                        precision=provider.getAccuracy();
                        altitud=provider.supportsAltitude();
                        consumoRecursos=provider.getPowerRequirement();
                        status=1;


                        location=locationManager.getLastKnownLocation(provider1);

                        if(location!=null){
                            Log.d("iniciarUbicacion:", "Location NO es nulo");
                            currentLocation = new LatLng(location.getLatitude(), location.getLongitude());
                        }else{
                            Log.d("iniciarUbicacion:", "Location es nulo");
                        }
                    }else{
                        Log.d("iniciarUbicacion","No encontre el mejor proveedor");
                    }

                }catch (Exception e){
                    Log.d("iniciarUbicacion:", "Error en el try");
                    e.printStackTrace();
                }
            }
        }
    }

    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        switch (requestCode)
        {
            case 10:
                if(grantResults.length>0 && grantResults[0]== PackageManager.PERMISSION_GRANTED) {
                    iniciarUbicacion();
                }
                return;
        }
    }

    public void activar(View view){
        Log.d("ServicioUbicación:", "Activado");

        mostrarUbicacion();

        locationListener=new LocationListener() {
            @Override
            public void onLocationChanged(Location location) {
                Log.d("onLocationChanged:", "Nueva ubicación: lat:"+location.getLatitude()+" lon:"+location.getLongitude());
                currentLocation = new LatLng(location.getLatitude(), location.getLongitude());
                mostrarUbicacion();
            }

            @Override
            public void onStatusChanged(String provider, int status2, Bundle extras) {
                Log.d("onLocationChanged:", "Nueva status: "+status);
                status=status2;
                txtStatus.setText("Status: "+status);
            }

            @Override
            public void onProviderEnabled(String provider) {

            }

            @Override
            public void onProviderDisabled(String provider) {

            }
        };


        try{
            locationManager.requestLocationUpdates(provider1,timeUpdateLocation,distanceUpateLocation,locationListener);
        }catch (SecurityException e){
            e.printStackTrace();
            iniciarUbicacion();
        }


    }

    public void mostrarUbicacion(){
        txtPrecision.setText("Precisión: "+precision);
        txtLatitud.setText("Latitud: "+currentLocation.latitude);
        txtLongitud.setText("Longitud: "+currentLocation.longitude);
        txtStatus.setText("Status: "+status);
    }

    public void desactivar(View view){
        Log.d("ServicioUbicación:", "Desactivado");
        locationManager.removeUpdates(locationListener);
    }
}
