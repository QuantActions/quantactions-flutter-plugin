import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/device_provider.dart';
import '../providers/device_provider_impl.dart';
import '../repositories/device_repository_impl.dart';

/// Device Dependency Injection instance.
final DeviceDI deviceDI = DeviceDI();

/// Device Dependency Injection class.
class DeviceDI {
  /// Initialize dependencies.
  void initDependencies() {
    appLocator.registerSingleton<DeviceProvider>(
      DeviceProviderImpl(
        sdkMethodChannel: appLocator.get<SDKMethodChannel>(),
      ),
    );

    appLocator.registerSingleton<DeviceRepository>(
      DeviceRepositoryImpl(
        deviceProvider: appLocator.get<DeviceProvider>(),
      ),
    );
  }
}
