package club.amano.sdkdemo;

import android.app.AlertDialog;
import android.content.Context;
import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.view.ViewGroup;
import android.view.Window;
import android.view.WindowManager;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.TextView;

import org.json.JSONException;
import org.json.JSONObject;
import org.w3c.dom.Text;

public class SdkActivity extends AppCompatActivity {

    private static AlertDialog dialog = null;

    private static Context cContext = null;

    private static String TAG = "SdkActivity";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_sdk);
//        cContext = getApplicationContext();


    }
    public void getToken(final String name, final String pass, Context context, final SdkCallBack sdkCallback) {
//        sdkCallback.tokenOnResult(pass, name);
        cContext= context;
        if(cContext != null) {
            dialog = new AlertDialog.Builder(cContext).create();
            dialog.show();    //把AlertDialog初始化
            Window window = dialog.getWindow(); //实例化一个窗口
            window.setContentView(R.layout.activity_sdk);//调用自定义的XML放到AlertDialog中展示
            window.setWindowAnimations(R.style.dialog_style);
            window.setLayout((ViewGroup.LayoutParams.MATCH_PARENT), ViewGroup.LayoutParams.MATCH_PARENT);
            window.setBackgroundDrawable(null);

            Button cancelBtn = dialog.findViewById(R.id.cancelBtn);
            Button confirmBtn= dialog.findViewById(R.id.confirmBtn);

            TextView nameValue = dialog.findViewById(R.id.nameValue);
            TextView passValue = dialog.findViewById(R.id.passValue);
            nameValue.setText(name);
            passValue.setText(pass);

            cancelBtn.setOnClickListener(new View.OnClickListener(){
                @Override
                public void onClick(View v) {
                    dialog.dismiss();
                    Log.d(TAG, "onClick: cancelBtn");
                    sdkCallback.tokenOnResult(null, name);
                }
            });
            confirmBtn.setOnClickListener(new View.OnClickListener(){
                @Override
                public void onClick(View v) {
                    Log.d(TAG, "onClick: confirmBtn");
                    Api.fetchDate(name, pass, new Callback() {
                        @Override
                        public void response(JSONObject response) {
                            Log.d(TAG, "success: response" + response.toString());

                            dialog.dismiss();
                            try {
                                String name = response.getString("name");
                                String date = response.getString("date");
                                sdkCallback.tokenOnResult(date, name);
                            } catch (JSONException e) {
                                e.printStackTrace();
                            }

                        }
                    });
                }
            });

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
