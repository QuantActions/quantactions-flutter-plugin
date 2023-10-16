package com.quantactions.qa_flutter_plugin

import android.app.Activity
import android.content.Context
import android.util.Log
import com.quantactions.qa_flutter_plugin.event_channel_handlers.questionnaire.GetQuestionnairesListStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.cohort.GetCohortListStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.device.DeviceStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.device.GetSubscriptionIdStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.journal.JournalStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.MetricAndTrendStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.questionnaire.RecordQuestionnaireResponseStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.UserStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.cohort.LeaveCohortStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.journal.GetJournalEventsStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.journal.GetJournalStreamHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.MethodChannelHandler

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
    private lateinit var metricEventChannels: List<EventChannel>
    private lateinit var getCohortListEventChannel: EventChannel
    private lateinit var leaveCohortEventChannel: EventChannel
    private lateinit var userEventChannel: EventChannel
    private lateinit var deviceEventChannel: EventChannel
    private lateinit var getSubscriptionIdEventChannelEventChannel: EventChannel
    private lateinit var journalEventChannel: EventChannel
    private lateinit var getJournalEventsEventChannel: EventChannel
    private lateinit var getJournalEventChannel: EventChannel
    private lateinit var getQuestionnairesListEventChannel: EventChannel
    private lateinit var recordQuestionnaireResponseEventChannel: EventChannel

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

        Log.d("QAFlutterPlugin", "Creating method channel")
        channel = MethodChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin")
        channel.setMethodCallHandler(
            MethodChannelHandler(mainScope, ioScope, qa, context)
        )

        metricEventChannels = QAFlutterPluginHelper.listOfMetricsAndTrends.map {
            Log.d("QAFlutterPlugin", "Creating event channel for ${it.id}")
            EventChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/${it.id}")
        }

        metricEventChannels.forEach {
            it.setStreamHandler(
                MetricAndTrendStreamHandler(mainScope, ioScope, qa, context)
            )
        }

        Log.d("QAFlutterPlugin", "Creating event channel for device}")
        deviceEventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/device"
        )

        deviceEventChannel.setStreamHandler(
            DeviceStreamHandler(mainScope, qa)
        )

        Log.d("QAFlutterPlugin", "Creating event channel for get_subscription_id}")
        getSubscriptionIdEventChannelEventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/get_subscription_id"
        )

        getSubscriptionIdEventChannelEventChannel.setStreamHandler(
            GetSubscriptionIdStreamHandler(mainScope, qa)
        )

        Log.d("QAFlutterPlugin", "Creating event channel for user}")
        userEventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/user"
        )

        userEventChannel.setStreamHandler(
            UserStreamHandler(mainScope, qa, context)
        )

        Log.d("QAFlutterPlugin", "Creating event channel for get_cohort_list}")
        getCohortListEventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/get_cohort_list"
        )

        getCohortListEventChannel.setStreamHandler(
            GetCohortListStreamHandler(mainScope, qa)
        )

        Log.d("QAFlutterPlugin", "Creating event channel for leave_cohort}")
        leaveCohortEventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/leave_cohort"
        )

        leaveCohortEventChannel.setStreamHandler(
            LeaveCohortStreamHandler(mainScope, qa)
        )

        Log.d("QAFlutterPlugin", "Creating event channel for get_journal_events}")
        getJournalEventsEventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/get_journal_events"
        )

        getJournalEventsEventChannel.setStreamHandler(
            GetJournalEventsStreamHandler(mainScope, qa)
        )

        Log.d("QAFlutterPlugin", "Creating event channel for get_journal}")
        getJournalEventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/get_journal"
        )

        getJournalEventChannel.setStreamHandler(
            GetJournalStreamHandler(mainScope, qa, context)
        )

        Log.d("QAFlutterPlugin", "Creating event channel for journal}")
        journalEventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/journal"
        )

        journalEventChannel.setStreamHandler(
            JournalStreamHandler(mainScope, qa, context)
        )

        Log.d("QAFlutterPlugin", "Creating event channel for get_questionnaires_list}")
        getQuestionnairesListEventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger, "qa_flutter_plugin_stream/get_questionnaires_list"
        )

        getQuestionnairesListEventChannel.setStreamHandler(
            GetQuestionnairesListStreamHandler(mainScope, qa)
        )

        Log.d("QAFlutterPlugin", "Creating event channel for record_questionnaire_response}")
        recordQuestionnaireResponseEventChannel = EventChannel(
            flutterPluginBinding.binaryMessenger,
            "qa_flutter_plugin_stream/record_questionnaire_response"
        )

        recordQuestionnaireResponseEventChannel.setStreamHandler(
            RecordQuestionnaireResponseStreamHandler(mainScope, qa)
        )
    }
}
