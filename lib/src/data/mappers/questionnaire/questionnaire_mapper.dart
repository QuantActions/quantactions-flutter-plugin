import 'dart:convert';

import '../../../domain/domain.dart';


class QuestionnaireMapper {
  static Stream<List<Questionnaire>> fromStream(Stream<dynamic> stream) {
    return stream.map(
      (event) => QuestionnaireMapper.fromList(jsonDecode(event)),
    );
  }

  static List<Questionnaire> fromList(List<dynamic> list) {
    return list.map((json) => Questionnaire.fromJson(json)).toList();
  }
}
