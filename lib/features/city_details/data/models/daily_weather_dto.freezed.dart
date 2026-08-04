// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_weather_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DailyForecastDto {

@JsonKey(name: 'time') List<String> get dates;@JsonKey(name: 'weather_code') List<int> get weatherCodes;@JsonKey(name: 'temperature_2m_min') List<double> get minTemperatures;@JsonKey(name: 'temperature_2m_max') List<double> get maxTemperatures;@JsonKey(name: 'precipitation_probability_max') List<int> get precipitationProbabilities;@JsonKey(name: 'wind_speed_10m_max') List<double> get maxWindSpeeds;@JsonKey(name: 'precipitation_sum') List<double> get precipitations;
/// Create a copy of DailyForecastDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyForecastDtoCopyWith<DailyForecastDto> get copyWith => _$DailyForecastDtoCopyWithImpl<DailyForecastDto>(this as DailyForecastDto, _$identity);

  /// Serializes this DailyForecastDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyForecastDto&&const DeepCollectionEquality().equals(other.dates, dates)&&const DeepCollectionEquality().equals(other.weatherCodes, weatherCodes)&&const DeepCollectionEquality().equals(other.minTemperatures, minTemperatures)&&const DeepCollectionEquality().equals(other.maxTemperatures, maxTemperatures)&&const DeepCollectionEquality().equals(other.precipitationProbabilities, precipitationProbabilities)&&const DeepCollectionEquality().equals(other.maxWindSpeeds, maxWindSpeeds)&&const DeepCollectionEquality().equals(other.precipitations, precipitations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(dates),const DeepCollectionEquality().hash(weatherCodes),const DeepCollectionEquality().hash(minTemperatures),const DeepCollectionEquality().hash(maxTemperatures),const DeepCollectionEquality().hash(precipitationProbabilities),const DeepCollectionEquality().hash(maxWindSpeeds),const DeepCollectionEquality().hash(precipitations));

@override
String toString() {
  return 'DailyForecastDto(dates: $dates, weatherCodes: $weatherCodes, minTemperatures: $minTemperatures, maxTemperatures: $maxTemperatures, precipitationProbabilities: $precipitationProbabilities, maxWindSpeeds: $maxWindSpeeds, precipitations: $precipitations)';
}


}

