// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'daily_weather.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$DailyWeather {

 DateTime get date; int get weatherCode; double get minTemperature; double get maxTemperature; int get precipitationProbability; double get precipitation; double get maxWindSpeed;
/// Create a copy of DailyWeather
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyWeatherCopyWith<DailyWeather> get copyWith => _$DailyWeatherCopyWithImpl<DailyWeather>(this as DailyWeather, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyWeather&&(identical(other.date, date) || other.date == date)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.minTemperature, minTemperature) || other.minTemperature == minTemperature)&&(identical(other.maxTemperature, maxTemperature) || other.maxTemperature == maxTemperature)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.maxWindSpeed, maxWindSpeed) || other.maxWindSpeed == maxWindSpeed));
}


@override
int get hashCode => Object.hash(runtimeType,date,weatherCode,minTemperature,maxTemperature,precipitationProbability,precipitation,maxWindSpeed);

@override
String toString() {
  return 'DailyWeather(date: $date, weatherCode: $weatherCode, minTemperature: $minTemperature, maxTemperature: $maxTemperature, precipitationProbability: $precipitationProbability, precipitation: $precipitation, maxWindSpeed: $maxWindSpeed)';
}


}

/// @nodoc
abstract mixin class $DailyWeatherCopyWith<$Res>  {
  factory $DailyWeatherCopyWith(DailyWeather value, $Res Function(DailyWeather) _then) = _$DailyWeatherCopyWithImpl;
@useResult
$Res call({
 DateTime date, int weatherCode, double minTemperature, double maxTemperature, int precipitationProbability, double precipitation, double maxWindSpeed
});




}
/// @nodoc
class _$DailyWeatherCopyWithImpl<$Res>
    implements $DailyWeatherCopyWith<$Res> {
  _$DailyWeatherCopyWithImpl(this._self, this._then);

  final DailyWeather _self;
  final $Res Function(DailyWeather) _then;

/// Create a copy of DailyWeather
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? weatherCode = null,Object? minTemperature = null,Object? maxTemperature = null,Object? precipitationProbability = null,Object? precipitation = null,Object? maxWindSpeed = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int,minTemperature: null == minTemperature ? _self.minTemperature : minTemperature // ignore: cast_nullable_to_non_nullable
as double,maxTemperature: null == maxTemperature ? _self.maxTemperature : maxTemperature // ignore: cast_nullable_to_non_nullable
as double,precipitationProbability: null == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as int,precipitation: null == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double,maxWindSpeed: null == maxWindSpeed ? _self.maxWindSpeed : maxWindSpeed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// Adds pattern-matching-related methods to [DailyWeather].
extension DailyWeatherPatterns on DailyWeather {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _DailyWeather value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _DailyWeather() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _DailyWeather value)  $default,){
final _that = this;
switch (_that) {
case _DailyWeather():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _DailyWeather value)?  $default,){
final _that = this;
switch (_that) {
case _DailyWeather() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( DateTime date,  int weatherCode,  double minTemperature,  double maxTemperature,  int precipitationProbability,  double precipitation,  double maxWindSpeed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _DailyWeather() when $default != null:
return $default(_that.date,_that.weatherCode,_that.minTemperature,_that.maxTemperature,_that.precipitationProbability,_that.precipitation,_that.maxWindSpeed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( DateTime date,  int weatherCode,  double minTemperature,  double maxTemperature,  int precipitationProbability,  double precipitation,  double maxWindSpeed)  $default,) {final _that = this;
switch (_that) {
case _DailyWeather():
return $default(_that.date,_that.weatherCode,_that.minTemperature,_that.maxTemperature,_that.precipitationProbability,_that.precipitation,_that.maxWindSpeed);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( DateTime date,  int weatherCode,  double minTemperature,  double maxTemperature,  int precipitationProbability,  double precipitation,  double maxWindSpeed)?  $default,) {final _that = this;
switch (_that) {
case _DailyWeather() when $default != null:
return $default(_that.date,_that.weatherCode,_that.minTemperature,_that.maxTemperature,_that.precipitationProbability,_that.precipitation,_that.maxWindSpeed);case _:
  return null;

}
}

}

/// @nodoc


class _DailyWeather implements DailyWeather {
  const _DailyWeather({required this.date, required this.weatherCode, required this.minTemperature, required this.maxTemperature, required this.precipitationProbability, required this.precipitation, required this.maxWindSpeed});
  

@override final  DateTime date;
@override final  int weatherCode;
@override final  double minTemperature;
@override final  double maxTemperature;
@override final  int precipitationProbability;
@override final  double precipitation;
@override final  double maxWindSpeed;

/// Create a copy of DailyWeather
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyWeatherCopyWith<_DailyWeather> get copyWith => __$DailyWeatherCopyWithImpl<_DailyWeather>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyWeather&&(identical(other.date, date) || other.date == date)&&(identical(other.weatherCode, weatherCode) || other.weatherCode == weatherCode)&&(identical(other.minTemperature, minTemperature) || other.minTemperature == minTemperature)&&(identical(other.maxTemperature, maxTemperature) || other.maxTemperature == maxTemperature)&&(identical(other.precipitationProbability, precipitationProbability) || other.precipitationProbability == precipitationProbability)&&(identical(other.precipitation, precipitation) || other.precipitation == precipitation)&&(identical(other.maxWindSpeed, maxWindSpeed) || other.maxWindSpeed == maxWindSpeed));
}


@override
int get hashCode => Object.hash(runtimeType,date,weatherCode,minTemperature,maxTemperature,precipitationProbability,precipitation,maxWindSpeed);

@override
String toString() {
  return 'DailyWeather(date: $date, weatherCode: $weatherCode, minTemperature: $minTemperature, maxTemperature: $maxTemperature, precipitationProbability: $precipitationProbability, precipitation: $precipitation, maxWindSpeed: $maxWindSpeed)';
}


}

/// @nodoc
abstract mixin class _$DailyWeatherCopyWith<$Res> implements $DailyWeatherCopyWith<$Res> {
  factory _$DailyWeatherCopyWith(_DailyWeather value, $Res Function(_DailyWeather) _then) = __$DailyWeatherCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int weatherCode, double minTemperature, double maxTemperature, int precipitationProbability, double precipitation, double maxWindSpeed
});




}
/// @nodoc
class __$DailyWeatherCopyWithImpl<$Res>
    implements _$DailyWeatherCopyWith<$Res> {
  __$DailyWeatherCopyWithImpl(this._self, this._then);

  final _DailyWeather _self;
  final $Res Function(_DailyWeather) _then;

/// Create a copy of DailyWeather
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? weatherCode = null,Object? minTemperature = null,Object? maxTemperature = null,Object? precipitationProbability = null,Object? precipitation = null,Object? maxWindSpeed = null,}) {
  return _then(_DailyWeather(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,weatherCode: null == weatherCode ? _self.weatherCode : weatherCode // ignore: cast_nullable_to_non_nullable
as int,minTemperature: null == minTemperature ? _self.minTemperature : minTemperature // ignore: cast_nullable_to_non_nullable
as double,maxTemperature: null == maxTemperature ? _self.maxTemperature : maxTemperature // ignore: cast_nullable_to_non_nullable
as double,precipitationProbability: null == precipitationProbability ? _self.precipitationProbability : precipitationProbability // ignore: cast_nullable_to_non_nullable
as int,precipitation: null == precipitation ? _self.precipitation : precipitation // ignore: cast_nullable_to_non_nullable
as double,maxWindSpeed: null == maxWindSpeed ? _self.maxWindSpeed : maxWindSpeed // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}

// dart format on
