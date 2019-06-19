package club.amano.sdkdemo;

import android.app.AlertDialog;
import android.content.Context;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;

public class SdkActivity extends AppCompatActivity {

    private static AlertDialog dialog = null;

    private static Context cContext = null;

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sdk);
//        cContext = getApplicationContext();
    }
    public static void getToken(String name, String pass, Context context, SdkCallBack sdkCallback) {
//        sdkCallback.tokenOnResult(pass, name);
        cContext= context;
        if(cContext != null) {
            dialog = new AlertDialog.Builder(cContext).create();
            dialog.show();    //把AlertDialog初始化
            Window window = dialog.getWindow(); //实例化一个窗口
            window.setContentView(R.layout.activity_sdk);//调用自定义的XML放到AlertDialog中展示
            window.setWindowAnimations(R.style.dialog_style);
            window.setLayout((ViewGroup.LayoutParams.MATCH_PARENT), ViewGroup.LayoutParams.MATCH_PARENT);
//            window.setBackgroundDrawable(null);
        }


//        window.findViewById(R.id.alertView).setOnClickListener(new View.OnClickListener() {
//            @Override
//            public void onClick(View view) {
//                InputMethodManager imm = (InputMethodManager) view.getContext()
//                        .getSystemService(Context.INPUT_METHOD_SERVICE);
//                if (imm != null) {
//                    imm.hideSoftInputFromWindow(view.getWindowToken(),0);
//                }
//            }
//        });
//        return name + pass;
    }
}
