import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'sdk_method_channel.dart';

abstract class SDKMethodChannelCore extends PlatformInterface {
  /// Constructs a TestPluginPlatform.
  SDKMethodChannelCore() : super(token: _token);

  static final Object _token = Object();

  static SDKMethodChannelCore _instance = SDKMethodChannel();

  /// The default instance of [SDKMethodChannelCore] to use.
  ///
  /// Defaults to [SDKMethodChannelCore].
  static SDKMethodChannelCore get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SDKMethodChannelCore] when
  /// they register themselves.
  static set instance(SDKMethodChannelCore instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }
}
