part of charts;

enum ChartMode {
  days(length: 14),
  weeks(length: 6),
  months(length: 12);

  final int length;

  const ChartMode({
    required this.length,
  });
}
