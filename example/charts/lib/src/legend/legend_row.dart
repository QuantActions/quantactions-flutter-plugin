import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class LegendRow extends StatelessWidget {
  final Widget? checkbox;
  final Widget icon;
  final Widget title;
  final bool isCheckboxPadding;
  final String? info;


  const LegendRow({super.key, 
    required this.icon,
    required this.title,
    this.isCheckboxPadding = false,
    this.checkbox,
    this.info,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        const SizedBox(width: 16),
        if (isCheckboxPadding) ...<Widget>{
          const SizedBox(width: 36),
        },
        if (checkbox != null) ...<Widget>{
          checkbox!,
          const SizedBox(width: 16),
        },
        icon,
        const SizedBox(width: 10),
        Flexible(child: title),
        if (info != null) ...<Widget>{
          const SizedBox(width: 8),
          AppIcons.question(
            color: context.theme.colors.iconDark,
            onTap: () {

            },
          ),
        }
      ],
    );
  }
}
