part of core_ui;

final ThemeData darkTheme = _buildThemeData(
  base: ThemeData.dark().copyWith(
    extensions: <ThemeExtension<AppColorsTheme>>[
      const DarkColorsTheme(),
    ],
  ),
);

final ThemeData lightTheme = _buildThemeData(
  base: ThemeData.light().copyWith(
    extensions: <ThemeExtension<AppColorsTheme>>[
      const LightColorsTheme(),
    ],
  ),
);

ThemeData _buildThemeData({
  required ThemeData base,
}) {
  final AppColorsTheme colors = base.colors;

  return base.copyWith(
    scaffoldBackgroundColor: colors.primaryBackground,
    textTheme: _getTextTheme(colors),
    inputDecorationTheme: _getInputDecorationTheme(colors),
    primaryColor: colors.primaryBackground,
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: colors.secondaryBackground,
      primary: colors.primaryBackground,
    ),
  );
}

TextTheme _getTextTheme(AppColorsTheme colors) {
  return const TextTheme(
    titleMedium: AppFonts.roboto16Normal,
    bodyMedium: AppFonts.roboto16Normal,
  ).apply(
    bodyColor: colors.text,
    displayColor: colors.secondaryBackground,
  );
}

InputDecorationTheme _getInputDecorationTheme(AppColorsTheme colors) {
  return InputDecorationTheme(
    hintStyle: AppFonts.roboto16Normal.copyWith(
      color: colors.secondaryBackground,
    ),
    border: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.BORDER_RADIUS_12),
      ),
      borderSide: BorderSide(
        color: colors.secondaryBackground,
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.BORDER_RADIUS_12),
      ),
      borderSide: BorderSide(
        color: colors.secondaryBackground,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(AppDimens.BORDER_RADIUS_6),
      ),
      borderSide: BorderSide(
        color: colors.secondaryBackground,
        width: 2,
      ),
    ),
    labelStyle: AppFonts.roboto16Normal.copyWith(
      color: colors.secondaryBackground,
    ),
  );
}
