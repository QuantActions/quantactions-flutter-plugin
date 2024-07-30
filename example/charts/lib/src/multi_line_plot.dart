part of charts;

class MultiLinePlot extends StatefulWidget {
  final List<List<double>> data;
  final List<List<sugar.ZonedDateTime>> timestamps;
  final List<List<double>?> confidenceIntervalLow;
  final List<List<double>?> confidenceIntervalHigh;
  final List<bool> journal;
  final List<Color> colors;
  final List<String> titles;
  final ChartMode chartMode;

  const MultiLinePlot({
    super.key,
    required this.data,
    required this.timestamps,
    required this.journal,
    required this.confidenceIntervalLow,
    required this.confidenceIntervalHigh,
    required this.titles,
    required this.colors,
    required this.chartMode,
  }) : assert(data.length == colors.length);

  @override
  State<MultiLinePlot> createState() => _MultiLinePlotState();
}

class _MultiLinePlotState extends State<MultiLinePlot> {
  double selectedY = -1.0;
  double selectedX = -1.0;
  double selectedPoint = -1.0;
  double selectedXDots = -1.0;
  List<Point<double>> flatPointsList = List<Point<double>>.empty(growable: true);

  late List<bool> activities;

  @override
  void initState() {
    activities = List<bool>.generate(widget.data.length, (int index) => true);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    print('Journal dots are ${widget.journal}');

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
                          data: widget.data.expand((List<double> list) => list.reversed).toList(),
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
                            painter: MultiLinePlotPainter(
                              meshColor: context.theme.colors.chartMesh,
                              chartMode: widget.chartMode,
                              activities: activities,
                              colors: widget.colors,
                              data: widget.data,
                              confidenceIntervalHigh: widget.confidenceIntervalHigh,
                              confidenceIntervalLow: widget.confidenceIntervalLow,
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
                    const Expanded(child: SizedBox.shrink()),
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
                            data: widget.data.expand((List<double> list) => list).toList(),
                            timestamps: widget.timestamps.expand((List<sugar.ZonedDateTime> list) => list).toList(),
                            color: context.theme.colors.chartMesh,
                            chartMode: widget.chartMode,
                            weekEnds: context.theme.colors.chartWeekEnds,
                            workDays: context.theme.colors.chartWorkDays,
                            selectedXDouble: -1.0,
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
                    const Expanded(child: SizedBox.shrink()),
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
                                if (tapOffset.localPosition.dx > 0) {  }
                              });
                            },
                            child: CustomPaint(
                              painter: JournalPainter(
                                journal: widget.journal,
                                color: context.theme.colors.chartWorkDays,
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
        const SizedBox(height: 14),
        const AppDivider(),
        const SizedBox(height: 14),
        MultiLineLegend(
          onTap: ({
            required int index,
            required bool value,
          }) {
            setState(() {
              activities[index] = value;
            });
          },
          titles: widget.titles,
          activities: activities,
          colors: widget.colors,
        ),
      ],
    );
  }
}
