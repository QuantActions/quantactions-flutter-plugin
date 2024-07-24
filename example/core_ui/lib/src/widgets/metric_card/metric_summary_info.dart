import 'package:core_ui/core_ui.dart';
import 'package:dartx/dartx.dart';
import 'package:flutter/cupertino.dart';
import 'package:qa_flutter_plugin/qa_flutter_plugin.dart';

class MetricSummaryInfo extends StatelessWidget {
  final bool isDataLoading;
  final Metric metric;
  final Pair<String, String> shortMetricValue;

  const MetricSummaryInfo({super.key, 
    required this.isDataLoading,
    required this.metric,
    required this.shortMetricValue,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        isDataLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 6),
                child: DotsLoader(
                    size: 8,
                    color:
                        metric.getPrimaryColor(colors: context.theme.colors)),
              )
            : Row(
                children: [
                  Text(
                    shortMetricValue.first,
                    style: AppFonts.roboto16Normal.copyWith(
                      color:
                          metric.getPrimaryColor(colors: context.theme.colors),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Text(
                    '—',
                    style: AppFonts.roboto16Normal.copyWith(
                      color:
                          metric.getPrimaryColor(colors: context.theme.colors),
                    ),
                  ),
                  const SizedBox(width: 10),
                  shortMetricValue.second == '--'
                      ? AppIcons.loading(
                          size: 14,
                          color: context.theme.colors.textLight.withAlpha(55))
                      : Text(
                          shortMetricValue.second,
                          style: AppFonts.roboto16Normal.copyWith(
                            color: metric.getPrimaryColor(
                                colors: context.theme.colors),
                          ),
                        ),
                ],
              ),
        const SizedBox(height: 8),
        Text(
          "Your 14-day score",
          style: AppFonts.roboto14Normal.copyWith(
            color: context.theme.colors.textDark,
          ),
        ),
      ],
    );
  }
}
