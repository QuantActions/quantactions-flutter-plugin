package com.quantactions.qa_flutter_plugin.method_channel_handlers.user

import com.quantactions.qa_flutter_plugin.QAFlutterPluginHelper
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.embedding.engine.plugins.FlutterPlugin
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class BasicInfoMethodChannelHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
) : MethodChannel.MethodCallHandler {

    fun register(flutterPluginBinding: FlutterPlugin.FlutterPluginBinding) {
        val channel =
            MethodChannel(flutterPluginBinding.binaryMessenger, "qa_flutter_plugin/basic_info")
        channel.setMethodCallHandler(this)
    }

    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
        mainScope.launch {
            when (call.method) {
                "updateBasicInfo" -> {
                    val params = call.arguments as Map<*, *>

                    val newYearOfBirth =
                        params["newYearOfBirth"] as Int? ?: qa.basicInfo.yearOfBirth
                    val newSelfDeclaredHealthy =
                        params["age"] as Boolean? ?: qa.basicInfo.selfDeclaredHealthy

                    val newGenderString = params["newGender"] as String?
                    val newGender: QA.Gender = if (newGenderString == null) qa.basicInfo.gender
                    else QAFlutterPluginHelper.parseGender(newGenderString)

                    QAFlutterPluginHelper.safeMethodChannel(
                        result = result, methodName = "updateBasicInfo", method = {
                            qa.update(
                                newYearOfBirth,
                                newGender,
                                newSelfDeclaredHealthy,
                            )

                            result.success(true);
                        }
                    )
                }

                "getBasicInfo" -> {
                    QAFlutterPluginHelper.safeMethodChannel(
                        result = result,
                        methodName = "getBasicInfo",
                        method = {
                            val basicInfo = qa.basicInfo
                            result.success(
                                QAFlutterPluginSerializable.serializeBasicInfo(basicInfo)
                            )
                        }
                    )
                }
            }
        }
    }
}