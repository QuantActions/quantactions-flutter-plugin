import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core_ui.dart';

class AppImage {
  static const String _svgFileRegex = r'.svg$';
  static const double _defaultIconPadding = 0;

  final String iconKey;

  bool get isSVG => iconKey.contains(RegExp(_svgFileRegex));

  const AppImage(this.iconKey);

  Widget call({
    Color? color,
    double? size,
    BoxFit? fit,
    Function()? onTap,
    double padding = _defaultIconPadding,
  }) {
    assert(
      isSVG,
      'Implemented only for svg',
    );

    return InkWell(
      borderRadius: BorderRadius.circular(size ?? padding),
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.all(padding),
        child: SvgPicture.asset(
          iconKey,
          package: AppIcons.packageName,
          colorFilter: color != null
              ? ColorFilter.mode(
                  color,
                  BlendMode.srcIn,
                )
              : null,
          fit: fit ?? BoxFit.contain,
          height: size,
          width: size,
        ),
      ),
    );
  }
}
