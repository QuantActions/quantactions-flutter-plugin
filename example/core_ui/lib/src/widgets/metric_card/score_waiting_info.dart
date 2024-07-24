import 'package:core_ui/core_ui.dart';
import 'package:flutter/cupertino.dart';

class ScoreWaitingInfo extends StatelessWidget {
  final bool showWaitingLastPercent;
  final int metricETA;
  final int metricScoreReadyIn;

  const ScoreWaitingInfo({super.key, 
    required this.metricETA,
    this.showWaitingLastPercent = false,
    required this.metricScoreReadyIn,
  });

  @override
  Widget build(BuildContext context) {
    final double prePerc = (100 / metricETA) * (metricETA - metricScoreReadyIn);
    final double shieldPerc = prePerc >= 100 ? 99 : prePerc;
    final double perc = shieldPerc < 33 ? 33 : shieldPerc;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (shieldPerc == 99)
          // Flexible(
          //   child:
            Text(
              "Score is almost ready",
              style: AppFonts.roboto14Normal.copyWith(
                color: context.theme.colors.textDark,
              ),
            )
          // )
        else
          // Flexible(
          //   child:
            Text(
              "Score ready in $metricScoreReadyIn days",
              style: AppFonts.roboto14Normal.copyWith(
                color: context.theme.colors.textDark,
              ),
            ),
          // ),
        const SizedBox(height: 8),
        Container(
          height: 24,
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            color: context.theme.colors.metricCardBorder,
            borderRadius: BorderRadius.circular(12),
          ),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return FractionallySizedBox(
                widthFactor: perc / 100,
                child: Container(
                  alignment: Alignment.centerLeft,
                  decoration: BoxDecoration(
                    color: context.theme.colors.textDark,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      '${perc.round()}%',
                      style: AppFonts.roboto12Normal.copyWith(
                        color: context.theme.colors.textWhite,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
