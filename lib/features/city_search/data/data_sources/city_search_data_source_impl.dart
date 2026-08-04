import 'package:weather_app/core/network/api_client.dart';
import 'package:weather_app/core/network/api_exception.dart';
import 'package:weather_app/features/city_search/data/data_sources/city_search_data_source.dart';
import 'package:weather_app/features/city_search/data/data_sources/city_search_end_points.dart';
import 'package:weather_app/features/city_search/data/models/city_dto.dart';

final class CitySearchDataSourceImpl implements CitySearchDataSource {
  const CitySearchDataSourceImpl({required this._apiClient});

  final ApiClient _apiClient;

  @override
  Future<List<CityDto>> searchCities(String query) async {
    final normalizedQuery = query.trim();

    if (normalizedQuery.length < 2) {
      return const [];
    }

    final json = await _apiClient.get(
      CitySearchEndPoints.search,
      queryParameters: {
        'name': normalizedQuery,
        'count': 10,
        'language': 'fr',
        'format': 'json',
      },
    );

    final results = json['results'];

    if (results == null) {
      return const [];
    }

    if (results is! List) {
      throw const ApiException(
        type: ApiExceptionType.invalidData,
        message: 'La réponse de recherche des villes est invalide.',
      );
    }

    try {
      return results
          .map((item) {
            if (item is! Map) {
              throw const FormatException('Un résultat de ville est invalide.');
            }

            return CityDto.fromJson(Map<String, dynamic>.from(item));
          })
          .toList(growable: false);
    } on FormatException catch (error) {
      throw ApiException(
        type: ApiExceptionType.invalidData,
        message: error.message,
      );
    } on TypeError {
      throw const ApiException(
        type: ApiExceptionType.invalidData,
        message: 'Les données reçues pour une ville sont invalides.',
      );
    }
  }
}
