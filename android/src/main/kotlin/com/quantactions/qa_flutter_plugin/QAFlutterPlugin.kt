package com.quantactions.qa_flutter_plugin

import android.app.Activity
import android.content.Context
import com.quantactions.qa_flutter_plugin.method_channel_handlers.permission.CanDrawMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.permission.CanUsageMethodChannelHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.GetCohortListStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.GetJournalEntriesStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.GetQuestionnairesListStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.MetricAndTrendStreamHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.user.BasicInfoMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.DataCollectionRunningMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.device.DeviceIdMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.journal.GetJournalEntryMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.user.InitMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.device.IsDeviceRegisteredMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.journal.SaveJournalEntryMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.device.SubscribeMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.VoidMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.device.SubscriptionMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.journal.GetJournalEntriesSampleMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.journal.GetJournalEventEntityMethodChannelHandler

import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware

import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers

/** TestPlugin */
class QAFlutterPlugin : FlutterPlugin, ActivityAware {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
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

    override fun onDetachedFromEngine(binding: FlutterPlugin.FlutterPluginBinding) {}

    private fun initChannels(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        VoidMethodChannelHandler(ioScope, qa, context).register(flutterPluginBinding)
        InitMethodChannelHandler(mainScope, qa, context).register(flutterPluginBinding)
        BasicInfoMethodChannelHandler(mainScope, qa).register(flutterPluginBinding)
        DataCollectionRunningMethodChannelHandler(mainScope, qa, context).register(flutterPluginBinding)
        IsDeviceRegisteredMethodChannelHandler(mainScope, qa).register(flutterPluginBinding)
        DeviceIdMethodChannelHandler(mainScope, qa).register(flutterPluginBinding)
        SaveJournalEntryMethodChannelHandler(ioScope, qa).register(flutterPluginBinding)
        GetJournalEntryMethodChannelHandler(ioScope, qa).register(flutterPluginBinding)
        CanDrawMethodChannelHandler(mainScope, qa, context).register(flutterPluginBinding)
        CanUsageMethodChannelHandler(mainScope, qa, context).register(flutterPluginBinding)
        SubscribeMethodChannelHandler(mainScope, qa).register(flutterPluginBinding)
        SubscriptionMethodChannelHandler(mainScope, qa).register(flutterPluginBinding)
        MetricAndTrendStreamHandler(mainScope, ioScope, qa, context).register(flutterPluginBinding)
        GetCohortListStreamHandler(mainScope, qa).register(flutterPluginBinding)
        GetCohortListStreamHandler(mainScope, qa).register(flutterPluginBinding)
        GetJournalEventEntityMethodChannelHandler(ioScope, qa).register(flutterPluginBinding)
        GetJournalEntriesStreamHandler(mainScope, qa, context).register(flutterPluginBinding)
        GetQuestionnairesListStreamHandler(mainScope, qa).register(flutterPluginBinding)
        GetJournalEntriesSampleMethodChannelHandler(ioScope, qa, context).register(flutterPluginBinding)
    }
}
