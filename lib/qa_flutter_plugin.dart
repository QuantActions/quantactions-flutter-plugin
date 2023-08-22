import 'package:qa_flutter_plugin/src/core/core.dart';
import 'package:qa_flutter_plugin/src/data/data.dart';
import 'package:qa_flutter_plugin/src/domain/domain.dart';

export 'package:qa_flutter_plugin/src/domain/models/models.dart';

class QAFlutterPlugin {
  late TrendRepository _trendRepository;
  late MetricRepository _metricRepository;
  late PermissionRepository _permissionRepository;
  late SDKRepository _sdkRepository;
  late DataCollectionRepository _dataCollectionRepository;

  QAFlutterPlugin() {
    dataDI.initDependencies();

    _trendRepository = appLocator.get<TrendRepository>();
    _metricRepository = appLocator.get<MetricRepository>();
    _permissionRepository = appLocator.get<PermissionRepository>();
    _sdkRepository = appLocator.get<SDKRepository>();
    _dataCollectionRepository = appLocator.get<DataCollectionRepository>();
  }

  Stream<TimeSeries<dynamic>> getTrend(Trend trend) {
    return _trendRepository.getByTrend(trend);
  }

  Stream<TimeSeries<dynamic>> getMetric(Metric metric) {
    return _metricRepository.getByMetric(metric);
  }

  Future<bool?> canDraw() {
    return _permissionRepository.canDraw();
  }

  Future<bool?> canUsage() {
    return _permissionRepository.canUsage();
  }

  Future<bool?> isDataCollectionRunning() {
    return _dataCollectionRepository.isDataCollectionRunning();
  }

  void pauseDataCollection() {
    return _dataCollectionRepository.pauseDataCollection();
  }

  void resumeDataCollection() {
    return _dataCollectionRepository.resumeDataCollection();
  }

  Future<bool?> isInit() {
    return _sdkRepository.isInit();
  }

  Future<bool?> isDeviceRegistered() {
    return _sdkRepository.isDeviceRegistered();
  }

  Future<bool?> initAsync({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _sdkRepository.initAsync(
      age: age,
      gender: gender,
      selfDeclaredHealthy: selfDeclaredHealthy,
    );
  }

  Stream<QAResponse<String>> init({
    int? age,
    Gender? gender,
    bool? selfDeclaredHealthy,
  }) {
    return _sdkRepository.init(
      age: age,
      gender: gender,
      selfDeclaredHealthy: selfDeclaredHealthy,
    );
  }

  void savePublicKey() {
    return _sdkRepository.savePublicKey();
  }
}
