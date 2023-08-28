package com.quantactions.qa_flutter_plugin

import android.content.Context
import com.quantactions.sdk.QA
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class MethodChannelHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : MethodChannel.MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: MethodChannel.Result) {
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

                "savePublicKey" -> qa.savePublicKey(context)

                "setVerboseLevel" -> {
                    val verbose = call.argument<Int>("verbose") ?: 0

                    qa.setVerboseLevel(context, verbose)
                }

                else -> result.notImplemented()
            }
        }
    }
}