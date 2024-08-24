package com.example.networktimetest;
//import android.Manifest;
//import android.content.pm.PackageManager;
//import android.location.Address;
//import android.location.Geocoder;
//import android.location.Location;
//import android.location.LocationManager;
//import android.os.Build;
//import android.os.Bundle;
//import android.widget.TextView;
//
//import androidx.annotation.RequiresApi;
//import androidx.appcompat.app.AppCompatActivity;
//import androidx.core.app.ActivityCompat;
//
//import java.io.IOException;
//import java.text.SimpleDateFormat;
//import java.util.Date;
//import java.util.List;
//import java.util.Locale;
//
//public class MainActivity extends AppCompatActivity {
//    TextView textView;
//    Location location;
//    double describeContents;
//    List<Address> addresses;
//    Geocoder geocoder;
//
//    @RequiresApi(api = Build.VERSION_CODES.P)
//    @Override
//    protected void onCreate(Bundle savedInstanceState) {
//        super.onCreate(savedInstanceState);
//        setContentView(R.layout.activity_main);
//        textView = findViewById(R.id.text);
//        LocationManager locationManager = (LocationManager) this.getSystemService(LOCATION_SERVICE);
//        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
//            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION}, 101);
//        }
//        location = locationManager
//                .getLastKnownLocation(LocationManager.NETWORK_PROVIDER);
//        geocoder= new Geocoder(this);
//    }
//
//    @RequiresApi(api = Build.VERSION_CODES.O)
//    @Override
//    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
//        switch (requestCode) {
//            case 101:
//                if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
//                    if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
//                        return;
//                    }
//                    System.out.println(location.getLatitude() + " " + location.getLatitude());
//                    textView.setText(" "+location.getLongitude() + " " + location.getLatitude()+" "+convertTimeStampToTime(location.getTime()));
//                } else {
//                    //not granted
//                }
//                break;
//            default:
//                super.onRequestPermissionsResult(requestCode, permissions, grantResults);
//        }
//    }
//
//    @RequiresApi(api = Build.VERSION_CODES.O)
//    @Override
//    protected void onResume() {
//        super.onResume();
//        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
//            return;
//        }
//        textView.setText(" long"+location.getLongitude() + " lat" + location.getLatitude()+" "+convertTimeStampToTime(location.getTime()));
//    }
//
//    private String convertTimeStampToTime(long timestamp) {
//        System.out.println(timestamp);
//        Date date = new Date(timestamp);
//        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss", Locale.getDefault());
//        return sdf.format(date);
//    }
import android.Manifest;
import android.content.Context;
import android.content.pm.PackageManager;
import android.location.Address;
import android.location.Geocoder;
import android.location.Location;
import android.location.LocationListener;
import android.location.LocationManager;
import android.os.Build;
import android.os.Bundle;
import android.widget.TextView;
import android.widget.Toast;

import androidx.annotation.NonNull;
import androidx.annotation.RequiresApi;
import androidx.appcompat.app.AppCompatActivity;
import androidx.core.app.ActivityCompat;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import static android.content.Context.LOCATION_SERVICE;

