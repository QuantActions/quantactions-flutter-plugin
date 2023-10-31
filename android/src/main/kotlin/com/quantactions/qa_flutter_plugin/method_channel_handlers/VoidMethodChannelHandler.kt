package com.quantactions.qa_flutter_plugin.method_channel_handlers

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking

class VoidMethodChannelHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        mainScope.launch {
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
                    method = { qa.pauseDataCollection(context) }
                )

                "resumeDataCollection" ->
                    QAFlutterPluginHelper.safeMethodChannel(
                        result = result,
                        methodName = "resumeDataCollection",
                        method = {
                            qa.resumeDataCollection(context)
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
                                runBlocking {
                                    launch {
                                        qa.deleteJournalEntry(id)
                                    }
                                }
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
                                runBlocking {
                                    launch {
                                        qa.sendNote(text)
                                    }
                                }
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

                    if (cohortId != null) {
                        QAFlutterPluginHelper.safeMethodChannel(
                            result = result,
                            methodName = "leaveCohort",
                            method = {
                                runBlocking {
                                    launch {
                                        qa.leaveCohort(cohortId)
                                    }
                                }
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
                    val date: Long? = (params["date"] as String?)?.toLong()

                    if (name != null && code != null && fullID != null && response != null && date != null) {
                        QAFlutterPluginHelper.safeMethodChannel(
                            result = result,
                            methodName = "recordQuestionnaireResponse",
                            method = {
                                runBlocking {
                                    launch {
                                        qa.recordQuestionnaireResponse(
                                            name, code, date, fullID, response
                                        )
                                    }
                                }
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