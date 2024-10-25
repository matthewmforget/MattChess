package com.example.myapp;

import io.flutter.embedding.android.FlutterActivity;
import io.flutter.embedding.engine.FlutterEngine;
import io.flutter.plugin.common.MethodChannel;

public class MainActivity extends FlutterActivity {
    private static final String CHANNEL = "com.example.myapp/channel";

    @Override
    public void configureFlutterEngine(@NonNull FlutterEngine flutterEngine) {
        System.out.println("successfully called java code");
        super.configureFlutterEngine(flutterEngine);
        new MethodChannel(flutterEngine.getDartExecutor().getBinaryMessenger(), CHANNEL)
            .setMethodCallHandler(
                (call, result) -> {
                    if (call.method.equals("myJavaMethod")) {
                        myJavaMethod();
                        result.success(null);
                    } else {
                        result.notImplemented();
                    }
                }
            );
    }

    private void myJavaMethod() {
        System.out.println("Worked");
    }
}