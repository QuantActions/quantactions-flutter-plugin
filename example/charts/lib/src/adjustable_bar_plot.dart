part of charts;

class AdjustableBarPlot extends StatefulWidget {
  final List<double> data;
  final List<sugar.ZonedDateTime> timestamps;
  final Metric metric;
  final ChartMode chartMode;
  final List<double> scores;
  final List<bool> journal;


  const AdjustableBarPlot({
    super.key,
    required this.data,
    required this.timestamps,
    required this.scores,
    required this.journal,
    required this.chartMode,
    required this.metric,
  });

  @override
  State<AdjustableBarPlot> createState() => _AdjustableBarPlotState();
}

extension SafeExtremaDouble on List<double> {

  double safeMax() {
    final List<double> newValues = where((double element) => !element.isNaN).toList();
    if (newValues.isEmpty) {
      return 0.0;
    }
    return newValues.max!;
  }

  double safeMin() {
    final List<double> newValues = where((double element) => !element.isNaN).toList();
    if (newValues.isEmpty) {
      return 0.0;
    }
    return newValues.min!;
  }

}

class _AdjustableBarPlotState extends State<AdjustableBarPlot> {
  double selectedY = -1.0;
  double selectedX = -1.0;
  double selectedPoint = -1.0;
  double selectedXDots = -1.0;
  List<Point<double>> flatPointsList = List<Point<double>>.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    final double tenPercent = (widget.data.safeMax()) * 0.1;
    double minValRequested = widget.data.safeMin();
    minValRequested =
        (((minValRequested < tenPercent) ? 0 : minValRequested - tenPercent) ~/ 100) * 100;
    double maxValRequested = widget.data.safeMax();

    maxValRequested = maxValRequested - maxValRequested % 25 + 25;
    
    final Color color = widget.metric.getPrimaryColor(
        colors: context.theme.colors); 

    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 8, right: 20),
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
                          data: widget.data.toList(),
                          color: context.theme.colors.chartValuesScale,
                          yAxisType: YAxisType.scalarDynamic,
                          maxValRequested: maxValRequested,
                          minValRequested: minValRequested,
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
                          painter: SingleBarPainter(
                            data: widget.data.toList(),
                            color: color,
                            chartMode: widget.chartMode,
                            meshColor: context.theme.colors.chartMesh,
                            selectedXDouble: selectedX,
                            minValRequested: minValRequested,
                            maxValRequested: maxValRequested,
                            adaptiveRange: true
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 46),
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
                            scores: widget.scores,
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
                      flex: 10,
                      child: GestureDetector(
                        onTapDown: (TapDownDetails tapOffset) {
                          setState(() {
                            selectedX = tapOffset.localPosition.dx;
                          });
                        },
                        child: CustomPaint(
                          painter: XAxisPainter(
                            data: widget.data.toList(),
                            timestamps: widget.timestamps.toList(),
                            color: color,
                            weekEnds: context.theme.colors.chartWeekEnds,
                            workDays: context.theme.colors.chartWorkDays,
                            chartMode: widget.chartMode,
                            selectedXDouble: selectedX,
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
                                    color: color,
                                    grey: context.theme.colors.chartWorkDays,
                                    chartMode: widget.chartMode,
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
        const SizedBox(height: 30),
        AdjustableBarLegend(
          chartMode: widget.chartMode,
          color: color,
        ),
      ],
    );
  }
}
