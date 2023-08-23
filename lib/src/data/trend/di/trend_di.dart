import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/trend_provider.dart';
import '../providers/trend_provider_impl.dart';
import '../repositories/trend_repository_impl.dart';

final TrendDI trendDI = TrendDI();

class TrendDI {
  void initDependencies() {
    appLocator.registerSingleton<TrendProvider>(
      TrendProviderImpl(
        sdkMethodChannel: appLocator.get<SDKMethodChannel>(),
      ),
    );

    appLocator.registerSingleton<TrendRepository>(
      TrendRepositoryImpl(
        trendProvider: appLocator.get<TrendProvider>(),
      ),
    );
  }
}
