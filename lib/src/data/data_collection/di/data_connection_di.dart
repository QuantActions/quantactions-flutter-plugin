import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/data_collection_provider.dart';
import '../providers/data_collection_provider_impl.dart';
import '../repositories/data_collection_repository_impl.dart';

final DataCollectionDI dataCollectionDI = DataCollectionDI();

class DataCollectionDI {
  void initDependencies() {
    appLocator.registerSingleton<DataCollectionProvider>(
      DataCollectionProviderImpl(
        sdkMethodChannel: appLocator.get<SDKMethodChannel>(),
      ),
    );

    appLocator.registerSingleton<DataCollectionRepository>(
      DataCollectionRepositoryImpl(
        dataCollectionProvider: appLocator.get<DataCollectionProvider>(),
      ),
    );
  }
}
