package com.adedom.pos_tong_fa

import android.os.Bundle
import com.pavolibrary.commands.DeviceAPI
import com.pavolibrary.commands.LedAPI
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity : FlutterActivity() {

    private lateinit var mLed8: LedAPI

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        initData()
    }

    private fun initData() {
        mLed8 = LedAPI(this)
    }

    public override fun onDestroy() {
        super.onDestroy()
        mLed8.disconnect()
    }

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, LED_CHANNEL_NAME)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    LED_CONNECT_METHOD_NAME -> {
                        mLed8.disconnect()
                        val ledResult = mLed8.connect(SERIAL_PORT, SERIAL_BAUD_RATE, SERIAL_FLAG)
                        if (DeviceAPI.SUCCESS == ledResult) {
                            mLed8.LED_SetBaudRate(BAUD_RATE_CONSTANT)
                            result.success(ledResult)
                        } else {
                            result.error("", "", "")
                        }
                    }

                    LED_DISCONNECT_METHOD_NAME -> {
                        if (mLed8.isConnect) {
                            val ledResult = mLed8.disconnect()
                            result.success(ledResult)
                        } else {
                            result.error("", "", "")
                        }
                    }

                    LED_CLEAR_SCREEN_METHOD_NAME -> {
                        if (mLed8.isConnect) {
                            val ledResult = mLed8.LED_ClearScreen()
                            result.success(ledResult)
                        } else {
                            result.error("", "", "")
                        }
                    }

                    LED_DISPLAY_METHOD_NAME -> {
                        val data = call.arguments as? Double
                        if (mLed8.isConnect && data != null) {
                            val ledResult = mLed8.LED_Display(data.toString(), ASCII)
                            result.success(ledResult)
                        } else {
                            result.error("", "", "")
                        }
                    }

                    else -> {
                        result.notImplemented()
                    }
                }
            }
    }

    companion object {
        private const val LED_CHANNEL_NAME = "pos_tong_fa.adedom.com/led"
        private const val LED_CONNECT_METHOD_NAME = "ledConnect"
        private const val LED_DISCONNECT_METHOD_NAME = "ledDisconnect"
        private const val LED_CLEAR_SCREEN_METHOD_NAME = "ledClearScreen"
        private const val LED_DISPLAY_METHOD_NAME = "ledDisplay"
        private const val ASCII = "ASCII"
        private const val SERIAL_PORT = "/dev/ttyS9"
        private const val SERIAL_BAUD_RATE = 2400 // baud rate connect
        private const val BAUD_RATE_CONSTANT = 2 // serial baud rate
        private const val SERIAL_FLAG = 0
    }
}
