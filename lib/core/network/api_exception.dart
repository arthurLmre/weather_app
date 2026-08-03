enum ApiExceptionType {
  connection,
  timeout,
  badResponse,
  cancelled,
  invalidData,
  unknown,
}

final class ApiException implements Exception {
  const ApiException({
    required this.type,
    required this.message,
    this.statusCode,
  });

  final ApiExceptionType type;
  final String message;
  final int? statusCode;

  @override
  String toString() {
    return 'ApiException('
        'type: $type, '
        'statusCode: $statusCode, '
        'message: $message'
        ')';
  }
}
