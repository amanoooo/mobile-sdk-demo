package club.amano.sdkdemo;

import android.support.annotation.NonNull;
import android.util.Log;
import android.widget.Toast;

import org.json.JSONObject;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.InputStream;
import java.net.CookieHandler;
import java.net.CookieManager;
import java.net.URL;
import java.net.URLEncoder;
import java.util.HashMap;

import javax.net.ssl.HttpsURLConnection;

public class Api {


    private static String content_url = "https://util.online/";

    // session id
    private static String jSessionId = null;

    private static String TAG = "Api";
    /**
     *
     * @param name
     * @param pass
     * @param callBack
     */
    public static void fetchDate(@NonNull String name, @NonNull String pass, Callback callBack) {
        jSessionId = null;
        get(content_url + "sdk?name="+ name +"&pass="+ pass, null, callBack);
    }


    public static void get(String url, HashMap<String, String> paramsMap, Callback callBack) {
        http(url, null, "GET", callBack);
    }

    public static void post(String url, HashMap<String, String> paramsMap, Callback callBack) {
        http(url, paramsMap, "POST", callBack);
    }

    private static void http(final String baseUrl, final HashMap<String, String> paramsMap , final String method, final Callback callBack) {
        new Thread(new Runnable() {
            @Override
            public void run() {
                try {

                    String postData = null;

                    StringBuilder tempParams = new StringBuilder();
                    if (paramsMap != null) {
                        if (method.equals("GET")) {
                            int pos = 0;
                            for (String key : paramsMap.keySet()) {
                                if (pos > 0) {
                                    tempParams.append("&");
                                }
                                tempParams.append(String.format("%s=%s", key, URLEncoder.encode(paramsMap.get(key),"utf-8")));
                                pos++;
                            }
                        } else {
                            JSONObject jsonObject = new JSONObject(paramsMap);
                            postData = jsonObject.toString();
                        }

                    }

                    CookieManager manager = new CookieManager();
                    CookieHandler.setDefault(manager);
                    String requestUrl = baseUrl + tempParams.toString();
                    // 新建一个URL对象
                    URL url = new URL(requestUrl);
                    // 打开一个HttpURLConnection连接
                    HttpsURLConnection urlConn = (HttpsURLConnection) url.openConnection();
                    // 设置连接主机超时时间
                    urlConn.setConnectTimeout(5 * 1000);
                    //设置从主机读取数据超时
                    urlConn.setReadTimeout(5 * 1000);
                    // 设置是否使用缓存  默认是true
                    urlConn.setUseCaches(true);
                    // 设置为Post请求
                    urlConn.setRequestMethod(method);
                    //urlConn设置请求头信息
                    //设置请求中的媒体类型信息。
                    urlConn.setRequestProperty("Content-Type", "application/json");
                    //设置客户端与服务连接类型
                    urlConn.addRequestProperty("Connection", "Keep-Alive");

                    if (jSessionId != null) {
                        urlConn.setRequestProperty("Cookie", jSessionId);
                    }

                    // 开始连接
                    urlConn.connect();
                    if (!method.equals("GET") && paramsMap != null) {
                        // 发送请求参数
                        byte[] postDataByte = postData.getBytes();
                        DataOutputStream dos = new DataOutputStream(urlConn.getOutputStream());
                        dos.write(postDataByte);
                        dos.flush();
                        dos.close();
                    }
                    if (urlConn.getHeaderField("Set-Cookie") != null) {
                        jSessionId = urlConn.getHeaderField("Set-Cookie");
                    }

                    // 判断请求是否成功
                    if (urlConn.getResponseCode() == 200) {

                        // 获取返回的数据
                        String result = streamToString(urlConn.getInputStream());
                        JSONObject jsonObject = new JSONObject(result);
                        Log.i(TAG, method + "方式请求成功，result--->" + result + "\n url:" + baseUrl);
                        callBack.response(jsonObject);
                    } else {
                        callBack.response(null);
                    }
                    // 关闭连接
                    urlConn.disconnect();
                } catch (Exception e) {
                    Log.e("http error", e.toString());
                }
            }
        }).start();


    }

    /**
     * 将输入流转换成字符串
     *
     * @param is 从网络获取的输入流
     * @return
     */
    private static String streamToString(InputStream is) {
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            byte[] buffer = new byte[1024];
            int len = 0;
            while ((len = is.read(buffer)) != -1) {
                baos.write(buffer, 0, len);
            }
            baos.close();
            is.close();
            byte[] byteArray = baos.toByteArray();
            return new String(byteArray);
        } catch (Exception e) {
            Log.e(TAG, e.toString());
            return null;
        }
    }


}
