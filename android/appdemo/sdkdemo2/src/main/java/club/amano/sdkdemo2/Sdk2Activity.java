package club.amano.sdkdemo2;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;

public class Sdk2Activity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sdk2);
    }
    public String initSdk2(String name, String code){
        return code + name ;
    }
}