/// @nodoc
abstract mixin class $DailyForecastDtoCopyWith<$Res>  {
  factory $DailyForecastDtoCopyWith(DailyForecastDto value, $Res Function(DailyForecastDto) _then) = _$DailyForecastDtoCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'time') List<String> dates,@JsonKey(name: 'weather_code') List<int> weatherCodes,@JsonKey(name: 'temperature_2m_min') List<double> minTemperatures,@JsonKey(name: 'temperature_2m_max') List<double> maxTemperatures,@JsonKey(name: 'precipitation_probability_max') List<int> precipitationProbabilities,@JsonKey(name: 'wind_speed_10m_max') List<double> maxWindSpeeds,@JsonKey(name: 'precipitation_sum') List<double> precipitations
});




}
/// @nodoc
class _$DailyForecastDtoCopyWithImpl<$Res>
    implements $DailyForecastDtoCopyWith<$Res> {
  _$DailyForecastDtoCopyWithImpl(this._self, this._then);

  final DailyForecastDto _self;
  final $Res Function(DailyForecastDto) _then;

/// Create a copy of DailyForecastDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dates = null,Object? weatherCodes = null,Object? minTemperatures = null,Object? maxTemperatures = null,Object? precipitationProbabilities = null,Object? maxWindSpeeds = null,Object? precipitations = null,}) {
  return _then(_self.copyWith(
dates: null == dates ? _self.dates : dates // ignore: cast_nullable_to_non_nullable
as List<String>,weatherCodes: null == weatherCodes ? _self.weatherCodes : weatherCodes // ignore: cast_nullable_to_non_nullable
as List<int>,minTemperatures: null == minTemperatures ? _self.minTemperatures : minTemperatures // ignore: cast_nullable_to_non_nullable
as List<double>,maxTemperatures: null == maxTemperatures ? _self.maxTemperatures : maxTemperatures // ignore: cast_nullable_to_non_nullable
as List<double>,precipitationProbabilities: null == precipitationProbabilities ? _self.precipitationProbabilities : precipitationProbabilities // ignore: cast_nullable_to_non_nullable
as List<int>,maxWindSpeeds: null == maxWindSpeeds ? _self.maxWindSpeeds : maxWindSpeeds // ignore: cast_nullable_to_non_nullable
as List<double>,precipitations: null == precipitations ? _self.precipitations : precipitations // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyForecastDto].
extension DailyForecastDtoPatterns on DailyForecastDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyForecastDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyForecastDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyForecastDto value)  $default,){
final _that = this;
switch (_that) {
case _DailyForecastDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyForecastDto value)?  $default,){
final _that = this;
switch (_that) {
case _DailyForecastDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'time')  List<String> dates, @JsonKey(name: 'weather_code')  List<int> weatherCodes, @JsonKey(name: 'temperature_2m_min')  List<double> minTemperatures, @JsonKey(name: 'temperature_2m_max')  List<double> maxTemperatures, @JsonKey(name: 'precipitation_probability_max')  List<int> precipitationProbabilities, @JsonKey(name: 'wind_speed_10m_max')  List<double> maxWindSpeeds, @JsonKey(name: 'precipitation_sum')  List<double> precipitations)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyForecastDto() when $default != null:
return $default(_that.dates,_that.weatherCodes,_that.minTemperatures,_that.maxTemperatures,_that.precipitationProbabilities,_that.maxWindSpeeds,_that.precipitations);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'time')  List<String> dates, @JsonKey(name: 'weather_code')  List<int> weatherCodes, @JsonKey(name: 'temperature_2m_min')  List<double> minTemperatures, @JsonKey(name: 'temperature_2m_max')  List<double> maxTemperatures, @JsonKey(name: 'precipitation_probability_max')  List<int> precipitationProbabilities, @JsonKey(name: 'wind_speed_10m_max')  List<double> maxWindSpeeds, @JsonKey(name: 'precipitation_sum')  List<double> precipitations)  $default,) {final _that = this;
switch (_that) {
case _DailyForecastDto():
return $default(_that.dates,_that.weatherCodes,_that.minTemperatures,_that.maxTemperatures,_that.precipitationProbabilities,_that.maxWindSpeeds,_that.precipitations);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'time')  List<String> dates, @JsonKey(name: 'weather_code')  List<int> weatherCodes, @JsonKey(name: 'temperature_2m_min')  List<double> minTemperatures, @JsonKey(name: 'temperature_2m_max')  List<double> maxTemperatures, @JsonKey(name: 'precipitation_probability_max')  List<int> precipitationProbabilities, @JsonKey(name: 'wind_speed_10m_max')  List<double> maxWindSpeeds, @JsonKey(name: 'precipitation_sum')  List<double> precipitations)?  $default,) {final _that = this;
switch (_that) {
case _DailyForecastDto() when $default != null:
return $default(_that.dates,_that.weatherCodes,_that.minTemperatures,_that.maxTemperatures,_that.precipitationProbabilities,_that.maxWindSpeeds,_that.precipitations);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _DailyForecastDto extends DailyForecastDto {
  const _DailyForecastDto({@JsonKey(name: 'time') required final  List<String> dates, @JsonKey(name: 'weather_code') required final  List<int> weatherCodes, @JsonKey(name: 'temperature_2m_min') required final  List<double> minTemperatures, @JsonKey(name: 'temperature_2m_max') required final  List<double> maxTemperatures, @JsonKey(name: 'precipitation_probability_max') required final  List<int> precipitationProbabilities, @JsonKey(name: 'wind_speed_10m_max') required final  List<double> maxWindSpeeds, @JsonKey(name: 'precipitation_sum') required final  List<double> precipitations}): _dates = dates,_weatherCodes = weatherCodes,_minTemperatures = minTemperatures,_maxTemperatures = maxTemperatures,_precipitationProbabilities = precipitationProbabilities,_maxWindSpeeds = maxWindSpeeds,_precipitations = precipitations,super._();
  factory _DailyForecastDto.fromJson(Map<String, dynamic> json) => _$DailyForecastDtoFromJson(json);

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

 final  List<double> _minTemperatures;
@override@JsonKey(name: 'temperature_2m_min') List<double> get minTemperatures {
  if (_minTemperatures is EqualUnmodifiableListView) return _minTemperatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_minTemperatures);
}

 final  List<double> _maxTemperatures;
@override@JsonKey(name: 'temperature_2m_max') List<double> get maxTemperatures {
  if (_maxTemperatures is EqualUnmodifiableListView) return _maxTemperatures;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_maxTemperatures);
}

 final  List<int> _precipitationProbabilities;
@override@JsonKey(name: 'precipitation_probability_max') List<int> get precipitationProbabilities {
  if (_precipitationProbabilities is EqualUnmodifiableListView) return _precipitationProbabilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_precipitationProbabilities);
}

 final  List<double> _maxWindSpeeds;