//public class MyLocationListener implements LocationListener {
//
//    public void onLocationChanged(Location location) {
//
//        if (location != null) {
//
//            locManager.removeUpdates(locListener); //change by HMN on 18-06-2022
//            //location.getLongitude();
//            //location.getLatitude();
//
//            longitude = "" + location.getLongitude();
//            latitude = "" + location.getLatitude();
//
//            Toast.makeText(appContext, "Location Updates received Via GPS " + longitude + "," + latitude ,
//                    Toast.LENGTH_SHORT).show();
//
//            isGPSActive = true;
//
//            if(isValidateCustomerLocation.equals("1")) {
//                ValidateCustomerLocation();
//            }
//        }
//        else
//        {
//            isGPSActive = false;
////                Toast.makeText(appContext, "No Location Updates Via GPS " + longitude + "," + latitude ,
////                        Toast.LENGTH_SHORT).show();
//        }
//    }
//
//    public void onProviderDisabled(String provider) {
//
//    }
//
//    public void onProviderEnabled(String provider) {
//
//    }
//
//    public void onStatusChanged(String provider, int status, Bundle extras) {
//        /* This is called when the GPS status alters */
//
////            longitude = String.valueOf(gps.getLongitude());
////            latitude = String.valueOf(gps.getLatitude());
////            Toast.makeText(appContext, "Location found Via GPS",
////                    Toast.LENGTH_SHORT).show();
//
//        Toast.makeText(appContext, "Provide:" + provider + "Status :" + String.valueOf(status),
//                Toast.LENGTH_SHORT).show();
//          /*  switch (status) {
//                case 0:
//
//                    Toast.makeText(this, "Status Changed: Out of Service",
//                            Toast.LENGTH_SHORT).show();
//                    break;
//                case LocationProvider.TEMPORARILY_UNAVAILABLE:
//                    Log.v(tag, "Status Changed: Temporarily Unavailable");
//                    Toast.makeText(this, "Status Changed: Temporarily Unavailable",
//                            Toast.LENGTH_SHORT).show();
//                    break;
//                case LocationProvider.AVAILABLE:
//                    Log.v(tag, "Status Changed: Available");
//                    Toast.makeText(this, "Status Changed: Available",
//                            Toast.LENGTH_SHORT).show();
//                    break;
//            }*/
//    }
//}
//

public class MainActivity extends AppCompatActivity {
    TextView textView;
    Location location;
    double describeContents;
    List<Address> addresses;
    Geocoder geocoder;
    private LocationManager locationManager;
    private LocationListener locationListener;


    @RequiresApi(api = Build.VERSION_CODES.P)
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);
        textView = findViewById(R.id.text);
        LocationManager locationManager = (LocationManager) this.getSystemService(LOCATION_SERVICE);
//        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
//            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION}, 101);
//        }
//        location = locationManager
//                .getLastKnownLocation(LocationManager.NETWORK_PROVIDER);
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED &&
                ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            ActivityCompat.requestPermissions(this, new String[]{Manifest.permission.ACCESS_FINE_LOCATION, Manifest.permission.ACCESS_COARSE_LOCATION}, 101);
        } else {
            // Permissions already granted, start location updates
            startLocationUpdates();
        }
        geocoder = new Geocoder(this);
    }

    private void startLocationUpdates() {
        locationListener = new LocationListener() {
            @Override
            public void onLocationChanged(@NonNull Location location) {
                // Update the TextView with the time of the most recent location
                textView.setText(String.valueOf(location.getTime()));
            }

            @Override
            public void onProviderEnabled(@NonNull String provider) {
            }

            @Override
            public void onProviderDisabled(@NonNull String provider) {
            }

            @Override
            public void onStatusChanged(String provider, int status, Bundle extras) {
            }
        };

        // Request location updates
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            // TODO: Consider calling
            //    ActivityCompat#requestPermissions
            // here to request the missing permissions, and then overriding
            //   public void onRequestPermissionsResult(int requestCode, String[] permissions,
            //                                          int[] grantResults)
            // to handle the case where the user grants the permission. See the documentation
            // for ActivityCompat#requestPermissions for more details.
            return;
        }
        locationManager.requestLocationUpdates(LocationManager.NETWORK_PROVIDER, 0, 0, locationListener);
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    @Override
    public void onRequestPermissionsResult(int requestCode, String[] permissions, int[] grantResults) {
        switch (requestCode) {
            case 101:
                if (grantResults[0] == PackageManager.PERMISSION_GRANTED) {
                    if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
                        return;
                    }
                    textView.setText("" + convertTimestampToDate(location.getTime()));
                } else {
                    //not granted
                }
                break;
            default:
                super.onRequestPermissionsResult(requestCode, permissions, grantResults);
        }
    }

    @RequiresApi(api = Build.VERSION_CODES.O)
    @Override
    protected void onResume() {
        super.onResume();
        if (ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_FINE_LOCATION) != PackageManager.PERMISSION_GRANTED && ActivityCompat.checkSelfPermission(this, Manifest.permission.ACCESS_COARSE_LOCATION) != PackageManager.PERMISSION_GRANTED) {
            return;
        }
        textView.setText("" + convertTimestampToDate(location.getTime()));
    }

    private String convertTimestampToDate(long timestamp) {
        Date date = new Date(timestamp);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss", Locale.getDefault());
        return sdf.format(date);
    }
}