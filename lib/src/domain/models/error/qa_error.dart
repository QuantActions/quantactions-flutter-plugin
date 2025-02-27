/// QAError is a custom error class that is used to handle errors in the application.
class QAError implements Exception {
  /// Description of the error.
  final String description;

  /// Reason for the error.
  final String? reason;

  /// Constructor for [QAError].
  const QAError({
    required this.description,
    this.reason,
  });

  @override
  String toString() => 'QAError: $description, reason: $reason';
}
