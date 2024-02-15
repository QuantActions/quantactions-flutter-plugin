import 'package:json_annotation/json_annotation.dart';

part 'keyboard_settings.g.dart';

@JsonSerializable()
class KeyboardSettings {
  final bool caseSensitive;
  final bool smartPunctuation;
  final bool autoCorrect;
  final bool autoCapitalization;
  final bool autoLearn;
  final bool doubleSpaceTapAddsPunctuation;
  final bool swipeTyping;
  final bool swipeLeftToDelete;
  final bool autoCorrectAfterPunctuation;
  final bool spacebarMovesCursor;
  final bool hapticFeedback;
  final bool soundFeedback;

  KeyboardSettings({
    required this.caseSensitive,
    required this.smartPunctuation,
    required this.autoCorrect,
    required this.autoCapitalization,
    required this.autoLearn,
    required this.doubleSpaceTapAddsPunctuation,
    required this.swipeTyping,
    required this.swipeLeftToDelete,
    required this.autoCorrectAfterPunctuation,
    required this.spacebarMovesCursor,
    required this.hapticFeedback,
    required this.soundFeedback,
  });

  factory KeyboardSettings.fromJson(Map<String, dynamic> json) => _$KeyboardSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$KeyboardSettingsToJson(this);
}
