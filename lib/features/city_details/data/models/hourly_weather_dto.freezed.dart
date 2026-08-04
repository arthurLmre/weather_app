// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hourly_weather_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HourlyWeatherDto {

@JsonKey(name: 'time') List<String> get dates;@JsonKey(name: 'weather_code') List<int> get weatherCodes;@JsonKey(name: 'temperature_2m') List<double> get temperatures;@JsonKey(name: 'apparent_temperature') List<double> get apparentTemperatures;@JsonKey(name: 'precipitation_probability') List<int> get precipitationProbabilities;@JsonKey(name: 'precipitation') List<double> get precipitations;@JsonKey(name: 'wind_speed_10m') List<double> get windSpeeds;
/// Create a copy of HourlyWeatherDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HourlyWeatherDtoCopyWith<HourlyWeatherDto> get copyWith => _$HourlyWeatherDtoCopyWithImpl<HourlyWeatherDto>(this as HourlyWeatherDto, _$identity);

  /// Serializes this HourlyWeatherDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HourlyWeatherDto&&const DeepCollectionEquality().equals(other.dates, dates)&&const DeepCollectionEquality().equals(other.weatherCodes, weatherCodes)&&const DeepCollectionEquality().equals(other.temperatures, temperatures)&&const DeepCollectionEquality().equals(other.apparentTemperatures, apparentTemperatures)&&const DeepCollectionEquality().equals(other.precipitationProbabilities, precipitationProbabilities)&&const DeepCollectionEquality().equals(other.precipitations, precipitations)&&const DeepCollectionEquality().equals(other.windSpeeds, windSpeeds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(dates),const DeepCollectionEquality().hash(weatherCodes),const DeepCollectionEquality().hash(temperatures),const DeepCollectionEquality().hash(apparentTemperatures),const DeepCollectionEquality().hash(precipitationProbabilities),const DeepCollectionEquality().hash(precipitations),const DeepCollectionEquality().hash(windSpeeds));

@override
String toString() {
  return 'HourlyWeatherDto(dates: $dates, weatherCodes: $weatherCodes, temperatures: $temperatures, apparentTemperatures: $apparentTemperatures, precipitationProbabilities: $precipitationProbabilities, precipitations: $precipitations, windSpeeds: $windSpeeds)';
}


}

