package com.quantactions.qa_flutter_plugin

import android.app.Activity
import android.util.Log
import android.content.Context
import com.quantactions.qa_flutter_plugin.event_channel_handlers.GetCohortListStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.GetJournalEntriesStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.GetQuestionnairesListStreamHandler
import com.quantactions.qa_flutter_plugin.event_channel_handlers.MetricAndTrendStreamHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.DataCollectionRunningMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.VoidMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.device.DeviceIdMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.device.GetConnectedDevicesMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.device.IsDeviceRegisteredMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.device.LastTapsMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.device.OpenBatteryOptimisationSettingsChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.device.SubscribeMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.device.SubscriptionMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.journal.GetJournalEntriesSampleMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.journal.GetJournalEntryMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.journal.GetJournalEventEntityMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.journal.SaveJournalEntryMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.permission.CanActivityMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.permission.CanDrawMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.permission.CanUsageMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.permission.RequestOverlayPermissionMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.permission.RequestUsagePermissionMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.user.BasicInfoMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.user.IdentityIdMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.user.InitMethodChannelHandler
import com.quantactions.qa_flutter_plugin.method_channel_handlers.user.PasswodMethodChannelHandler
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.FlutterJNI
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.embedding.engine.plugins.activity.ActivityAware
import io.flutter.embedding.engine.plugins.activity.ActivityPluginBinding
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.Job

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

    private lateinit var journalChannel: GetJournalEntriesStreamHandler
    private lateinit var metricChannels: List<MetricAndTrendStreamHandler>

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
        Log.d("QAFlutterPlugin", "Destroying event channels")
        journalChannel.destroy()
        metricChannels.forEach { it.destroy() }
        Log.d("QAFlutterPlugin", "Detached from engine")
    }

    private fun getActivity(): Activity {
        return activity;
    }

    private fun initChannels(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        VoidMethodChannelHandler(ioScope, qa, context).register(flutterPluginBinding)
        InitMethodChannelHandler(mainScope, qa, context).register(flutterPluginBinding)
        BasicInfoMethodChannelHandler(mainScope, qa).register(flutterPluginBinding)
        PasswodMethodChannelHandler(mainScope, qa).register(flutterPluginBinding)
        IdentityIdMethodChannelHandler(mainScope, qa).register(flutterPluginBinding)
        DataCollectionRunningMethodChannelHandler(mainScope, qa, context).register(flutterPluginBinding)
        IsDeviceRegisteredMethodChannelHandler(mainScope, qa).register(flutterPluginBinding)
        DeviceIdMethodChannelHandler(mainScope, qa).register(flutterPluginBinding)
        LastTapsMethodChannelHandler(ioScope, qa).register(flutterPluginBinding)
        SaveJournalEntryMethodChannelHandler(ioScope, qa).register(flutterPluginBinding)
        GetJournalEntryMethodChannelHandler(ioScope, qa).register(flutterPluginBinding)
        CanDrawMethodChannelHandler(mainScope, qa, context).register(flutterPluginBinding)
        CanActivityMethodChannelHandler(mainScope, qa, context).register(flutterPluginBinding)
        RequestOverlayPermissionMethodChannelHandler(mainScope, qa, context, this::getActivity).register(flutterPluginBinding);
        CanUsageMethodChannelHandler(mainScope, qa, context).register(flutterPluginBinding)
        RequestUsagePermissionMethodChannelHandler(mainScope, qa, context, this::getActivity).register(flutterPluginBinding);
        SubscribeMethodChannelHandler(ioScope, qa).register(flutterPluginBinding)
        SubscriptionMethodChannelHandler(ioScope, qa).register(flutterPluginBinding)
        metricChannels = MetricAndTrendStreamHandler(mainScope, ioScope, qa, context).register(flutterPluginBinding)
        GetCohortListStreamHandler(mainScope, qa).register(flutterPluginBinding)
        GetCohortListStreamHandler(mainScope, qa).register(flutterPluginBinding)
        GetJournalEventEntityMethodChannelHandler(ioScope, qa).register(flutterPluginBinding)
        journalChannel = GetJournalEntriesStreamHandler(ioScope, mainScope, qa).register(flutterPluginBinding)
        GetQuestionnairesListStreamHandler(mainScope, qa).register(flutterPluginBinding)
        GetJournalEntriesSampleMethodChannelHandler(ioScope, qa, context).register(flutterPluginBinding)
        GetConnectedDevicesMethodChannelHandler(mainScope, qa).register(flutterPluginBinding);
        OpenBatteryOptimisationSettingsChannelHandler(mainScope, qa, context).register(flutterPluginBinding);
    }
}
