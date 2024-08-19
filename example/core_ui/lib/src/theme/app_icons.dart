part of core_ui;

class AppIcons {
  static const String packageName = kPackageName;

  static const String _basePath = kIconsPath;

  static const String _questionKey = '${_basePath}question.svg';
  static const String _doneKey = '${_basePath}done.svg';
  static const String _loadingKey = '${_basePath}waiting.svg';
  static const String _owlKey = '${_basePath}owl.svg';
  static const String _scoreKey = '${_basePath}score.svg';
  static const String _scoreCommonKey = '${_basePath}score_common.svg';
  static const String _scoreFillKey = '${_basePath}score_fill.svg';
  static const String _gaugeKey = '${_basePath}gauge.svg';
  static const String _owlShortKey = '${_basePath}owl_short.svg';

  static const AppIcon question = AppIcon(_questionKey);
  static const AppIcon done = AppIcon(_doneKey);
  static const AppIcon loading = AppIcon(_loadingKey);
  static const AppIcon score = AppIcon(_scoreKey);
  static const AppIcon scoreCommon = AppIcon(_scoreCommonKey);
  static const AppIcon scoreFill = AppIcon(_scoreFillKey);
  static const AppIcon gauge = AppIcon(_gaugeKey);
  static const AppIcon owlShort = AppIcon(_owlShortKey);
  static const AppIcon owl = AppIcon(_owlKey);

}
