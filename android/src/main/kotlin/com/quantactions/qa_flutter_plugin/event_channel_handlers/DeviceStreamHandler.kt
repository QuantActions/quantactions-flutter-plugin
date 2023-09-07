package com.quantactions.qa_flutter_plugin.event_channel_handlers

import android.content.Context
import com.quantactions.qa_flutter_plugin.QAFlutterPluginSerializable
import com.quantactions.sdk.QA
import io.flutter.plugin.common.EventChannel
import kotlinx.coroutines.CoroutineScope
import kotlinx.coroutines.launch

class DeviceStreamHandler(
    private var mainScope: CoroutineScope,
    private var qa: QA,
    private var context: Context
) : EventChannel.StreamHandler {
    private var eventSink: EventChannel.EventSink? = null

    override fun onListen(arguments: Any?, eventSink: EventChannel.EventSink) {
        this.eventSink = eventSink

        mainScope.launch {
            val params = arguments as? Map<*, *>

            when (params?.get("method") as? String) {
                "redeemVoucher" -> {
                    val voucher = params["voucher"] as? String ?: ""

                    qa.redeemVoucher(voucher).collect {
                        eventSink.success(
                            QAFlutterPluginSerializable.serializeQAResponseString(it)
                        )
                    }
                }

                "subscribe" -> {
                    val subscriptionIdOrCohortId =
                        params["subscriptionIdOrCohortId"] as? String ?: ""

                    qa.subscribe(subscriptionIdOrCohortId).collect {
                        eventSink.success(
                            QAFlutterPluginSerializable.serializeQAResponseString(it)
                        )
                    }
                }

                "subscribeWithGooglePurchaseToken" -> {
                    val purchaseToken = params["purchaseToken"] as? String ?: ""

                    qa.subscribeWithGooglePurchaseToken(purchaseToken).collect {
                        eventSink.success(
                            QAFlutterPluginSerializable.serializeQAResponseString(it)
                        )
                    }
                }

                "getSubscriptionId" -> {
                    qa.getSubscriptionId().collect {
                        eventSink.success(
                            QAFlutterPluginSerializable.serializeQAResponseString(it)
                        )
                    }
                }
            }
        }
    }

    override fun onCancel(arguments: Any?) {
        eventSink = null
    }
}