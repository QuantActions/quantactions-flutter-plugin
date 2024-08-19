import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/journal_provider.dart';
import '../providers/journal_provider_impl.dart';
import '../repositories/journal_repository_impl.dart';

/// Journal Dependency Injection instance.
final JournalDI journalDI = JournalDI();

/// Journal Dependency Injection class.
class JournalDI {
  /// Initialize dependencies.
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
