// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'city_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CityDto _$CityDtoFromJson(Map<String, dynamic> json) => _CityDto(
  id: (json['id'] as num).toInt(),
  name: json['name'] as String,
  latitude: (json['latitude'] as num).toDouble(),
  longitude: (json['longitude'] as num).toDouble(),
  country: json['country'] as String? ?? 'Pays inconnu',
  region: json['admin1'] as String?,
  countryCode: json['country_code'] as String?,
  timezone: json['timezone'] as String?,
);

Map<String, dynamic> _$CityDtoToJson(_CityDto instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'country': instance.country,
  'admin1': instance.region,
  'country_code': instance.countryCode,
  'timezone': instance.timezone,
};
