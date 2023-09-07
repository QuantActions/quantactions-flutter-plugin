import 'dart:convert';

import '../../../../qa_flutter_plugin.dart';
import 'questionnaire_mapper.dart';

class QuestionnaireStreamMapper {
  static Stream<List<Questionnaire>> getList(Stream<dynamic> stream) {
    return stream.map(
      (dynamic event) => QuestionnaireMapper.fromList(jsonDecode(event)),
    );
  }
}
