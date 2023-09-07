import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/device_provider.dart';
import '../providers/device_provider_impl.dart';
import '../repositories/device_repository_impl.dart';

final DeviceDI deviceDI = DeviceDI();

class DeviceDI {
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
