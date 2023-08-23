import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/metric_provider.dart';
import '../providers/metric_provider_impl.dart';
import '../repositories/metric_repository_impl.dart';

final MetricDI metricDI = MetricDI();

class MetricDI {
  void initDependencies() {
    appLocator.registerSingleton<MetricProvider>(
      MetricProviderImpl(
        sdkMethodChannel: appLocator.get<SDKMethodChannel>(),
      ),
    );

    appLocator.registerSingleton<MetricRepository>(
      MetricRepositoryImpl(
        metricProvider: appLocator.get<MetricProvider>(),
      ),
    );
  }
}
