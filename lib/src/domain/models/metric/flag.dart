enum Flag {
  day(id: 'day'),
  week(id: 'week'),
  month(id: 'month');

  const Flag({
    required this.id,
  });

  final String id;
}
