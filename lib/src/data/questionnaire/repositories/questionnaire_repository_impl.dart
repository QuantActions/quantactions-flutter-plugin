import '../../../domain/domain.dart';
import '../../mappers/qa_response/qa_response_stream_mapper.dart';
import '../../mappers/questionnaire/questionnaire_stream_mapper.dart';
import '../providers/questionnaire_provider.dart';

class QuestionnaireRepositoryImpl implements QuestionnaireRepository {
  final QuestionnaireProvider _questionnaireProvider;

  QuestionnaireRepositoryImpl({
    required QuestionnaireProvider questionnaireProvider,
  }) : _questionnaireProvider = questionnaireProvider;

  @override
  Stream<List<Questionnaire>> getQuestionnairesList() {
    final Stream<dynamic> stream = _questionnaireProvider.getQuestionnairesList();

    return QuestionnaireStreamMapper.getList(stream);
  }

  @override
  Stream<QAResponse<String>> recordQuestionnaireResponse({
    required String? name,
    required String? code,
    required DateTime? date,
    required String? fullId,
    required String? response,
  }) {
    final Stream<dynamic> stream = _questionnaireProvider.recordQuestionnaireResponse(
      name: name,
      code: code,
      date: date,
      fullId: fullId,
      response: response,
    );

    return QAResponseStreamMapper.getString(stream);
  }
}
