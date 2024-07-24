import 'package:flutter/material.dart';

import '../../core_ui.dart';

class AppCard extends StatelessWidget {
  final Widget child;
  final Widget? floatingIcon;
  final bool shouldBorder;
  final Function()? onTap;
  final EdgeInsets padding;

  const AppCard({super.key, 
    required this.child,
    this.floatingIcon,
    this.onTap,
    this.shouldBorder = true,
    this.padding = const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
  });

  @override
  Widget build(BuildContext context) {
    const double iconPadding = AppDimens.PADDING_8;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.theme.colors.primaryBackground,
        borderRadius: BorderRadius.circular(8),
        border: shouldBorder ? Border.all(color: context.theme.colors.metricCardBorder) : null,
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: context.theme.colors.shadowBlue,
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: <Widget>[
          Padding(
            padding: padding,
            child: InkWell(
              onTap: onTap,
              child: child,
            ),
          ),
          if (floatingIcon != null)
            Positioned(
              top: iconPadding,
              right: iconPadding,
              child: floatingIcon!,
            ),
        ],
      ),
    );
  }
}
