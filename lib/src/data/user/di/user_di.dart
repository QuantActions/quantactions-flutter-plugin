import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/user_provider.dart';
import '../providers/user_provider_impl.dart';
import '../repositories/user_repository_impl.dart';

/// User Dependency Injection instance
final UserDI userDI = UserDI();

/// User Dependency Injection
class UserDI {
  /// Initialize dependencies
  void initDependencies() {
    appLocator.registerSingleton<UserProvider>(
      UserProviderImpl(
        sdkMethodChannel: appLocator.get<SDKMethodChannel>(),
      ),
    );

    appLocator.registerSingleton<UserRepository>(
      UserRepositoryImpl(
        userProvider: appLocator.get<UserProvider>(),
      ),
    );
  }
}
