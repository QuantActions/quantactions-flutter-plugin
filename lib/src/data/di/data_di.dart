import 'package:qa_flutter_plugin/src/core/core.dart';

import '../core/sdk_method_channel.dart';
import '../data_collection/di/data_connection_di.dart';
import '../metric/di/metric_di.dart';
import '../permission/di/permission_di.dart';
import '../qa/di/qa_di.dart';
import '../trend/di/trend_di.dart';

final DataDI dataDI = DataDI();

class DataDI {
  void initDependencies() {
    appLocator.registerSingleton<SDKMethodChannel>(
      SDKMethodChannel(),
    );

    dataCollectionDI.initDependencies();
    metricDI.initDependencies();
    permissionDI.initDependencies();
    qanDI.initDependencies();
    trendDI.initDependencies();
  }
}
