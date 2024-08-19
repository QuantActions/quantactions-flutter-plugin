import 'dart:convert';

import '../../../domain/domain.dart';

class QuestionnaireMapper {
  static Stream<List<Questionnaire>> fromStream(Stream<dynamic> stream) {
    return stream.map(
      (dynamic event) => QuestionnaireMapper.fromList(jsonDecode(event)),
    );
  }

  static List<Questionnaire> fromList(List<dynamic> list) {
    return list
        .map((dynamic json) =>
            Questionnaire.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
