class QAError implements Exception {
  final String description;
  final String? reason;

  const QAError({
    required this.description,
    this.reason,
  });

  @override
  String toString() => 'QAError: $description, reason: $reason';
}
