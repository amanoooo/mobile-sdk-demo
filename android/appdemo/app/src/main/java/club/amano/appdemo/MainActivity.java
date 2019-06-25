package club.amano.appdemo;

import android.os.Bundle;
import android.os.Handler;
import android.support.design.widget.FloatingActionButton;
import android.support.design.widget.Snackbar;
import android.support.v7.app.AppCompatActivity;
import android.support.v7.widget.Toolbar;
import android.util.Log;
import android.view.View;
import android.view.Menu;
import android.view.MenuItem;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;

import club.amano.sdkdemo.SdkActivity;
import club.amano.sdkdemo.SdkCallBack;
import club.amano.sdkdemo2.Sdk2Activity;

public class MainActivity extends AppCompatActivity {

    private Handler uiHandler = null;

    private static String TAG = "MainActivity";
    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        uiHandler = new Handler();
        setContentView(R.layout.activity_main);
        Toolbar toolbar = findViewById(R.id.toolbar);
        setSupportActionBar(toolbar);

        FloatingActionButton fab = findViewById(R.id.fab);
        fab.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {
                Snackbar.make(view, "Replace with your own action", Snackbar.LENGTH_LONG)
                        .setAction("Action", null).show();
            }
        });


        Log.d(TAG, "onCreate" );

        Button btn = (Button) findViewById(R.id.btn);


        btn.setOnClickListener(new View.OnClickListener() {
            @Override
            public void onClick(View view) {

                EditText nameText = findViewById(R.id.nameText);
                EditText passText = findViewById(R.id.passText);
                String name = nameText.getText().toString();
                String pass = passText.getText().toString();

                SdkActivity sdk = new SdkActivity();
                SdkCallBack sdkCallback = new SdkCallBack() {
                    @Override
                    public void tokenOnResult(final String token, final String name) {
                        Log.d(TAG, "tokenOnResult: token: " + token + " name : " + name);


                        uiHandler.post(new Runnable() {
                            @Override
                            public void run() {
                                Log.d(TAG, "run: ");
                                Toast toast=Toast.makeText(getApplicationContext(),"test",Toast.LENGTH_LONG);
                                toast.show();
                                TextView tokenText = findViewById(R.id.valueLabel);
                                tokenText.setText(token);
                            }
                        });
                    }
                };
                sdk.getToken(name, pass, MainActivity.this, sdkCallback);
            }
        });
    }

    @Override
    public boolean onCreateOptionsMenu(Menu menu) {
        // Inflate the menu; this adds items to the action bar if it is present.
        getMenuInflater().inflate(R.menu.menu_main, menu);
        return true;
    }

    @Override
    public boolean onOptionsItemSelected(MenuItem item) {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        int id = item.getItemId();

        //noinspection SimplifiableIfStatement
        if (id == R.id.action_settings) {
            return true;
        }

        return super.onOptionsItemSelected(item);
    }



}
