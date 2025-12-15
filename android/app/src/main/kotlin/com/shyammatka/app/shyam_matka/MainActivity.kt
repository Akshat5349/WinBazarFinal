package com.loki.royal_app

import android.app.Activity
import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val UPI_PAYMENT_CHANNEL = "upi_payment_channel"
    private val UPI_PAYMENT_REQUEST_CODE = 1001
    
    private var upiPaymentResult: MethodChannel.Result? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // UPI Payment channel
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, UPI_PAYMENT_CHANNEL).setMethodCallHandler { call, result ->
            when (call.method) {
                "startUpiPayment" -> {
                    val upiUrl = call.argument<String>("upiUrl")
                    if (upiUrl != null) {
                        try {
                            upiPaymentResult = result
                            val intent = Intent(Intent.ACTION_VIEW)
                            intent.data = Uri.parse(upiUrl)
                            startActivityForResult(intent, UPI_PAYMENT_REQUEST_CODE)
                        } catch (e: Exception) {
                            result.error("ERROR", "Could not launch UPI app", e.message)
                        }
                    } else {
                        result.error("ERROR", "UPI URL is null", null)
                    }
                }
                else -> result.notImplemented()
            }
        }
    }
    
    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)
        
        if (requestCode == UPI_PAYMENT_REQUEST_CODE) {
            if (upiPaymentResult != null) {
                if (data != null) {
                    // Get the response from UPI app
                    val response = data.getStringExtra("response")
                    
                    if (response != null) {
                        // Parse the response to extract transaction details
                        upiPaymentResult?.success(response)
                    } else {
                        // Try to get the complete data URI
                        val dataUri = data.data?.toString()
                        if (dataUri != null) {
                            upiPaymentResult?.success(dataUri)
                        } else {
                            // Check if payment was cancelled
                            if (resultCode == Activity.RESULT_CANCELED) {
                                upiPaymentResult?.success(null)
                            } else {
                                // Try to extract all extras as a fallback
                                val extras = data.extras
                                val responseBuilder = StringBuilder()
                                
                                if (extras != null) {
                                    for (key in extras.keySet()) {
                                        val value = extras.get(key)
                                        if (responseBuilder.isNotEmpty()) {
                                            responseBuilder.append("&")
                                        }
                                        responseBuilder.append("$key=$value")
                                    }
                                }
                                
                                if (responseBuilder.isNotEmpty()) {
                                    upiPaymentResult?.success(responseBuilder.toString())
                                } else {
                                    upiPaymentResult?.success("Status=UNKNOWN&resultCode=$resultCode")
                                }
                            }
                        }
                    }
                } else {
                    if (resultCode == Activity.RESULT_CANCELED) {
                        upiPaymentResult?.success(null)
                    } else {
                        upiPaymentResult?.success("Status=UNKNOWN&resultCode=$resultCode")
                    }
                }
                
                upiPaymentResult = null
            }
        }
    }
}