@override@JsonKey(name: 'wind_speed_10m_max') List<double> get maxWindSpeeds {
  if (_maxWindSpeeds is EqualUnmodifiableListView) return _maxWindSpeeds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_maxWindSpeeds);
}

 final  List<double> _precipitations;
@override@JsonKey(name: 'precipitation_sum') List<double> get precipitations {
  if (_precipitations is EqualUnmodifiableListView) return _precipitations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_precipitations);
}


/// Create a copy of DailyForecastDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyForecastDtoCopyWith<_DailyForecastDto> get copyWith => __$DailyForecastDtoCopyWithImpl<_DailyForecastDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyForecastDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyForecastDto&&const DeepCollectionEquality().equals(other._dates, _dates)&&const DeepCollectionEquality().equals(other._weatherCodes, _weatherCodes)&&const DeepCollectionEquality().equals(other._minTemperatures, _minTemperatures)&&const DeepCollectionEquality().equals(other._maxTemperatures, _maxTemperatures)&&const DeepCollectionEquality().equals(other._precipitationProbabilities, _precipitationProbabilities)&&const DeepCollectionEquality().equals(other._maxWindSpeeds, _maxWindSpeeds)&&const DeepCollectionEquality().equals(other._precipitations, _precipitations));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_dates),const DeepCollectionEquality().hash(_weatherCodes),const DeepCollectionEquality().hash(_minTemperatures),const DeepCollectionEquality().hash(_maxTemperatures),const DeepCollectionEquality().hash(_precipitationProbabilities),const DeepCollectionEquality().hash(_maxWindSpeeds),const DeepCollectionEquality().hash(_precipitations));

@override
String toString() {
  return 'DailyForecastDto(dates: $dates, weatherCodes: $weatherCodes, minTemperatures: $minTemperatures, maxTemperatures: $maxTemperatures, precipitationProbabilities: $precipitationProbabilities, maxWindSpeeds: $maxWindSpeeds, precipitations: $precipitations)';
}


}

/// @nodoc
abstract mixin class _$DailyForecastDtoCopyWith<$Res> implements $DailyForecastDtoCopyWith<$Res> {
  factory _$DailyForecastDtoCopyWith(_DailyForecastDto value, $Res Function(_DailyForecastDto) _then) = __$DailyForecastDtoCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'time') List<String> dates,@JsonKey(name: 'weather_code') List<int> weatherCodes,@JsonKey(name: 'temperature_2m_min') List<double> minTemperatures,@JsonKey(name: 'temperature_2m_max') List<double> maxTemperatures,@JsonKey(name: 'precipitation_probability_max') List<int> precipitationProbabilities,@JsonKey(name: 'wind_speed_10m_max') List<double> maxWindSpeeds,@JsonKey(name: 'precipitation_sum') List<double> precipitations
});




}
/// @nodoc
class __$DailyForecastDtoCopyWithImpl<$Res>
    implements _$DailyForecastDtoCopyWith<$Res> {
  __$DailyForecastDtoCopyWithImpl(this._self, this._then);

  final _DailyForecastDto _self;
  final $Res Function(_DailyForecastDto) _then;

/// Create a copy of DailyForecastDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dates = null,Object? weatherCodes = null,Object? minTemperatures = null,Object? maxTemperatures = null,Object? precipitationProbabilities = null,Object? maxWindSpeeds = null,Object? precipitations = null,}) {
  return _then(_DailyForecastDto(
dates: null == dates ? _self._dates : dates // ignore: cast_nullable_to_non_nullable
as List<String>,weatherCodes: null == weatherCodes ? _self._weatherCodes : weatherCodes // ignore: cast_nullable_to_non_nullable
as List<int>,minTemperatures: null == minTemperatures ? _self._minTemperatures : minTemperatures // ignore: cast_nullable_to_non_nullable
as List<double>,maxTemperatures: null == maxTemperatures ? _self._maxTemperatures : maxTemperatures // ignore: cast_nullable_to_non_nullable
as List<double>,precipitationProbabilities: null == precipitationProbabilities ? _self._precipitationProbabilities : precipitationProbabilities // ignore: cast_nullable_to_non_nullable
as List<int>,maxWindSpeeds: null == maxWindSpeeds ? _self._maxWindSpeeds : maxWindSpeeds // ignore: cast_nullable_to_non_nullable
as List<double>,precipitations: null == precipitations ? _self._precipitations : precipitations // ignore: cast_nullable_to_non_nullable
as List<double>,
  ));
}


}

// dart format on
