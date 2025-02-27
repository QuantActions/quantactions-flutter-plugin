import 'package:json_annotation/json_annotation.dart';

part 'questionnaire.g.dart';

/// Model for Questionnaire.
@JsonSerializable()
class Questionnaire {
  /// Unique identifier for the questionnaire.
  final String id;

  /// Name of the questionnaire.
  final String questionnaireName;

  /// Description of the questionnaire.
  final String questionnaireDescription;

  /// Code of the questionnaire.
  final String questionnaireCode;

  /// Cohort of the questionnaire.
  final String questionnaireCohort;

  /// Body of the questionnaire.
  final String questionnaireBody;

  /// Constructor for [Questionnaire].
  Questionnaire({
    required this.id,
    required this.questionnaireName,
    required this.questionnaireDescription,
    required this.questionnaireCode,
    required this.questionnaireCohort,
    required this.questionnaireBody,
  });

  /// Create a [Questionnaire] from a JSON object.
  factory Questionnaire.fromJson(Map<String, dynamic> json) =>
      _$QuestionnaireFromJson(json);

  /// Create a JSON object from a [Questionnaire].
  Map<String, dynamic> toJson() => _$QuestionnaireToJson(this);
}
