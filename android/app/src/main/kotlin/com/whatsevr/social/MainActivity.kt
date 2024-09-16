package com.whatsevr.social

import io.flutter.embedding.android.FlutterActivity
import com.otpless.otplessflutter.OtplessFlutterPlugin;
import android.content.Intent;


class MainActivity: FlutterActivity(){
//    Start-OTPless
    override fun onNewIntent(intent: Intent) {
        super.onNewIntent(intent)
        val plugin = flutterEngine?.plugins?.get(OtplessFlutterPlugin::class.java)
        if (plugin is OtplessFlutterPlugin) {
            plugin.onNewIntent(intent)
        }
//    End-OTPless
    }

    override fun onBackPressed() {

        //    Start-OTPless
        val plugin = flutterEngine?.plugins?.get(OtplessFlutterPlugin::class.java)
        if (plugin is OtplessFlutterPlugin) {
            if (plugin.onBackPressed()) return
        }
        // handle other cases
        super.onBackPressed()
    }
    //    End-OTPless

}