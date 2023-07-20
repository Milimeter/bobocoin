package com.example.binance_cl

import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {
    init {
        System.loadLibrary("TrustWalletCore")
    }
}
