import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/metric_provider.dart';
import '../providers/metric_provider_impl.dart';
import '../repositories/metric_repository_impl.dart';

/// Metric Dependency Injection instance
final MetricDI metricDI = MetricDI();

/// Metric Dependency Injection
class MetricDI {
  /// Initialize dependencies
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
