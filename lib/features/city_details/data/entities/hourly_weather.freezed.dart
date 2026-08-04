// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'hourly_weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$HourlyWeather {

 DateTime get dateTime; int get weatherCode; double get temperature; double get apparentTemperature; int get precipitationProbability; double get precipitation; double get windSpeed;
/// Create a copy of HourlyWeather
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HourlyWeatherCopyWith<HourlyWeather> get copyWith => _$HourlyWeatherCopyWithImpl<HourlyWeather>(this as HourlyWeather, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HourlyWeather&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.apparentTemperature, apparentTemperature) || other.apparentTemperature == apparentTemperature)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed));
}


@override
int get hashCode => Object.hash(runtimeType,dateTime,weatherCode,temperature,apparentTemperature,precipitationProbability,precipitation,windSpeed);

@override
String toString() {
  return 'HourlyWeather(dateTime: $dateTime, weatherCode: $weatherCode, temperature: $temperature, apparentTemperature: $apparentTemperature, precipitationProbability: $precipitationProbability, precipitation: $precipitation, windSpeed: $windSpeed)';
}


}

/// @nodoc
abstract mixin class $HourlyWeatherCopyWith<$Res>  {
  factory $HourlyWeatherCopyWith(HourlyWeather value, $Res Function(HourlyWeather) _then) = _$HourlyWeatherCopyWithImpl;
@useResult
$Res call({
 DateTime dateTime, int weatherCode, double temperature, double apparentTemperature, int precipitationProbability, double precipitation, double windSpeed
});




}
/// @nodoc
class _$HourlyWeatherCopyWithImpl<$Res>
    implements $HourlyWeatherCopyWith<$Res> {
  _$HourlyWeatherCopyWithImpl(this._self, this._then);

  final HourlyWeather _self;
  final $Res Function(HourlyWeather) _then;

/// Create a copy of HourlyWeather
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dateTime = null,Object? weatherCode = null,Object? temperature = null,Object? apparentTemperature = null,Object? precipitationProbability = null,Object? precipitation = null,Object? windSpeed = null,}) {
  return _then(_self.copyWith(
dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,apparentTemperature: null == apparentTemperature ? _self.apparentTemperature : apparentTemperature // ignore: cast_nullable_to_non_nullable
as double,precipitationProbability: null == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as int,precipitation: null == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [HourlyWeather].
extension HourlyWeatherPatterns on HourlyWeather {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HourlyWeather value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HourlyWeather() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HourlyWeather value)  $default,){
final _that = this;
switch (_that) {
case _HourlyWeather():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HourlyWeather value)?  $default,){
final _that = this;
switch (_that) {
case _HourlyWeather() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime dateTime,  int weatherCode,  double temperature,  double apparentTemperature,  int precipitationProbability,  double precipitation,  double windSpeed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HourlyWeather() when $default != null:
return $default(_that.dateTime,_that.weatherCode,_that.temperature,_that.apparentTemperature,_that.precipitationProbability,_that.precipitation,_that.windSpeed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime dateTime,  int weatherCode,  double temperature,  double apparentTemperature,  int precipitationProbability,  double precipitation,  double windSpeed)  $default,) {final _that = this;
switch (_that) {
case _HourlyWeather():
return $default(_that.dateTime,_that.weatherCode,_that.temperature,_that.apparentTemperature,_that.precipitationProbability,_that.precipitation,_that.windSpeed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime dateTime,  int weatherCode,  double temperature,  double apparentTemperature,  int precipitationProbability,  double precipitation,  double windSpeed)?  $default,) {final _that = this;
switch (_that) {
case _HourlyWeather() when $default != null:
return $default(_that.dateTime,_that.weatherCode,_that.temperature,_that.apparentTemperature,_that.precipitationProbability,_that.precipitation,_that.windSpeed);case _:
  return null;

}
}

}

/// @nodoc


class _HourlyWeather implements HourlyWeather {
  const _HourlyWeather({required this.dateTime, required this.weatherCode, required this.temperature, required this.apparentTemperature, required this.precipitationProbability, required this.precipitation, required this.windSpeed});
  

@override final  DateTime dateTime;
@override final  int weatherCode;
@override final  double temperature;
@override final  double apparentTemperature;
@override final  int precipitationProbability;
@override final  double precipitation;
@override final  double windSpeed;

/// Create a copy of HourlyWeather
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HourlyWeatherCopyWith<_HourlyWeather> get copyWith => __$HourlyWeatherCopyWithImpl<_HourlyWeather>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HourlyWeather&&(identical(other.dateTime, dateTime) || other.dateTime == dateTime)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.temperature, temperature) || other.temperature == temperature)&&(identical(other.apparentTemperature, apparentTemperature) || other.apparentTemperature == apparentTemperature)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.windSpeed, windSpeed) || other.windSpeed == windSpeed));
}


@override
int get hashCode => Object.hash(runtimeType,dateTime,weatherCode,temperature,apparentTemperature,precipitationProbability,precipitation,windSpeed);

@override
String toString() {
  return 'HourlyWeather(dateTime: $dateTime, weatherCode: $weatherCode, temperature: $temperature, apparentTemperature: $apparentTemperature, precipitationProbability: $precipitationProbability, precipitation: $precipitation, windSpeed: $windSpeed)';
}


}

/// @nodoc
abstract mixin class _$HourlyWeatherCopyWith<$Res> implements $HourlyWeatherCopyWith<$Res> {
  factory _$HourlyWeatherCopyWith(_HourlyWeather value, $Res Function(_HourlyWeather) _then) = __$HourlyWeatherCopyWithImpl;
@override @useResult
$Res call({
 DateTime dateTime, int weatherCode, double temperature, double apparentTemperature, int precipitationProbability, double precipitation, double windSpeed
});




}
/// @nodoc
class __$HourlyWeatherCopyWithImpl<$Res>
    implements _$HourlyWeatherCopyWith<$Res> {
  __$HourlyWeatherCopyWithImpl(this._self, this._then);

  final _HourlyWeather _self;
  final $Res Function(_HourlyWeather) _then;

/// Create a copy of HourlyWeather
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dateTime = null,Object? weatherCode = null,Object? temperature = null,Object? apparentTemperature = null,Object? precipitationProbability = null,Object? precipitation = null,Object? windSpeed = null,}) {
  return _then(_HourlyWeather(
dateTime: null == dateTime ? _self.dateTime : dateTime // ignore: cast_nullable_to_non_nullable
as DateTime,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int,temperature: null == temperature ? _self.temperature : temperature // ignore: cast_nullable_to_non_nullable
as double,apparentTemperature: null == apparentTemperature ? _self.apparentTemperature : apparentTemperature // ignore: cast_nullable_to_non_nullable
as double,precipitationProbability: null == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as int,precipitation: null == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double,windSpeed: null == windSpeed ? _self.windSpeed : windSpeed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
