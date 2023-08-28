import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/journal_provider.dart';
import '../providers/journal_provider_impl.dart';
import '../repositories/journal_repository_impl.dart';

final JournalDI journalDI = JournalDI();

class JournalDI {
  void initDependencies() {
    appLocator.registerSingleton<JournalProvider>(
      JournalProviderImpl(
        sdkMethodChannel: appLocator.get<SDKMethodChannel>(),
      ),
    );

    appLocator.registerSingleton<JournalRepository>(
      JournalRepositoryImpl(
        journalProvider: appLocator.get<JournalProvider>(),
      ),
    );
  }
}
