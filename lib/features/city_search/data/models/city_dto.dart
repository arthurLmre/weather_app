import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';

part 'city_dto.freezed.dart';
part 'city_dto.g.dart';

@freezed
abstract class CityDto with _$CityDto {
  const CityDto._();

  const factory CityDto({
    required int id,
    required String name,
    required double latitude,
    required double longitude,
    @Default('Pays inconnu') String country,
    @JsonKey(name: 'admin1') String? region,
    @JsonKey(name: 'country_code') String? countryCode,
    String? timezone,
  }) = _CityDto;

  factory CityDto.fromJson(Map<String, dynamic> json) =>
      _$CityDtoFromJson(json);

  factory CityDto.fromDomain(City city) {
    return CityDto(
      id: city.id,
      name: city.name,
      latitude: city.latitude,
      longitude: city.longitude,
      country: city.country,
      region: city.region,
      countryCode: city.countryCode,
      timezone: city.timezone,
    );
  }

  City toDomain() {
    return City(
      id: id,
      name: name,
      latitude: latitude,
      longitude: longitude,
      country: country,
      region: region,
      countryCode: countryCode,
      timezone: timezone,
    );
  }
}
