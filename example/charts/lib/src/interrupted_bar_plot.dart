part of charts;

class InterruptedBarPlot extends StatefulWidget {
  final Metric metric;
  final List<double> scores;
  final TimeSeries<SleepSummary> timeSeries;
  final ChartMode chartMode;

  const InterruptedBarPlot({
    super.key,
    required this.scores,
    required this.timeSeries,
    required this.chartMode,
    required this.metric,
  });

  @override
  State<InterruptedBarPlot> createState() => _InterruptedBarPlotState();
}

class _InterruptedBarPlotState extends State<InterruptedBarPlot> {
  double selectedY = -1.0;
  double selectedX = -1.0;
  double selectedPoint = -1.0;
  List<Point<double>> flatPointsList = List<Point<double>>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    final int minHourInSeconds = ChartUtils.findMinSleepStart(widget.timeSeries);
    final int maxHourInSeconds = ChartUtils.findMaxSleepEnd(widget.timeSeries);

    // print('Min hour in seconds is $minHourInSeconds');
    // print('Max hour in seconds is $maxHourInSeconds');

    final DateTime reference = Jiffy.parseFromDateTime(DateTime.now().toLocal()).startOf(Unit.day).dateTime;
    final DateTime minTime = reference.add(Duration(seconds: minHourInSeconds));
    final DateTime maxTime = reference.add(Duration(seconds: maxHourInSeconds));
    final int nHours = maxTime.difference(minTime).inHours + 1;

    // print('Min time is $minTime');
    // print('Max time is $maxTime');

    final DateFormat formatterHours = DateFormat('HH:mm');

    final List<String> yLabels = List<String>.generate(
      nHours,
      (int index) => formatterHours.format(minTime.add(Duration(hours: index))),
    );

    final double height = 20 * nHours.toDouble();
    final Color color = widget.metric.getPrimaryColor(colors: context.theme.colors);

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 20),
          child: SizedBox(
            height: height,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Expanded(
                  child: CustomPaint(
                    painter: YAxisPainter(
                      data: yLabels,
                      color: context.theme.colors.chartValuesScale,
                      yAxisType: YAxisType.timeOfDay,
                    ),
                  ),
                ),
                Expanded(
                  flex: 8,
                  child: GestureDetector(
                    onTapDown: (TapDownDetails tapOffset) {
                      setState(() {
                        selectedX = tapOffset.localPosition.dx;
                      });
                    },
                    child: CustomPaint(
                      painter: InterruptedBarPlotPainter(
                        timeSeries: widget.timeSeries,
                        color: color,
                        meshColor: context.theme.colors.chartMesh,
                        chartMode: widget.chartMode,
                        selectedXDouble: selectedX,
                        minHour: minHourInSeconds,
                        maxHour: maxHourInSeconds,
                        nHorizontalLines: nHours,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 20),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 20,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: AppIcons.owlShort(
                        color: context.theme.colors.iconMiddleDark,
                        onTap: () {
                        },
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: GestureDetector(
                        onTapDown: (TapDownDetails tapOffset) {
                          setState(() {
                            selectedX = tapOffset.localPosition.dx;
                          });
                        },
                        child: CustomPaint(
                          painter: OwlPainter(
                            isLarge: true,
                            color: color,
                            textColor: context.theme.colors.textMiddleLight,
                            chartMode: widget.chartMode,
                            score: widget.timeSeries.values
                                .map((SleepSummary e) => e.interruptionsStart.length.toDouble())
                                .toList(),
                            selectedXDouble: selectedX,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              SizedBox(
                height: 20,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: AppIcons.gauge(
                        size: 16,
                        color: context.theme.colors.iconMiddleDark,
                        onTap: () {

                        },
                      ),
                    ),
                    Expanded(
                      flex: 8,
                      child: GestureDetector(
                        onTapDown: (TapDownDetails tapOffset) {
                          setState(() {
                            selectedX = tapOffset.localPosition.dx;
                          });
                        },
                        child: CustomPaint(
                          painter: ScorePainter(
                            isLarge: true,
                            color: color,
                            chartMode: widget.chartMode,
                            scores: widget.scores
                                .map((double score) => score.isNaN ? 0.0 : score)

                                .toList(),
                            selectedXDouble: selectedX,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 16,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: Container(),
                    ),
                    Expanded(
                      flex: 8,
                      child: GestureDetector(
                        onTapDown: (TapDownDetails tapOffset) {
                          setState(() {
                            selectedX = tapOffset.localPosition.dx;
                          });
                        },
                        child: CustomPaint(
                          painter: XAxisPainter(
                            isLarge: true,
                            data: widget.scores.toList(),
                            timestamps: widget.timeSeries.timestamps.toList(),
                            color: color,
                            weekEnds: context.theme.colors.chartWeekEnds,
                            workDays: context.theme.colors.chartWorkDays,
                            selectedXDouble: selectedX,
                            chartMode: widget.chartMode,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 30),
        InterruptedBarLegend(
          chartMode: widget.chartMode,
          color: color,
        ),
      ],
    );
  }
}
