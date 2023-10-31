package com.quantactions.qa_flutter_plugin.method_channel_handlers.user

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.sdk.BasicInfo
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch
import kotlinx.coroutines.runBlocking

class InitMethodChannelHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel = MethodChannel(
            flutterPluginBinding.binaryMessenger,
            "qa_flutter_plugin/init"
        )
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        mainScope.launch {
            when (call.method) {
                "init" -> {
                    val params = call.arguments as Map<*, *>

                    val apiKey = params["apiKey"] as String?
                    val age = params["age"] as? Int? ?: 0
                    val selfDeclaredHealthy = params["age"] as? Boolean? ?: false
                    val gender = QAFlutterPluginHelper.parseGender(params["gender"] as? String)


                    if (apiKey != null) {
                        val basicInfo = BasicInfo(
                            age,
                            gender,
                            selfDeclaredHealthy,
                        )

                        QAFlutterPluginHelper.safeMethodChannel(
                            result = result,
                            methodName = "init",
                            method = {
                                result.success(
                                    runBlocking {
                                        launch {
                                            qa.init(context, apiKey, basicInfo)
                                        }
                                    }
                                )
                            }
                        )
                    } else {
                        QAFlutterPluginHelper.returnInvalidParamsMethodChannelError(
                            result = result,
                            methodName = "init"
                        )
                    }
                }
            }
        }
    }
}