/// @nodoc
abstract mixin class $HourlyWeatherDtoCopyWith<$Res>  {
  factory $HourlyWeatherDtoCopyWith(HourlyWeatherDto value, $Res Function(HourlyWeatherDto) _then) = _$HourlyWeatherDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'time') List<String> dates,@JsonKey(name: 'weather_code') List<int> weatherCodes,@JsonKey(name: 'temperature_2m') List<double> temperatures,@JsonKey(name: 'apparent_temperature') List<double> apparentTemperatures,@JsonKey(name: 'precipitation_probability') List<int> precipitationProbabilities,@JsonKey(name: 'precipitation') List<double> precipitations,@JsonKey(name: 'wind_speed_10m') List<double> windSpeeds
});




}
/// @nodoc
class _$HourlyWeatherDtoCopyWithImpl<$Res>
    implements $HourlyWeatherDtoCopyWith<$Res> {
  _$HourlyWeatherDtoCopyWithImpl(this._self, this._then);

  final HourlyWeatherDto _self;
  final $Res Function(HourlyWeatherDto) _then;

/// Create a copy of HourlyWeatherDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dates = null,Object? weatherCodes = null,Object? temperatures = null,Object? apparentTemperatures = null,Object? precipitationProbabilities = null,Object? precipitations = null,Object? windSpeeds = null,}) {
  return _then(_self.copyWith(
dates: null == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as List<String>,weatherCodes: null == weatherCodes ? _self.weatherCodes : weatherCodes // ignore: cast_nullable_to_non_nullable
as List<int>,temperatures: null == temperatures ? _self.temperatures : temperatures // ignore: cast_nullable_to_non_nullable
as List<double>,apparentTemperatures: null == apparentTemperatures ? _self.apparentTemperatures : apparentTemperatures // ignore: cast_nullable_to_non_nullable
as List<double>,precipitationProbabilities: null == precipitationProbabilities ? _self.precipitationProbabilities : precipitationProbabilities // ignore: cast_nullable_to_non_nullable
as List<int>,precipitations: null == precipitations ? _self.precipitations : precipitations // ignore: cast_nullable_to_non_nullable
as List<double>,windSpeeds: null == windSpeeds ? _self.windSpeeds : windSpeeds // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}


/// Adds pattern-matching-related methods to [HourlyWeatherDto].
extension HourlyWeatherDtoPatterns on HourlyWeatherDto {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HourlyWeatherDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HourlyWeatherDto() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HourlyWeatherDto value)  $default,){
final _that = this;
switch (_that) {
case _HourlyWeatherDto():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HourlyWeatherDto value)?  $default,){
final _that = this;
switch (_that) {
case _HourlyWeatherDto() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'time')  List<String> dates, @JsonKey(name: 'weather_code')  List<int> weatherCodes, @JsonKey(name: 'temperature_2m')  List<double> temperatures, @JsonKey(name: 'apparent_temperature')  List<double> apparentTemperatures, @JsonKey(name: 'precipitation_probability')  List<int> precipitationProbabilities, @JsonKey(name: 'precipitation')  List<double> precipitations, @JsonKey(name: 'wind_speed_10m')  List<double> windSpeeds)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HourlyWeatherDto() when $default != null:
return $default(_that.dates,_that.weatherCodes,_that.temperatures,_that.apparentTemperatures,_that.precipitationProbabilities,_that.precipitations,_that.windSpeeds);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'time')  List<String> dates, @JsonKey(name: 'weather_code')  List<int> weatherCodes, @JsonKey(name: 'temperature_2m')  List<double> temperatures, @JsonKey(name: 'apparent_temperature')  List<double> apparentTemperatures, @JsonKey(name: 'precipitation_probability')  List<int> precipitationProbabilities, @JsonKey(name: 'precipitation')  List<double> precipitations, @JsonKey(name: 'wind_speed_10m')  List<double> windSpeeds)  $default,) {final _that = this;
switch (_that) {
case _HourlyWeatherDto():
return $default(_that.dates,_that.weatherCodes,_that.temperatures,_that.apparentTemperatures,_that.precipitationProbabilities,_that.precipitations,_that.windSpeeds);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'time')  List<String> dates, @JsonKey(name: 'weather_code')  List<int> weatherCodes, @JsonKey(name: 'temperature_2m')  List<double> temperatures, @JsonKey(name: 'apparent_temperature')  List<double> apparentTemperatures, @JsonKey(name: 'precipitation_probability')  List<int> precipitationProbabilities, @JsonKey(name: 'precipitation')  List<double> precipitations, @JsonKey(name: 'wind_speed_10m')  List<double> windSpeeds)?  $default,) {final _that = this;
switch (_that) {
case _HourlyWeatherDto() when $default != null:
return $default(_that.dates,_that.weatherCodes,_that.temperatures,_that.apparentTemperatures,_that.precipitationProbabilities,_that.precipitations,_that.windSpeeds);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HourlyWeatherDto extends HourlyWeatherDto {
  const _HourlyWeatherDto({@JsonKey(name: 'time') required final  List<String> dates, @JsonKey(name: 'weather_code') required final  List<int> weatherCodes, @JsonKey(name: 'temperature_2m') required final  List<double> temperatures, @JsonKey(name: 'apparent_temperature') required final  List<double> apparentTemperatures, @JsonKey(name: 'precipitation_probability') required final  List<int> precipitationProbabilities, @JsonKey(name: 'precipitation') required final  List<double> precipitations, @JsonKey(name: 'wind_speed_10m') required final  List<double> windSpeeds}): _dates = dates,_weatherCodes = weatherCodes,_temperatures = temperatures,_apparentTemperatures = apparentTemperatures,_precipitationProbabilities = precipitationProbabilities,_precipitations = precipitations,_windSpeeds = windSpeeds,super._();
  factory _HourlyWeatherDto.fromJson(Map<String, dynamic> json) => _$HourlyWeatherDtoFromJson(json);

 final  List<String> _dates;
@override@JsonKey(name: 'time') List<String> get dates {
  if (_dates is EqualUnmodifiableListView) return _dates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dates);
}

 final  List<int> _weatherCodes;
@override@JsonKey(name: 'weather_code') List<int> get weatherCodes {
  if (_weatherCodes is EqualUnmodifiableListView) return _weatherCodes;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weatherCodes);
}

 final  List<double> _temperatures;
@override@JsonKey(name: 'temperature_2m') List<double> get temperatures {
  if (_temperatures is EqualUnmodifiableListView) return _temperatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_temperatures);
}

 final  List<double> _apparentTemperatures;
@override@JsonKey(name: 'apparent_temperature') List<double> get apparentTemperatures {
  if (_apparentTemperatures is EqualUnmodifiableListView) return _apparentTemperatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_apparentTemperatures);
}

 final  List<int> _precipitationProbabilities;
