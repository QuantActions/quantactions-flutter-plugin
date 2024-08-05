import '../../../domain/domain.dart';
import '../../mappers/questionnaire/questionnaire_mapper.dart';
import '../providers/questionnaire_provider.dart';

class QuestionnaireRepositoryImpl implements QuestionnaireRepository {
  final QuestionnaireProvider _questionnaireProvider;

  QuestionnaireRepositoryImpl({
    required QuestionnaireProvider questionnaireProvider,
  }) : _questionnaireProvider = questionnaireProvider;

  @override
  Stream<List<Questionnaire>> getQuestionnairesList() {
    final Stream<dynamic> stream =
        _questionnaireProvider.getQuestionnairesList();

    return QuestionnaireMapper.fromStream(stream);
  }

  @override
  Future<void> recordQuestionnaireResponse({
    required String? name,
    required String? code,
    required DateTime? date,
    required String? fullId,
    required String? response,
  }) async {
    await _questionnaireProvider.recordQuestionnaireResponse(
      name: name,
      code: code,
      date: date,
      fullId: fullId,
      response: response,
    );
  }
}
