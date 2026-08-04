// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_forecast_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WeatherForecastDto {

 HourlyWeatherDto get hourly; DailyForecastDto get daily;
/// Create a copy of WeatherForecastDto
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherForecastDtoCopyWith<WeatherForecastDto> get copyWith => _$WeatherForecastDtoCopyWithImpl<WeatherForecastDto>(this as WeatherForecastDto, _$identity);

  /// Serializes this WeatherForecastDto to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherForecastDto&&(identical(other.hourly, hourly) || other.hourly == hourly)&&(identical(other.daily, daily) || other.daily == daily));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hourly,daily);

@override
String toString() {
  return 'WeatherForecastDto(hourly: $hourly, daily: $daily)';
}


}

/// @nodoc
abstract mixin class $WeatherForecastDtoCopyWith<$Res>  {
  factory $WeatherForecastDtoCopyWith(WeatherForecastDto value, $Res Function(WeatherForecastDto) _then) = _$WeatherForecastDtoCopyWithImpl;
@useResult
$Res call({
 HourlyWeatherDto hourly, DailyForecastDto daily
});


$HourlyWeatherDtoCopyWith<$Res> get hourly;$DailyForecastDtoCopyWith<$Res> get daily;

}
/// @nodoc
class _$WeatherForecastDtoCopyWithImpl<$Res>
    implements $WeatherForecastDtoCopyWith<$Res> {
  _$WeatherForecastDtoCopyWithImpl(this._self, this._then);

  final WeatherForecastDto _self;
  final $Res Function(WeatherForecastDto) _then;

/// Create a copy of WeatherForecastDto
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hourly = null,Object? daily = null,}) {
  return _then(_self.copyWith(
hourly: null == hourly ? _self.hourly : hourly // ignore: cast_nullable_to_non_nullable
as HourlyWeatherDto,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as DailyForecastDto,
  ));
}
/// Create a copy of WeatherForecastDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HourlyWeatherDtoCopyWith<$Res> get hourly {
  
  return $HourlyWeatherDtoCopyWith<$Res>(_self.hourly, (value) {
    return _then(_self.copyWith(hourly: value));
  });
}/// Create a copy of WeatherForecastDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DailyForecastDtoCopyWith<$Res> get daily {
  
  return $DailyForecastDtoCopyWith<$Res>(_self.daily, (value) {
    return _then(_self.copyWith(daily: value));
  });
}
}


/// Adds pattern-matching-related methods to [WeatherForecastDto].
extension WeatherForecastDtoPatterns on WeatherForecastDto {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherForecastDto value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherForecastDto() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherForecastDto value)  $default,){
final _that = this;
switch (_that) {
case _WeatherForecastDto():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherForecastDto value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherForecastDto() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( HourlyWeatherDto hourly,  DailyForecastDto daily)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherForecastDto() when $default != null:
return $default(_that.hourly,_that.daily);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( HourlyWeatherDto hourly,  DailyForecastDto daily)  $default,) {final _that = this;
switch (_that) {
case _WeatherForecastDto():
return $default(_that.hourly,_that.daily);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( HourlyWeatherDto hourly,  DailyForecastDto daily)?  $default,) {final _that = this;
switch (_that) {
case _WeatherForecastDto() when $default != null:
return $default(_that.hourly,_that.daily);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WeatherForecastDto extends WeatherForecastDto {
  const _WeatherForecastDto({required this.hourly, required this.daily}): super._();
  factory _WeatherForecastDto.fromJson(Map<String, dynamic> json) => _$WeatherForecastDtoFromJson(json);

@override final  HourlyWeatherDto hourly;
@override final  DailyForecastDto daily;

/// Create a copy of WeatherForecastDto
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherForecastDtoCopyWith<_WeatherForecastDto> get copyWith => __$WeatherForecastDtoCopyWithImpl<_WeatherForecastDto>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeatherForecastDtoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherForecastDto&&(identical(other.hourly, hourly) || other.hourly == hourly)&&(identical(other.daily, daily) || other.daily == daily));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hourly,daily);

@override
String toString() {
  return 'WeatherForecastDto(hourly: $hourly, daily: $daily)';
}


}

/// @nodoc
abstract mixin class _$WeatherForecastDtoCopyWith<$Res> implements $WeatherForecastDtoCopyWith<$Res> {
  factory _$WeatherForecastDtoCopyWith(_WeatherForecastDto value, $Res Function(_WeatherForecastDto) _then) = __$WeatherForecastDtoCopyWithImpl;
@override @useResult
$Res call({
 HourlyWeatherDto hourly, DailyForecastDto daily
});


@override $HourlyWeatherDtoCopyWith<$Res> get hourly;@override $DailyForecastDtoCopyWith<$Res> get daily;

}
/// @nodoc
class __$WeatherForecastDtoCopyWithImpl<$Res>
    implements _$WeatherForecastDtoCopyWith<$Res> {
  __$WeatherForecastDtoCopyWithImpl(this._self, this._then);

  final _WeatherForecastDto _self;
  final $Res Function(_WeatherForecastDto) _then;

/// Create a copy of WeatherForecastDto
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hourly = null,Object? daily = null,}) {
  return _then(_WeatherForecastDto(
hourly: null == hourly ? _self.hourly : hourly // ignore: cast_nullable_to_non_nullable
as HourlyWeatherDto,daily: null == daily ? _self.daily : daily // ignore: cast_nullable_to_non_nullable
as DailyForecastDto,
  ));
}

/// Create a copy of WeatherForecastDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$HourlyWeatherDtoCopyWith<$Res> get hourly {
  
  return $HourlyWeatherDtoCopyWith<$Res>(_self.hourly, (value) {
    return _then(_self.copyWith(hourly: value));
  });
}/// Create a copy of WeatherForecastDto
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DailyForecastDtoCopyWith<$Res> get daily {
  
  return $DailyForecastDtoCopyWith<$Res>(_self.daily, (value) {
    return _then(_self.copyWith(daily: value));
  });
}
}

// dart format on
