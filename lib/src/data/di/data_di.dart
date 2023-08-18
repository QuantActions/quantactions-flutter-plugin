import 'package:qa_flutter_plugin/src/core/core.dart';

import '../../domain/repositories/metric_repository.dart';
import '../../domain/repositories/trend_repository.dart';
import '../providers/sdk_method_channel.dart';
import '../providers/sdk_method_channel_impl.dart';
import '../repositories/metric_repository_impl.dart';
import '../repositories/trend_repository_impl.dart';

final DataDI dataDI = DataDI();

class DataDI {
  void initDependencies() {
    appLocator.registerSingleton<SDKMethodChannel>(
      SDKMethodChannelImpl(),
    );

    appLocator.registerSingleton<MetricRepository>(
      MetricRepositoryImpl(
        sdkMethodChannel: appLocator.get<SDKMethodChannel>(),
      ),
    );

    appLocator.registerSingleton<TrendRepository>(
      TrendRepositoryImpl(
        sdkMethodChannel: appLocator.get<SDKMethodChannel>(),
      ),
    );
  }
}
