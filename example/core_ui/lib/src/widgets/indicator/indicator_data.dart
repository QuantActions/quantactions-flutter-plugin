
import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class IndicatorData extends StatelessWidget {
  final int percent;

  const IndicatorData({super.key,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('$percent', style: AppFonts.roboto40Normal),
            const Padding(
              padding: EdgeInsets.only(bottom: 8),
              child: Text('/100', style: AppFonts.roboto16Medium),
            ),
          ],
        ),
        Text(
          percent > 33 ? (percent > 66 ? 'Good' : 'Fair') : 'Poor',
          style: AppFonts.roboto24Medium.copyWith(
            color: context.theme.colors.textDark,
          ),
        ),
      ],
    );
  }
}
