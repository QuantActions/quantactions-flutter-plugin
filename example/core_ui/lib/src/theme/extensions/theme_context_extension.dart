part of core_ui;

extension ColorsContextExtension on ThemeData {
  AppColorsTheme get colors {
    return extension<AppColorsTheme>()!;
  }
}

extension TextContextExtension on ThemeData {
  TextTheme get text {
    return textTheme;
  }
}

extension ThemeDataExtension on BuildContext {
  ThemeData get theme {
    return Theme.of(this);
  }
}