@override@JsonKey(name: 'precipitation_probability') List<int> get precipitationProbabilities {
  if (_precipitationProbabilities is EqualUnmodifiableListView) return _precipitationProbabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_precipitationProbabilities);
}

 final  List<double> _precipitations;
@override@JsonKey(name: 'precipitation') List<double> get precipitations {
  if (_precipitations is EqualUnmodifiableListView) return _precipitations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_precipitations);
}

 final  List<double> _windSpeeds;
@override@JsonKey(name: 'wind_speed_10m') List<double> get windSpeeds {
  if (_windSpeeds is EqualUnmodifiableListView) return _windSpeeds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_windSpeeds);
}


/// Create a copy of HourlyWeatherDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HourlyWeatherDtoCopyWith<_HourlyWeatherDto> get copyWith => __$HourlyWeatherDtoCopyWithImpl<_HourlyWeatherDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HourlyWeatherDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HourlyWeatherDto&&const DeepCollectionEquality().equals(other._dates, _dates)&&const DeepCollectionEquality().equals(other._weatherCodes, _weatherCodes)&&const DeepCollectionEquality().equals(other._temperatures, _temperatures)&&const DeepCollectionEquality().equals(other._apparentTemperatures, _apparentTemperatures)&&const DeepCollectionEquality().equals(other._precipitationProbabilities, _precipitationProbabilities)&&const DeepCollectionEquality().equals(other._precipitations, _precipitations)&&const DeepCollectionEquality().equals(other._windSpeeds, _windSpeeds));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_dates),const DeepCollectionEquality().hash(_weatherCodes),const DeepCollectionEquality().hash(_temperatures),const DeepCollectionEquality().hash(_apparentTemperatures),const DeepCollectionEquality().hash(_precipitationProbabilities),const DeepCollectionEquality().hash(_precipitations),const DeepCollectionEquality().hash(_windSpeeds));

@override
String toString() {
  return 'HourlyWeatherDto(dates: $dates, weatherCodes: $weatherCodes, temperatures: $temperatures, apparentTemperatures: $apparentTemperatures, precipitationProbabilities: $precipitationProbabilities, precipitations: $precipitations, windSpeeds: $windSpeeds)';
}


}

/// @nodoc
abstract mixin class _$HourlyWeatherDtoCopyWith<$Res> implements $HourlyWeatherDtoCopyWith<$Res> {
  factory _$HourlyWeatherDtoCopyWith(_HourlyWeatherDto value, $Res Function(_HourlyWeatherDto) _then) = __$HourlyWeatherDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'time') List<String> dates,@JsonKey(name: 'weather_code') List<int> weatherCodes,@JsonKey(name: 'temperature_2m') List<double> temperatures,@JsonKey(name: 'apparent_temperature') List<double> apparentTemperatures,@JsonKey(name: 'precipitation_probability') List<int> precipitationProbabilities,@JsonKey(name: 'precipitation') List<double> precipitations,@JsonKey(name: 'wind_speed_10m') List<double> windSpeeds
});




}
/// @nodoc
class __$HourlyWeatherDtoCopyWithImpl<$Res>
    implements _$HourlyWeatherDtoCopyWith<$Res> {
  __$HourlyWeatherDtoCopyWithImpl(this._self, this._then);

  final _HourlyWeatherDto _self;
  final $Res Function(_HourlyWeatherDto) _then;

/// Create a copy of HourlyWeatherDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dates = null,Object? weatherCodes = null,Object? temperatures = null,Object? apparentTemperatures = null,Object? precipitationProbabilities = null,Object? precipitations = null,Object? windSpeeds = null,}) {
  return _then(_HourlyWeatherDto(
dates: null == dates ? _self._dates : dates // ignore: cast_nullable_to_non_nullable
as List<String>,weatherCodes: null == weatherCodes ? _self._weatherCodes : weatherCodes // ignore: cast_nullable_to_non_nullable
as List<int>,temperatures: null == temperatures ? _self._temperatures : temperatures // ignore: cast_nullable_to_non_nullable
as List<double>,apparentTemperatures: null == apparentTemperatures ? _self._apparentTemperatures : apparentTemperatures // ignore: cast_nullable_to_non_nullable
as List<double>,precipitationProbabilities: null == precipitationProbabilities ? _self._precipitationProbabilities : precipitationProbabilities // ignore: cast_nullable_to_non_nullable
as List<int>,precipitations: null == precipitations ? _self._precipitations : precipitations // ignore: cast_nullable_to_non_nullable
as List<double>,windSpeeds: null == windSpeeds ? _self._windSpeeds : windSpeeds // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}

// dart format on
