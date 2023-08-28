package com.quantactions.qa_flutter_plugin

import android.app.Activity
import android.content.Context
import android.util.Log

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodChannel
import io.flutter.embedding.engine.plugins.activity.ActivityAware

import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers

/** TestPlugin */
class QAFlutterPlugin : FlutterPlugin, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var eventChannels: List<EventChannel>
    private lateinit var mainEventChannel: EventChannel
    private lateinit var deviceEventChannel: EventChannel

    private lateinit var context: Context
    private lateinit var activity: Activity

    // The scope for the UI thread
    private val mainScope = CoroutineScope(Dispatchers.Main)
    private val ioScope = CoroutineScope(Dispatchers.IO)

    private lateinit var qa: QA

    override fun onDetachedFromActivity() {
        print("Activity detached, but service should continue!")
    }

    override fun onReattachedToActivityForConfigChanges(binding: ActivityPluginBinding) {
        print("Activity reattached")
    }

    override fun onAttachedToActivity(binding: ActivityPluginBinding) {
        activity = binding.activity
    }

    override fun onDetachedFromActivityForConfigChanges() {
        print("Activity detached, for config changes but service should continue!")
    }

    override fun onAttachedToEngine(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        qa = QA.getInstance(flutterPluginBinding.applicationContext)
        context = flutterPluginBinding.applicationContext
        initChannels(flutterPluginBinding)
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    private fun initChannels(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("QAFlutterPlugin", "initChannels")
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin")
        channel.setMethodCallHandler(
            MethodChannelHandler(mainScope, qa, context)
        )

        eventChannels = QAFlutterPluginHelper.listOfMetricsAndTrends.map {
            Log.d("QAFlutterPlugin", "Creating event channel for ${it.id}")
            EventChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/${it.id}")
        }

        eventChannels.forEach {
            it.setStreamHandler(
                MetricAndTrendStreamHandler(mainScope, ioScope, qa, context)
            )
        }

        Log.d("QAFlutterPlugin", "Creating event channel}")
        deviceEventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/device"
        )

        deviceEventChannel.setStreamHandler(
            DeviceStreamHandler(mainScope, qa, context)
        )

        Log.d("QAFlutterPlugin", "Creating event channel}")
        mainEventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/main"
        )

        mainEventChannel.setStreamHandler(
            MainStreamHandler(mainScope, qa, context)
        )
    }
}
