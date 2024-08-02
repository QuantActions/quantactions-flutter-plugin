part of charts;


class CumulativeBarPlot extends StatefulWidget {
  final List<double> totalData;
  final List<double> data;
  final List<sugar.ZonedDateTime> timestamps;
  final ChartMode chartMode;
  final List<double> scores;
  final List<bool> journal;
  final Metric metric;


  const CumulativeBarPlot({
    super.key,
    required this.totalData,
    required this.data,
    required this.timestamps,
    required this.journal,
    required this.chartMode,
    required this.scores,
    required this.metric,
  });

  @override
  State<CumulativeBarPlot> createState() => _CumulativeBarPlotState();
}

class _CumulativeBarPlotState extends State<CumulativeBarPlot> {
  final double minDependValue = 32400000; //9h
  final double hour = 3600000; //1h

  double selectedY = -1.0;
  double selectedX = -1.0;
  double selectedPoint = -1.0;
  double selectedXDots = -1.0;
  List<Point<double>> flatPointsList = List<Point<double>>.empty(
    growable: true,
  );

  @override
  Widget build(BuildContext context) {

    final Color color = Metric.socialEngagement.getPrimaryColor(colors: context.theme.colors);
    final Color totalColor = context.theme.colors.chartAdditionalColor;


    final double maxCommonDataValue = widget.totalData.safeMax();
    final double maxValRequested = DateTimeUtils.getNextHourByMilliseconds(maxCommonDataValue.toInt()).toDouble();

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 16, right: 28),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 250,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    Expanded(
                      child: CustomPaint(
                        painter: YAxisPainter(
                          data: widget.totalData,
                          color: context.theme.colors.chartValuesScale,
                          yAxisType: YAxisType.duration,
                          maxValRequested: maxValRequested,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 10,
                      child: GestureDetector(
                        onTapDown: (TapDownDetails tapOffset) {
                          setState(() {
                            selectedX = tapOffset.localPosition.dx;
                          });
                        },
                        child: CustomPaint(
                          painter: CumulativeBarPainter(
                            maxVal: maxValRequested,
                            data: widget.data.toList(),
                            totalData: widget.totalData.toList(),
                            totalColor: totalColor,
                            color: color,
                            selectedXDouble: selectedX,
                            chartMode: widget.chartMode,
                            meshColor: context.theme.colors.chartMesh,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 48),
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
                      flex: 10,
                      child: GestureDetector(
                        onTapDown: (TapDownDetails tapOffset) {
                          setState(() {
                            selectedX = tapOffset.localPosition.dx;
                          });
                        },
                        child: CustomPaint(
                          painter: ScorePainter(
                            color: color,
                            chartMode: widget.chartMode,
                            scores: widget.scores.toList(),
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
                    const Expanded(
                      child: SizedBox.shrink(),
                    ),
                    Expanded(
                      flex: 10,
                      child: GestureDetector(
                        onTapDown: (TapDownDetails tapOffset) {
                          setState(() {
                            selectedX = tapOffset.localPosition.dx;
                          });
                        },
                        child: CustomPaint(
                          painter: XAxisPainter(
                            data: widget.totalData.toList(),
                            timestamps: widget.timestamps.toList(),
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
              if (widget.chartMode != ChartMode.months) SizedBox(
                height: 16,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Expanded(
                      child: SizedBox.shrink(),
                    ),
                    Expanded(
                      flex: 10,
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final canvasSize = constraints.biggest;
                          flatPointsList =
                              ChartUtils.calculatePointsForDataGeneralFlat(
                                data: List<double>.generate(widget.journal.length, (int index) => 0.0),
                                width: canvasSize.width,
                                height: canvasSize.height,
                                reverse: false,
                                maxVal: 100,
                                minVal: 0,
                                horizontalBias: 0,
                                includeOutOfChartLeft: false,
                              );
                          return GestureDetector(
                            onTapDown: (TapDownDetails tapOffset) {
                              setState(() {
                                if (tapOffset.localPosition.dx > 0) { }
                              });
                            },
                            child: CustomPaint(
                              painter: JournalPainter(
                                journal: widget.journal,
                                chartMode: widget.chartMode,
                                color: color,
                                grey: context.theme.colors.chartWorkDays,
                                selectedXDouble: selectedX
                              ),
                            ),
                          );
                        }
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 28),
        CumulativeBarLegend(
          chartMode: widget.chartMode,
          color: color,
          totalColor: totalColor,
          displayName: widget.metric.displayName,
        ),
      ],
    );
  }
}
