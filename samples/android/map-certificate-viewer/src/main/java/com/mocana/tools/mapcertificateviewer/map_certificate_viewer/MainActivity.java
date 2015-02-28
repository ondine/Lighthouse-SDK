package com.mocana.tools.mapcertificateviewer.map_certificate_viewer;

import android.content.Context;
import android.graphics.Color;
import android.media.Image;
import android.support.v7.app.ActionBarActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.Menu;
import android.view.MenuItem;
import android.view.View;
import android.view.ViewGroup;
import android.widget.ArrayAdapter;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.TextView;

import com.mocana.map.android.sdk.MAPCertificateProvider;

import java.security.cert.X509Certificate;
import java.util.ArrayList;


public class MainActivity extends ActionBarActivity {

    final static boolean DEBUG_SDK = true;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        //Call this only in debug mode
        if (DEBUG_SDK) {
            MAPCertificateProvider.initCertificateForDebug(getApplicationContext(), "sample.p12", "secret");
            MAPCertificateProvider.initUserForDebug("jdoe@qwe.com");
        }

        ListView list = (ListView) findViewById(R.id.certificateInfo);

        ImageView icon = (ImageView)findViewById(R.id.icon);
        TextView result = (TextView)findViewById(R.id.text_result);
        MySimpleArrayAdapter adapter = new MySimpleArrayAdapter();
        if (MAPCertificateProvider.hasCertificate()) {
            icon.setImageResource(R.drawable.up);
            result.setText("Found certificate");

            X509Certificate certificate = MAPCertificateProvider.getUserIdentityCertificate();
            adapter.add("Subject Distinguished Name", certificate.getSubjectDN().getName());
            adapter.add("Serial Number", certificate.getSerialNumber().toString());
            adapter.add("Signature Algorithm", certificate.getSigAlgName());
            adapter.add("Issuer Distinguished Name", certificate.getIssuerX500Principal().getName());
            adapter.add("Username", MAPCertificateProvider.getUsername());
        } else {
            icon.setImageResource(R.drawable.down);
            result.setText("Certificate not found");
        }

        if (MAPCertificateProvider.getUsername() != null) {
            adapter.add("Username", MAPCertificateProvider.getUsername());
        }

        if (adapter.getCount() > 0) {
            list.setAdapter(adapter);
            adapter.notifyDataSetChanged();
        }
    }


    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();
        if (id == R.id.action_settings) {
            return true;
        }
        return super.onOptionsItemSelected(item);
    }

    private class Data {
        private String mLabel;
        private String mValue;
    }

    private class MySimpleArrayAdapter extends ArrayAdapter<Data> {

        public MySimpleArrayAdapter() {
            super(MainActivity.this, R.layout.listview);
        }

        public void add(String label, String value) {
            Data data = new Data();
            data.mLabel = label;
            data.mValue = value;
            super.add(data);
        }

        public View getView(int position, View convertView, ViewGroup parent) {
            LayoutInflater inflater = (LayoutInflater) MainActivity.this.getSystemService(Context.LAYOUT_INFLATER_SERVICE);
            View rowView = inflater.inflate(R.layout.listview, parent, false);
            TextView label = (TextView) rowView.findViewById(R.id.label);
            label.setText(this.getItem(position).mLabel);
            TextView value = (TextView) rowView.findViewById(R.id.value);
            value.setText(this.getItem(position).mValue);
            return rowView;
        }
    }
}
