import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:weather_app/core/network/api_client.dart';
import 'package:weather_app/core/network/api_exception.dart';

final class DioApiClient implements ApiClient {
  DioApiClient({Dio? dio}) : _dio = dio ?? _createDio();

  final Dio _dio;

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        responseType: ResponseType.json,
        headers: const {'Accept': 'application/json'},
      ),
    );

    if (kDebugMode) {
      dio.interceptors.add(
        LogInterceptor(
          request: true,
          requestHeader: false,
          requestBody: true,
          responseHeader: false,
          responseBody: true,
          error: true,
        ),
      );
    }

    return dio;
  }

  @override
  Future<Map<String, dynamic>> get(
    String url, {
    Map<String, dynamic>? queryParameters,
    CancelToken? cancelToken,
  }) async {
    try {
      final response = await _dio.get<Object?>(
        url,
        queryParameters: queryParameters,
        cancelToken: cancelToken,
      );

      final data = response.data;

      if (data is Map<String, dynamic>) {
        return data;
      }

      if (data is Map) {
        return Map<String, dynamic>.from(data);
      }

      throw const ApiException(
        type: ApiExceptionType.invalidData,
        message: 'Le serveur a renvoyé des données invalides.',
      );
    } on DioException catch (error) {
      throw _mapDioException(error);
    }
  }

  ApiException _mapDioException(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const ApiException(
          type: ApiExceptionType.timeout,
          message: 'La requête a pris trop de temps.',
        );

      case DioExceptionType.connectionError:
      case DioExceptionType.badCertificate:
        return const ApiException(
          type: ApiExceptionType.connection,
          message: 'Impossible de se connecter au service météo.',
        );

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;

        return ApiException(
          type: ApiExceptionType.badResponse,
          statusCode: statusCode,
          message: _getResponseErrorMessage(statusCode),
        );

      case DioExceptionType.cancel:
        return const ApiException(
          type: ApiExceptionType.cancelled,
          message: 'La requête a été annulée.',
        );

      default:
        return const ApiException(
          type: ApiExceptionType.unknown,
          message: 'Une erreur inattendue est survenue.',
        );
    }
  }

  String _getResponseErrorMessage(int? statusCode) {
    return switch (statusCode) {
      400 => 'La requête envoyée est invalide.',
      404 => 'La ressource demandée est introuvable.',
      429 => 'Trop de requêtes ont été envoyées.',
      null => 'Le serveur a renvoyé une réponse invalide.',
      >= 500 => 'Le service météo est temporairement indisponible.',
      _ => 'Une erreur est survenue lors de la requête.',
    };
  }
}
