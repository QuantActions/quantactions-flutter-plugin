import 'dart:convert';

import '../../../domain/domain.dart';
import '../../mappers/qa_response/qa_response_mapper.dart';
import '../../mappers/qa_response/qa_response_stream_mapper.dart';
import '../providers/device_provider.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final DeviceProvider _deviceProvider;

  DeviceRepositoryImpl({
    required DeviceProvider deviceProvider,
  }) : _deviceProvider = deviceProvider;

  @override
  Future<bool> isDeviceRegistered() {
    return _deviceProvider.isDeviceRegistered();
  }

  @override
  Stream<QAResponse<String>> redeemVoucher({
    required String voucher,
  }) {
    final stream = _deviceProvider.redeemVoucher(voucher: voucher);

    return QAResponseStreamMapper.getString(stream);
  }

  @override
  Stream<QAResponse<String>> subscribeWithGooglePurchaseToken({
    required String purchaseToken,
  }) {
    final stream = _deviceProvider.subscribeWithGooglePurchaseToken(
      purchaseToken: purchaseToken,
    );

    return QAResponseStreamMapper.getString(stream);
  }

  @override
  Stream<QAResponse<String>> subscribe({
    required String subscriptionIdOrCohortId,
  }) {
    final stream = _deviceProvider.subscribe(
      subscriptionIdOrCohortId: subscriptionIdOrCohortId,
    );

    return QAResponseStreamMapper.getString(stream);
  }

  @override
  Stream<QAResponse<SubscriptionIdResponse>> getSubscriptionId() {
    final stream = _deviceProvider.getSubscriptionId();

    return QAResponseStreamMapper.getSubscriptionIdResponse(stream);
  }

  @override
  Future<QAResponse<SubscriptionIdResponse>> getSubscriptionIdAsync() async {
    final String? json = await _deviceProvider.getSubscriptionIdAsync();

    if (json == null) {
      throw Exception(
          'QAFlutterPlugin.getSubscriptionIdAsync() returned no data');
    }

    return QAResponseMapper.fromJsonSubscriptionIdResponse(
      jsonDecode(json),
    );
  }

  @override
  Future<String> syncData() {
    return _deviceProvider.syncData();
  }

  @override
  Future<String> getDeviceID() {
    return _deviceProvider.getDeviceID();
  }

  @override
  Future<String?> getFirebaseToken() {
    return _deviceProvider.getFirebaseToken();
  }

  @override
  Future<bool> getIsTablet() {
    return _deviceProvider.getIsTablet();
  }
}
