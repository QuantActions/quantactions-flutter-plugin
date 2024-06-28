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
    required this.hapticFeedback,
    required this.soundFeedback,
  });

  // add some default values
  factory KeyboardSettings.defaults() => KeyboardSettings(
    caseSensitive: true,
    smartPunctuation: false,
    autoCorrect: true,
    autoCapitalization: true,
    autoLearn: true,
    doubleSpaceTapAddsPunctuation: true,
    swipeTyping: true,
    swipeLeftToDelete: false,
    autoCorrectAfterPunctuation: true,
    hapticFeedback: false,
    soundFeedback: false,
  );

  // copy with
  KeyboardSettings copyWith({
    bool? caseSensitive,
    bool? smartPunctuation,
    bool? autoCorrect,
    bool? autoCapitalization,
    bool? autoLearn,
    bool? doubleSpaceTapAddsPunctuation,
    bool? swipeTyping,
    bool? swipeLeftToDelete,
    bool? autoCorrectAfterPunctuation,
    bool? hapticFeedback,
    bool? soundFeedback,
  }) {
    return KeyboardSettings(
      caseSensitive: caseSensitive ?? this.caseSensitive,
      smartPunctuation: smartPunctuation ?? this.smartPunctuation,
      autoCorrect: autoCorrect ?? this.autoCorrect,
      autoCapitalization: autoCapitalization ?? this.autoCapitalization,
      autoLearn: autoLearn ?? this.autoLearn,
      doubleSpaceTapAddsPunctuation: doubleSpaceTapAddsPunctuation ?? this.doubleSpaceTapAddsPunctuation,
      swipeTyping: swipeTyping ?? this.swipeTyping,
      swipeLeftToDelete: swipeLeftToDelete ?? this.swipeLeftToDelete,
      autoCorrectAfterPunctuation: autoCorrectAfterPunctuation ?? this.autoCorrectAfterPunctuation,
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
      soundFeedback: soundFeedback ?? this.soundFeedback,
    );
  }

  factory KeyboardSettings.fromJson(Map<String, dynamic> json) => _$KeyboardSettingsFromJson(json);

  Map<String, dynamic> toJson() => _$KeyboardSettingsToJson(this);
}
