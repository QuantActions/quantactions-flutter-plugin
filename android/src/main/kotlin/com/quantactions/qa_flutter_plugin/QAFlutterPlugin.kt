package com.quantactions.qa_flutter_plugin

import android.app.Activity
import android.content.Context
import android.util.Log
import androidx.annotation.NonNull
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
import com.quantactions.sdk.data.entity.TimestampedEntity
import com.quantactions.sdk.data.model.SerializableSleepSummary
import com.squareup.moshi.JsonClass
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.flow.Flow
import kotlinx.coroutines.launch
import kotlinx.serialization.Serializable
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

    private val listOfMetricsAndTrends = listOf(
        Metric.COGNITIVE_FITNESS,
        Metric.ACTION_SPEED,
        Metric.TYPING_SPEED,
        Metric.SOCIAL_ENGAGEMENT,
        Metric.SLEEP_SUMMARY,
        Metric.SLEEP_SCORE,
        Metric.SCREEN_TIME_AGGREGATE,
        Metric.SOCIAL_TAPS,
        Trend.COGNITIVE_FITNESS,
        Trend.ACTION_SPEED,
        Trend.SOCIAL_ENGAGEMENT,
        Trend.SLEEP_SCORE,
        Trend.SLEEP_LENGTH,
        Trend.SLEEP_INTERRUPTIONS,
        Trend.SOCIAL_SCREEN_TIME,
        Trend.SOCIAL_TAPS,
        Trend.TYPING_SPEED,
    )

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

        eventChannels = listOfMetricsAndTrends.map {
            Log.d("QAFlutterPlugin", "Creating event channel for ${it.id}")
            EventChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/${it.id}")
        }

        eventChannels.forEach {
            it.setStreamHandler(this)
        }

        qa = QA.getInstance(flutterPluginBinding.applicationContext)

        context = flutterPluginBinding.applicationContext
    }

    // The scope for the UI thread
    private val mainScope = CoroutineScope(Dispatchers.Main)
    private val ioScope = CoroutineScope(Dispatchers.IO)

    override fun onMethodCall(call: MethodCall, result: Result) {
        mainScope.launch {
            when (call.method) {
                "getPlatformVersion" -> {
                    result.success("Android ${android.os.Build.VERSION.RELEASE}")
                }

                "initQA" -> qa.init(
                    context,
                    "55b9cf50-dac2-11e6-b535-fd8dff3bf4e9",
                    age = 1991,
                    gender = QA.Gender.MALE,
                    true
                )

                "someOtherMethod" -> {
                    result.success("Success!")
                }

                else -> result.notImplemented()
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

        return QA.getInstance(context)
            .getMetricSample(context, "55b9cf50-dac2-11e6-b535-fd8dff3bf4e9", metricToAsk)
    }


    override fun onDetachedFromEngine(@NonNull binding: FlutterPlugin.FlutterPluginBinding) {
        channel.setMethodCallHandler(null)
    }

    @JsonClass(generateAdapter = true)
    @Serializable
    data class SerializableTimeSeries<T>(
        val timestamps: List<String>,
        val values: List<T>,
        val confidenceIntervalLow: List<T>,
        val confidenceIntervalHigh: List<T>,
        val confidence: List<Double>,
    )

    override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
        ioScope.launch {
            getMetric(arguments.toString()).collect {

                // her I have to map the return types
                mainScope.launch {

                    when (arguments.toString()) {
                        "sleep", "cognitive", "social", "action", "typing", "social_taps" -> {
                            val it2 = it as TimeSeries.DoubleTimeSeries
                            events?.success(
                                Json.encodeToString(
                                    SerializableTimeSeries(
                                        it2.timestamps.map { v -> v.toString() },
                                        it2.values.map { v -> if (v.isNaN()) null else v },
                                        it2.confidenceIntervalLow.map { v -> if (v.isNaN()) null else v },
                                        it2.confidenceIntervalHigh.map { v -> if (v.isNaN()) null else v },
                                        it2.confidence.map { v -> if (v.isNaN()) 0.0 else v }
                                    )
                                )
                            )
                        }

                        "sleep_summary" -> {
                            val it2 = it as TimeSeries.SleepSummaryTimeTimeSeries
                            events?.success(
                                Json.encodeToString(
                                    SerializableTimeSeries(
                                        it2.timestamps.map { v -> v.toString() },
                                        it2.values.map { v -> v.serialize() },
                                        it2.confidenceIntervalLow.map { v -> v.serialize() },
                                        it2.confidenceIntervalHigh.map { v -> v.serialize() },
                                        it2.confidence.map { v -> if (v.isNaN()) 0.0 else v }
                                    )
                                )
                            )

                        }

                        "screen_time_aggregate" -> {
                            val it2 = it as TimeSeries.ScreenTimeAggregateTimeSeries
                            events?.success(
                                Json.encodeToString(
                                    SerializableTimeSeries(
                                        it2.timestamps.map { v -> v.toString() },
                                        it2.values,
                                        it2.confidenceIntervalLow,
                                        it2.confidenceIntervalHigh,
                                        it2.confidence.map { v -> if (v.isNaN()) 0.0 else v }
                                    )
                                )
                            )
                        }

                        else -> {
                            val it2 = it as TimeSeries.TrendTimeSeries

                            events?.success(
                                Json.encodeToString(
                                    SerializableTimeSeries(
                                        it2.timestamps.map { v -> v.toString() },
                                        it2.values,
                                        it2.confidenceIntervalLow,
                                        it2.confidenceIntervalHigh,
                                        it2.confidence.map { v -> if (v.isNaN()) 0.0 else v }
                                    )
                                )
                            )


                        }

                    }
                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        // nothing
    }

}
