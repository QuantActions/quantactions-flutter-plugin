import 'package:json_annotation/json_annotation.dart';

part 'keyboard_settings.g.dart';

/// [iOS only] Keyboard settings
@JsonSerializable()
class KeyboardSettings {
  /// Whether the keyboard is case sensitive (always true by default)
  final bool caseSensitive;

  /// Space after punctuation: Automatic insertion of a space after a punctuation mark.
  final bool smartPunctuation;

  /// Auto-Correction: Corrects words while typing.
  final bool autoCorrect;

  /// Auto-Capitalization: Automatic capital letter after a punctuation mark or at the start of an input field.
  final bool autoCapitalization;

  /// Auto-Learn: Words are learnt automatically as you type.
  final bool autoLearn;

  /// "." Shortcut: Double-tapping the space bar inserts a full stop followed by a space.
  final bool doubleSpaceTapAddsPunctuation;

  /// Slide to Type: Type by swiping across the keyboard.
  final bool swipeTyping;

  /// Swipe left to delete: Swipe left to delete an entire word. When 'Slide to Type' is enabled, this setting is disabled.
  final bool swipeLeftToDelete;

  /// Auto-Correction on Punctuation: Automatically corrects words when punctuation is added at the end.
  final bool autoCorrectAfterPunctuation;

  /// Haptic feedback: Haptic feedback when pressing a keyboard key.
  final bool hapticFeedback;

  /// Sound: Sound effect when pressing a keyboard key.
  final bool soundFeedback;

  /// Custom Background: Use a custom background for the keyboard [WIP for now].
  final bool shouldUseCustomBackground;

  /// Constructor
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
    required this.shouldUseCustomBackground,
  });

  /// Defaults
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
        shouldUseCustomBackground: true,
      );

  /// CopyWith method
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
    bool? shouldUseCustomBackground,
  }) {
    return KeyboardSettings(
      caseSensitive: caseSensitive ?? this.caseSensitive,
      smartPunctuation: smartPunctuation ?? this.smartPunctuation,
      autoCorrect: autoCorrect ?? this.autoCorrect,
      autoCapitalization: autoCapitalization ?? this.autoCapitalization,
      autoLearn: autoLearn ?? this.autoLearn,
      doubleSpaceTapAddsPunctuation:
          doubleSpaceTapAddsPunctuation ?? this.doubleSpaceTapAddsPunctuation,
      swipeTyping: swipeTyping ?? this.swipeTyping,
      swipeLeftToDelete: swipeLeftToDelete ?? this.swipeLeftToDelete,
      autoCorrectAfterPunctuation:
          autoCorrectAfterPunctuation ?? this.autoCorrectAfterPunctuation,
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
      soundFeedback: soundFeedback ?? this.soundFeedback,
      shouldUseCustomBackground:
          shouldUseCustomBackground ?? this.shouldUseCustomBackground,
    );
  }

  /// FromJson method
  factory KeyboardSettings.fromJson(Map<String, dynamic> json) =>
      _$KeyboardSettingsFromJson(json);

  /// ToJson method
  Map<String, dynamic> toJson() => _$KeyboardSettingsToJson(this);
}
