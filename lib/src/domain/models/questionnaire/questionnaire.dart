import 'package:json_annotation/json_annotation.dart';

part 'questionnaire.g.dart';

@JsonSerializable()
class Questionnaire {
  final String id;
  final String questionnaireName;
  final String questionnaireDescription;
  final String questionnaireCode;
  final String questionnaireCohort;
  final String questionnaireBody;

  Questionnaire({
    required this.id,
    required this.questionnaireName,
    required this.questionnaireDescription,
    required this.questionnaireCode,
    required this.questionnaireCohort,
    required this.questionnaireBody,
  });

  factory Questionnaire.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireFromJson(json);

  Map<String, dynamic> toJson() => _$QuestionnaireToJson(this);
}
