import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/permission_provider.dart';
import '../providers/permission_provider_impl.dart';
import '../repositories/permission_repository_impl.dart';

final PermissionDI permissionDI = PermissionDI();

class PermissionDI {
  void initDependencies() {
    appLocator.registerSingleton<PermissionProvider>(
      PermissionProviderImpl(
        sdkMethodChannel: appLocator.get<SDKMethodChannel>(),
      ),
    );

    appLocator.registerSingleton<PermissionRepository>(
      PermissionRepositoryImpl(
        permissionProvider: appLocator.get<PermissionProvider>(),
      ),
    );
  }
}
