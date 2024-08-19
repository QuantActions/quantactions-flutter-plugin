import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../core/sdk_method_channel.dart';
import '../providers/questionnaire_provider.dart';
import '../providers/questionnaire_provider_impl.dart';
import '../repositories/questionnaire_repository_impl.dart';

final QuestionnaireDI questionnaireDI = QuestionnaireDI();

class QuestionnaireDI {
  void initDependencies() {
    appLocator.registerSingleton<QuestionnaireProvider>(
      QuestionnaireProviderImpl(
        sdkMethodChannel: appLocator.get<SDKMethodChannel>(),
      ),
    );

    appLocator.registerSingleton<QuestionnaireRepository>(
      QuestionnaireRepositoryImpl(
        questionnaireProvider: appLocator.get<QuestionnaireProvider>(),
      ),
    );
  }
}
