package club.amano.sdkdemo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class SdkActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sdk);
    }
    public static void initSdk(String name, String pass, SdkCallBack sdkCallback) {
        sdkCallback.tokenOnResult(pass, name);
//        return name + pass;
    }
}
