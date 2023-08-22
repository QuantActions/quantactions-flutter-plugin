import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import '../../domain/domain.dart';
import 'sdk_method_channel_impl.dart';

abstract class SDKMethodChannel extends PlatformInterface {
  /// Constructs a TestPluginPlatform.
  SDKMethodChannel() : super(token: _token);

  static final Object _token = Object();

  static SDKMethodChannel _instance = SDKMethodChannelImpl();

  /// The default instance of [SDKMethodChannel] to use.
  ///
  /// Defaults to [SDKMethodChannelImpl].
  static SDKMethodChannel get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SDKMethodChannel] when
  /// they register themselves.
  static set instance(SDKMethodChannel instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Stream<dynamic> getTrendStream(Trend trend) {
    throw UnimplementedError('getTrendStream() has not been implemented.');
  }

  Stream<dynamic> getMetricStream(Metric metric) {
    throw UnimplementedError('getMetricStream() has not been implemented.');
  }

  Future<bool?> canDraw() {
    throw UnimplementedError('canDraw() has not been implemented.');
  }

  Future<bool?> canUsage() {
    throw UnimplementedError('canUsage() has not been implemented.');
  }

  Future<bool?> isDataCollectionRunning() {
    throw UnimplementedError(
      'isDataCollectionRunning() has not been implemented.',
    );
  }

  Future<bool?> isInit() {
    throw UnimplementedError('isInit() has not been implemented.');
  }

  Future<bool?> isDeviceRegistered() {
    throw UnimplementedError('isDeviceRegistered() has not been implemented.');
  }

  Future<bool?> initAsync({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    throw UnimplementedError('init() has not been implemented.');
  }

  Stream<dynamic> init({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    throw UnimplementedError('init() has not been implemented.');
  }
}
