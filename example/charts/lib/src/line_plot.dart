part of charts;

class LinePlot extends StatefulWidget {
  final List<double> data;
  final List<sugar.ZonedDateTime> timestamps;
  final List<double> confidenceIntervalLow;
  final List<double> confidenceIntervalHigh;
  final List<bool> journal;
  final Pair<int, int> populationRange;
  final ChartMode chartMode;
  final Metric metric;

  const LinePlot({
    super.key,
    required this.data,
    required this.timestamps,
    required this.journal,
    required this.populationRange,
    required this.metric,
    required this.chartMode,
  })  : confidenceIntervalLow = const <double>[],
        confidenceIntervalHigh = const <double>[];

  const LinePlot.withUncertainty({
    super.key,
    required this.data,
    required this.timestamps,
    required this.metric,
    required this.confidenceIntervalLow,
    required this.confidenceIntervalHigh,
    required this.journal,
    required this.populationRange,
    required this.chartMode,
  });

  bool get isWithUncertainty =>
      confidenceIntervalLow.isNotEmpty && confidenceIntervalHigh.isNotEmpty;

  @override
  State<LinePlot> createState() => _LinePlotState();
}

class _LinePlotState extends State<LinePlot> {

  double selectedY = -1.0;
  double selectedX = -1.0;
  int selectedPoint = -1;
  double selectedXDots = -1.0;
  List<Point<double>> flatPointsList = List<Point<double>>.empty(growable: true);

  bool isUncertaintyActive = true;

  @override
  Widget build(BuildContext context) {

    final Color color = widget.metric.getPrimaryColor(
        colors: context.theme.colors);
    // print('LinePlot ${widget.data} ${widget.timestamps}');

    return Column(
      mainAxisSize: MainAxisSize.min,
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
                          data: widget.data.reversed.toList(),
                          color: context.theme.colors.chartValuesScale,
                          yAxisType: YAxisType.scalar,
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
                          painter: ShadedLinePlotPainter(
                            data: widget.data,//.mapIndexed((index, p1) => index != 5 ? p1 : double.nan).toList(),
                            confidenceIntervalLow: widget.confidenceIntervalLow,//.mapIndexed((index, p1) => index != 5 ? p1 : double.nan).toList(),
                            confidenceIntervalHigh:
                                widget.confidenceIntervalHigh,//.mapIndexed((index, p1) => index != 5 ? p1 : double.nan).toList(),
                            populationRange: widget.populationRange,
                            primaryColor: color,
                            populationRangeBorder: context.theme.colors.chartBorder,
                            populationRangeBackground: context.theme.colors.chartMesh,
                            meshColor: context.theme.colors.chartMesh,
                            selectedXDouble: selectedX,
                            chartMode: widget.chartMode,
                            isUncertaintyActive: isUncertaintyActive,
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
                            chartMode: widget.chartMode,
                            weekEnds: context.theme.colors.chartWeekEnds,
                            workDays: context.theme.colors.chartWorkDays,
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
                    Expanded(
                      child: Container(),
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
        const SizedBox(height: 24),
        ShadedLineLegend(
          isWithUncertainty: widget.isWithUncertainty,
          onTap: ({required bool value}) {
            setState(() {
              isUncertaintyActive = value;
            });
          },
          isUncertaintyActive: isUncertaintyActive,
          color: color,
        ),
      ],
    );
  }

}
