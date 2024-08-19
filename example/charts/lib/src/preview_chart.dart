part of charts;

class PreviewChart extends StatelessWidget {
  final List<double> data;
  final Color color;
  final double width;
  final double padding;

  const PreviewChart({
    Key? key,
    required this.data,
    required this.color,
    required this.width,
    this.padding = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(width),
        child: CustomPaint(
          size: Size(width, width),
          painter: PreviewChartPainter(data: data, color: color),
        ),
      ),
    );
  }
}
