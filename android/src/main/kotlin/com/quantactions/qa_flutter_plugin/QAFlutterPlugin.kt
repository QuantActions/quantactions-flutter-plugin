package com.quantactions.qa_flutter_plugin

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
import com.quantactions.sdk.Metric
import androidx.lifecycle.coroutineScope
import androidx.lifecycle.Lifecycle

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware

import com.quantactions.sdk.QA
import com.quantactions.sdk.TimeSeries
import com.quantactions.sdk.data.api.SkipSerialization
import com.quantactions.sdk.data.api.responses.DataFrameSchema
import com.squareup.moshi.JsonClass
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.flow.collect
import kotlinx.coroutines.flow.map
import kotlinx.coroutines.flow.transform
import kotlinx.coroutines.launch
import kotlinx.coroutines.withContext
import kotlinx.serialization.Serializable
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json
import org.json.JSONObject
import java.time.ZonedDateTime
import java.time.format.DateTimeFormatter
import kotlin.coroutines.coroutineContext

/** TestPlugin */
class QAFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware, EventChannel.StreamHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var eventChannel: EventChannel

    private lateinit var context: Context
    private lateinit var activity: Activity

    lateinit var qa: QA

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

    override fun onAttachedToEngine(@NonNull flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("MyPlugin", "onAttachedToEngine")
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin")
        channel.setMethodCallHandler(this)

        eventChannel = EventChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream")
        eventChannel.setStreamHandler(this)

        qa = QA.getInstance(flutterPluginBinding.applicationContext)

        context = flutterPluginBinding.applicationContext
    }

    // The scope for the UI thread
    private val mainScope = CoroutineScope(Dispatchers.Main)
    private val ioScope = CoroutineScope(Dispatchers.IO)

    override fun onMethodCall(call: MethodCall, result: Result) {
        Log.e("MyPlugin!", call.method)
        val args = call.arguments

        mainScope.launch {
            Log.e("MyPlugin", "onMethodCall: I'm working in thread ${Thread.currentThread().name}")
            when (call.method) {
                "getPlatformVersion" -> {
                    result.success("Android ${android.os.Build.VERSION.RELEASE}")
                    Log.e("MyPlugin!", "called platform!")
                }

                "initQA" -> qa.init(
                    context,
                    "55b9cf50-dac2-11e6-b535-fd8dff3bf4e9",
                    age = 1991,
                    gender = QA.Gender.MALE,
                    true
                )

                "someOtherMethod" -> {
                    Log.e("MyPlugin!", "These are the args: $args")
                    result.success("Success!")
                }

                else -> result.notImplemented()
            }
        }
    }

    fun getMetric(metric: String): Flow<TimeSeries<Double>> {

        val metricToAsk = when(metric) {
            "sleepScore" -> Metric.SLEEP_SCORE
            "cognitiveFitness" -> Metric.COGNITIVE_FITNESS
            "socialEngagementScore" -> Metric.SOCIAL_ENGAGEMENT
            else -> Metric.SLEEP_SCORE
        }

        Log.e("MyPlugin!", "Calling a flow")
       return QA.getInstance(context)
            .getMetricSample(context, "55b9cf50-dac2-11e6-b535-fd8dff3bf4e9", metricToAsk)
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    @JsonClass(generateAdapter = true)
    @Serializable
    data class StatisticCore (
        val timestamps: List<String>,
        val data: List<Double>,
    )

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        ioScope.launch {
            getMetric(arguments.toString()).collect {
                mainScope.launch { events?.success(
                    Json.encodeToString(
                        StatisticCore(it.timestamps.map{ it.toString() }, it.values))) }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        // nothing
    }

}
