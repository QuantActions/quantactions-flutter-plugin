import 'dart:convert';

import '../../../domain/domain.dart';

/// Mapper for [Questionnaire] model.
class QuestionnaireMapper {
  /// Converts a [Stream] of dynamic to a [Stream] of [List] of [Questionnaire].
  static Stream<List<Questionnaire>> fromStream(Stream<dynamic> stream) {
    return stream.map(
      (dynamic event) => QuestionnaireMapper.fromList(jsonDecode(event)),
    );
  }

  /// Converts a [dynamic] to a [Questionnaire].
  static List<Questionnaire> fromList(List<dynamic> list) {
    return list
        .map((dynamic json) =>
            Questionnaire.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
