import 'package:dio/dio.dart';

abstract interface class ApiClient {
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  });
}
