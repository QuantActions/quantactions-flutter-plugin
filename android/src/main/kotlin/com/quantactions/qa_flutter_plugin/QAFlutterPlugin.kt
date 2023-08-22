package com.quantactions.qa_flutter_plugin

import android.app.Activity
import android.content.Context
import android.util.Log
import com.quantactions.sdk.Metric

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.embedding.engine.plugins.activity.ActivityAware

import com.quantactions.sdk.QA
import com.quantactions.sdk.TimeSeries
import com.quantactions.sdk.Trend
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.launch
import kotlinx.serialization.encodeToString
import kotlinx.serialization.json.Json

/** TestPlugin */
class QAFlutterPlugin : FlutterPlugin, MethodCallHandler, ActivityAware,
    EventChannel.StreamHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private lateinit var channel: MethodChannel
    private lateinit var eventChannels: List<EventChannel>
    private lateinit var eventChannel: EventChannel

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
        initChannels(flutterPluginBinding)
        qa = QA.getInstance(flutterPluginBinding.applicationContext)
        context = flutterPluginBinding.applicationContext
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        mainScope.launch {
            when (call.method) {
                "getPlatformVersion" -> {
                    result.success("Android ${android.os.Build.VERSION.RELEASE}")
                }

                "someOtherMethod" -> {
                    result.success("Success!")
                }

                "initAsync" -> {
                    val age = call.argument<Int>("age") ?: 0
                    val selfDeclaredHealthy = call.argument<Boolean>("selfDeclaredHealthy") ?: false
                    val gender = QAFlutterPluginHelper.parseGender(call.argument<String>("gender"))

                    result.success(
                        qa.initAsync(
                            context,
                            QAFlutterPluginHelper.initApiKey,
                            age = age,
                            gender = gender,
                            selfDeclaredHealthy,
                        )
                    )
                }

                "canDraw" -> result.success(qa.canDraw(context))

                "canUsage" -> result.success(qa.canUsage(context))

                "isDataCollectionRunning" -> result.success(qa.isDataCollectionRunning(context))

                "pauseDataCollection" -> qa.pauseDataCollection(context)

                "resumeDataCollection" -> qa.resumeDataCollection(context)

                "isInit" -> result.success(qa.isInit())

                "isDeviceRegistered" -> result.success(qa.isDeviceRegistered(context))

                else -> result.notImplemented()
            }
        }
    }

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        ioScope.launch {
            val params = arguments as? Map<*, *>

            when (params?.get("event") as? String) {
                null -> onListenMetric(arguments as String, events)
                else -> onListenEvent(arguments, events)
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        // nothing
    }

    private fun initChannels(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        Log.d("MyPlugin", "onAttachedToEngine")
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin")
        channel.setMethodCallHandler(this)

        eventChannels = QAFlutterPluginHelper.listOfMetricsAndTrends.map {
            Log.d("QAFlutterPlugin", "Creating event channel for ${it.id}")
            EventChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/${it.id}")
        }

        eventChannels.forEach {
            it.setStreamHandler(this)
        }

        Log.d("QAFlutterPlugin", "Creating event channel}")
        eventChannel =
            EventChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream")

        eventChannel.setStreamHandler(this)
    }

    private suspend fun onListenMetric(event: String, events: EventChannel.EventSink?) {
        getMetric(event).collect {
            // her I have to map the return types
            mainScope.launch {
                when (event) {
                    "sleep", "cognitive", "social", "action", "typing", "social_taps" -> {
                        events?.success(
                            QAFlutterPluginSerializable.serializeDouble(
                                it as TimeSeries.DoubleTimeSeries
                            )
                        )
                    }

                    "sleep_summary" -> {
                        events?.success(
                            QAFlutterPluginSerializable.serializeSleepSummaryTime(
                                it as TimeSeries.SleepSummaryTimeTimeSeries
                            )
                        )
                    }

                    "screen_time_aggregate" -> {
                        events?.success(
                            QAFlutterPluginSerializable.serializeScreenTimeAggregate(
                                it as TimeSeries.ScreenTimeAggregateTimeSeries
                            )
                        )
                    }

                    else -> {
                        events?.success(
                            QAFlutterPluginSerializable.serializeTrend(
                                it as TimeSeries.TrendTimeSeries
                            )
                        )
                    }
                }
            }
        }
    }

    private suspend fun onListenEvent(arguments: Any?, events: EventChannel.EventSink?) {
        mainScope.launch {
            val params = arguments as? Map<*, *>

            when (params?.get("event") as? String) {
                "init" -> {
                    val age = params["age"] as? Int? ?: 0
                    val selfDeclaredHealthy = params["age"] as? Boolean? ?: false
                    val gender = QAFlutterPluginHelper.parseGender(params["gender"] as? String)

                    qa.init(
                        context,
                        QAFlutterPluginHelper.initApiKey,
                        age = age,
                        gender = gender,
                        selfDeclaredHealthy,
                    ).collect {
                        events?.success(
                            Json.encodeToString(
                                QAFlutterPluginSerializable.SerializableQAResponse(
                                    it.data.toString(),
                                    it.message.toString(),
                                )
                            )
                        )
                    }
                }
            }
        }
    }

    private fun getMetric(metric: String): Flow<TimeSeries<out Any>> {
        val metricToAsk = when (metric) {
            "sleep" -> Metric.SLEEP_SCORE
            "cognitive" -> Metric.COGNITIVE_FITNESS
            "social" -> Metric.SOCIAL_ENGAGEMENT
            "action" -> Metric.ACTION_SPEED
            "typing" -> Metric.TYPING_SPEED
            "sleep_summary" -> Metric.SLEEP_SUMMARY
            "screen_time_aggregate" -> Metric.SCREEN_TIME_AGGREGATE
            "social_taps" -> Metric.SOCIAL_TAPS;
            "sleep_trend" -> Trend.SLEEP_SCORE
            "cognitive_trend" -> Trend.COGNITIVE_FITNESS
            "social_engagement_trend" -> Trend.SOCIAL_ENGAGEMENT
            "action_trend" -> Trend.ACTION_SPEED
            "typing_trend" -> Trend.TYPING_SPEED
            "sleep_length_trend" -> Trend.SLEEP_LENGTH
            "sleep_interruptions_trend" -> Trend.SLEEP_INTERRUPTIONS
            "social_screen_time_trend" -> Trend.SOCIAL_SCREEN_TIME
            "social_taps_trend" -> Trend.SOCIAL_TAPS
            "the_wave_trend" -> Trend.THE_WAVE
            else -> Metric.SLEEP_SCORE

        }

        return qa.getMetricSample(context, QAFlutterPluginHelper.initApiKey, metricToAsk)
    }

}
