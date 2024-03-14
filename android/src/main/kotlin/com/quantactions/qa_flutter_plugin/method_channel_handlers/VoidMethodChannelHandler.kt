package com.quantactions.qa_flutter_plugin.method_channel_handlers

import android.content.Context
import android.util.Log
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.async
import kotlinx.coroutines.launch
import kotlinx.serialization.decodeFromString
import kotlinx.serialization.json.Json

class VoidMethodChannelHandler(
    private var ioScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        ioScope.launch {
            when (call.method) {
                "getPlatformVersion" -> {
                    result.success("Android ${android.os.Build.VERSION.RELEASE}")
                }

                "someOtherMethod" -> {
                    result.success("Success!")
                }

                "pauseDataCollection" -> QAFlutterPluginHelper.safeMethodChannel(
                    result = result,
                    methodName = "pauseDataCollection",
                    method = {
                        qa.pauseDataCollection(context)
                        result.success(true)
                    }
                )

                "resumeDataCollection" ->
                    QAFlutterPluginHelper.safeMethodChannel(
                        result = result,
                        methodName = "resumeDataCollection",
                        method = {
                            qa.resumeDataCollection(context)
                            result.success(true)
                        }
                    )

                "deleteJournalEntry" -> {
                    val params = call.arguments as Map<*, *>

                    val id = params["id"] as String?

                    if (id != null) {
                        QAFlutterPluginHelper.safeMethodChannel(
                            result = result,
                            methodName = "deleteJournalEntry",
                            method = {
                                qa.deleteJournalEntry(id)
                                result.success(true)
                            }
                        )
                    } else {
                        QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(
                            result = result,
                            methodName = "deleteJournalEntry"
                        )
                    }
                }

                "sendNote" -> {
                    val params = call.arguments as Map<*, *>

                    val text = params["text"] as String?

                    if (text != null) {
                        QAFlutterPluginHelper.safeMethodChannel(
                            result = result,
                            methodName = "sendNote",
                            method = {
                                    qa.sendNote(text)
                                    result.success(true)
                            }
                        )
                    } else {
                        QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(
                            result = result,
                            methodName = "sendNote"
                        )
                    }
                }

                "leaveCohort" -> {
                    val params = call.arguments as Map<*, *>

                    val cohortId = params["cohortId"] as? String
                    val subscriptionId = params["subscriptionId"] as? String
                    Log.d("SUBSUB", "$subscriptionId : $cohortId")

                    if (cohortId != null && subscriptionId != null) {
                        QAFlutterPluginHelper.safeMethodChannel(
                            result = result,
                            methodName = "leaveCohort",
                            method = {
                                    qa.leaveCohort(subscriptionId, cohortId)
                                    result.success(true)
                            }
                        )
                    } else {
                        QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(
                            result = result,
                            methodName = "leaveCohort"
                        )
                    }
                }

                "recordQuestionnaireResponse" -> {
                    val params = call.arguments as Map<*, *>

                    val name = params["name"] as String?
                    val code = params["code"] as String?
                    val fullID = params["fullId"] as String?
                    val response = params["response"] as String?
                    val responseMap =
                        if (response == null) null else Json.decodeFromString<Map<String, Any>>(
                            response
                        )
                    val date: Long? = (params["date"] as String?)?.toLong()

                    if (name != null && code != null && fullID != null && responseMap != null && date != null) {
                        QAFlutterPluginHelper.safeMethodChannel(
                            result = result,
                            methodName = "recordQuestionnaireResponse",
                            method = {
                                async {
                                    qa.recordQuestionnaireResponse(
                                        name,
                                        code,
                                        date,
                                        fullID,
                                        responseMap
                                    )
                                }.await()
                            },
                        )
                    } else {
                        QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(
                            result = result, methodName = "recordQuestionnaireResponse"
                        )
                    }
                }

                else -> result.notImplemented()
            }
        }
    }
}