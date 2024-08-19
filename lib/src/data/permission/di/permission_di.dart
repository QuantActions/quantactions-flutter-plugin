import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/permission_provider.dart';
import '../providers/permission_provider_impl.dart';
import '../repositories/permission_repository_impl.dart';

/// Permission Dependency Injection instance
final PermissionDI permissionDI = PermissionDI();

/// Permission Dependency Injection
class PermissionDI {
  /// Initialize dependencies
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
