package com.quantactions.qa_flutter_plugin.method_channel_handlers

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginMetricMapper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import com.quantactions.sdk.data.model.JournalEntryWithEvents
import com.quantactions.sdk.data.model.ResolvedJournalEvent
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class MethodChannelHandler(
    private var mainScope: CoroutineScope,
    private var ioScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        ioScope.launch {
            when (call.method) {
                "getJournalEntry" -> {
                    val params = call.arguments as Map<*, *>

                    val journalEntryId = params["journalEntryId"] as String

                    val response = qa.getJournalEntry(journalEntryId)

                    result.success(
                        if (response == null) null
                        else QAFlutterPluginSerializable.serializeJournalEntry(response)
                    )
                }

                else -> mainScope.launch {
                    when (call.method) {
                        "getPlatformVersion" -> {
                            result.success("Android ${android.os.Build.VERSION.RELEASE}")
                        }

                        "someOtherMethod" -> {
                            result.success("Success!")
                        }

                        "initAsync" -> {
                            val params = call.arguments as Map<*, *>

                            val apiKey = params["apiKey"] as String
                            val age = params["age"] as Int
                            val selfDeclaredHealthy = params["selfDeclaredHealthy"] as Boolean
                            val gender = QAFlutterPluginHelper.parseGender(
                                params["gender"] as String
                            )

                            result.success(
                                qa.initAsync(
                                    context,
                                    apiKey,
                                    age,
                                    gender,
                                    selfDeclaredHealthy,
                                )
                            )
                        }

                        "updateBasicInfo" -> {
                            val params = call.arguments as Map<*, *>

                            val newYearOfBirth = params["newYearOfBirth"] as Int
                            val newSelfDeclaredHealthy = params["age"] as Boolean
                            val newGender = QAFlutterPluginHelper.parseGender(
                                params["newGender"] as String
                            )

                            qa.updateBasicInfo(
                                newYearOfBirth,
                                newGender,
                                newSelfDeclaredHealthy,
                            )
                        }

                        "canDraw" -> result.success(qa.canDraw(context))

                        "canUsage" -> result.success(qa.canUsage(context))

                        "requestOverlayPermission" -> result.success(
                            qa.requestOverlayPermission(context)
                        )

                        "requestUsagePermission" -> result.success(
                            qa.requestUsagePermission(context)
                        )

                        "isDataCollectionRunning" -> result.success(
                            qa.isDataCollectionRunning(context)
                        )

                        "pauseDataCollection" -> qa.pauseDataCollection(context)

                        "resumeDataCollection" -> qa.resumeDataCollection(context)

                        "isInit" -> result.success(qa.isInit())

                        "isDeviceRegistered" -> result.success(qa.isDeviceRegistered(context))

                        "savePublicKey" -> qa.savePublicKey(context)

                        "setVerboseLevel" -> {
                            val params = call.arguments as Map<*, *>

                            val verbose = params["verbose"] as Int

                            qa.setVerboseLevel(context, verbose)
                        }

                        "getSubscriptionIdAsync" -> result.success(
                            QAFlutterPluginSerializable.serializeQAResponseString(
                                qa.getSubscriptionIdAsync()
                            )
                        )

                        "getMetricAsync" -> {
                            val params = call.arguments as Map<*, *>

                            val metric = params["metric"] as String
                            val metricToAsk = QAFlutterPluginMetricMapper.getMetric(metric);

                            val response = qa.getMetricAsync(metricToAsk)
                            result.success(
                                QAFlutterPluginMetricMapper.mapMetricResponse(metric, response)
                            )
                        }

                        "getStatSampleAsync" -> {
                            val params = call.arguments as Map<*, *>

                            val metric = params["metric"] as String
                            val apiKey = params["apiKey"] as String

                            val metricToAsk = QAFlutterPluginMetricMapper.getMetric(metric);

                            val response = qa.getStatSampleAsync(context, apiKey, metricToAsk)
                            result.success(
                                QAFlutterPluginMetricMapper.mapMetricResponse(metric, response)
                            )
                        }

                        "getBasicInfo" -> {
                            val basicInfo = qa.basicInfo

                            result.success(
                                QAFlutterPluginSerializable.serializeBasicInfo(basicInfo)
                            )
                        }

                        "getDeviceID" -> {
                            result.success(qa.deviceID)
                        }

                        "retrieveBatteryOptimizationIntentForCurrentManufacturer" -> {
                            result.success(
                                qa.retrieveBatteryOptimizationIntentForCurrentManufacturer(context).action
                            )
                        }

                        "syncData" -> {
                            result.success(qa.syncData().toString())
                        }

                        else -> result.notImplemented()
                    }
                }
            }
        }
    }
}