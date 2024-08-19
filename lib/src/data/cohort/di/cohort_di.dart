import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/cohort_provider.dart';
import '../providers/cohort_provider_impl.dart';
import '../repositories/cohort_repository_impl.dart';

/// Cohort Dependency Injection instance
final CohortDI cohortDI = CohortDI();

/// Cohort Dependency Injection
class CohortDI {
  /// Initialize dependencies
  void initDependencies() {
    appLocator.registerSingleton<CohortProvider>(
      CohortProviderImpl(
        sdkMethodChannel: appLocator.get<SDKMethodChannel>(),
      ),
    );

    appLocator.registerSingleton<CohortRepository>(
      CohortRepositoryImpl(
        cohortProvider: appLocator.get<CohortProvider>(),
      ),
    );
  }
}
