import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/qa_provider.dart';
import '../providers/qa_provider_impl.dart';
import '../repositories/qa_repository_impl.dart';

final QaDI qanDI = QaDI();

class QaDI {
  void initDependencies() {
    appLocator.registerSingleton<QAProvider>(
      QAProviderImpl(
        sdkMethodChannel: appLocator.get<SDKMethodChannel>(),
      ),
    );

    appLocator.registerSingleton<QARepository>(
      QARepositoryImpl(
        qaProvider: appLocator.get<QAProvider>(),
      ),
    );
  }
}
