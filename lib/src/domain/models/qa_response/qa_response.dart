class QAResponse<T> {
  final T? data;
  final String? message;

  QAResponse({
    required this.data,
    required this.message,
  });
}
