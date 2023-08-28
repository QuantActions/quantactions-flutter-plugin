import 'package:qa_flutter_plugin/src/core/core.dart';

import '../cohort/di/cohort_di.dart';
import '../core/sdk_method_channel.dart';
import '../data_collection/di/data_connection_di.dart';
import '../device/di/device_di.dart';
import '../journal/di/journal_di.dart';
import '../metric/di/metric_di.dart';
import '../permission/di/permission_di.dart';
import '../questionnaire/di/questionnaire_di.dart';
import '../user/di/user_di.dart';

final DataDI dataDI = DataDI();

class DataDI {
  void initDependencies() {
    appLocator.registerSingleton<SDKMethodChannel>(
      SDKMethodChannel(),
    );

    dataCollectionDI.initDependencies();
    metricDI.initDependencies();
    permissionDI.initDependencies();
    userDI.initDependencies();
    deviceDI.initDependencies();
    cohortDI.initDependencies();
    journalDI.initDependencies();
    questionnaireDI.initDependencies();
  }
}
