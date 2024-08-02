import 'package:flutter/material.dart';

import '../../core_ui.dart';

class PoweredByQuantActions extends StatelessWidget {
  const PoweredByQuantActions({super.key});


  @override
  Widget build(BuildContext context) {
    const double iconPadding = AppDimens.PADDING_4;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text(
          'Powered by',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.black87,
        )),
        Padding(
          padding: const EdgeInsets.only(left: iconPadding),
          child:
            AppImages.qaLogoLight(size: 15),

        ),

      ],
    );
  }
}
