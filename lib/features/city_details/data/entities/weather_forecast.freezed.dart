// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_forecast.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$WeatherForecast {

 List<HourlyWeather> get hours; List<DailyWeather> get days;
/// Create a copy of WeatherForecast
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeatherForecastCopyWith<WeatherForecast> get copyWith => _$WeatherForecastCopyWithImpl<WeatherForecast>(this as WeatherForecast, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeatherForecast&&const DeepCollectionEquality().equals(other.hours, hours)&&const DeepCollectionEquality().equals(other.days, days));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(hours),const DeepCollectionEquality().hash(days));

@override
String toString() {
  return 'WeatherForecast(hours: $hours, days: $days)';
}


}

/// @nodoc
abstract mixin class $WeatherForecastCopyWith<$Res>  {
  factory $WeatherForecastCopyWith(WeatherForecast value, $Res Function(WeatherForecast) _then) = _$WeatherForecastCopyWithImpl;
@useResult
$Res call({
 List<HourlyWeather> hours, List<DailyWeather> days
});




}
/// @nodoc
class _$WeatherForecastCopyWithImpl<$Res>
    implements $WeatherForecastCopyWith<$Res> {
  _$WeatherForecastCopyWithImpl(this._self, this._then);

  final WeatherForecast _self;
  final $Res Function(WeatherForecast) _then;

/// Create a copy of WeatherForecast
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hours = null,Object? days = null,}) {
  return _then(_self.copyWith(
hours: null == hours ? _self.hours : hours // ignore: cast_nullable_to_non_nullable
as List<HourlyWeather>,days: null == days ? _self.days : days // ignore: cast_nullable_to_non_nullable
as List<DailyWeather>,
  ));
}

}


/// Adds pattern-matching-related methods to [WeatherForecast].
extension WeatherForecastPatterns on WeatherForecast {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WeatherForecast value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WeatherForecast() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WeatherForecast value)  $default,){
final _that = this;
switch (_that) {
case _WeatherForecast():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WeatherForecast value)?  $default,){
final _that = this;
switch (_that) {
case _WeatherForecast() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<HourlyWeather> hours,  List<DailyWeather> days)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WeatherForecast() when $default != null:
return $default(_that.hours,_that.days);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<HourlyWeather> hours,  List<DailyWeather> days)  $default,) {final _that = this;
switch (_that) {
case _WeatherForecast():
return $default(_that.hours,_that.days);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<HourlyWeather> hours,  List<DailyWeather> days)?  $default,) {final _that = this;
switch (_that) {
case _WeatherForecast() when $default != null:
return $default(_that.hours,_that.days);case _:
  return null;

}
}

}

/// @nodoc


class _WeatherForecast implements WeatherForecast {
  const _WeatherForecast({required final  List<HourlyWeather> hours, required final  List<DailyWeather> days}): _hours = hours,_days = days;
  

 final  List<HourlyWeather> _hours;
@override List<HourlyWeather> get hours {
  if (_hours is EqualUnmodifiableListView) return _hours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hours);
}

 final  List<DailyWeather> _days;
@override List<DailyWeather> get days {
  if (_days is EqualUnmodifiableListView) return _days;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_days);
}


/// Create a copy of WeatherForecast
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeatherForecastCopyWith<_WeatherForecast> get copyWith => __$WeatherForecastCopyWithImpl<_WeatherForecast>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeatherForecast&&const DeepCollectionEquality().equals(other._hours, _hours)&&const DeepCollectionEquality().equals(other._days, _days));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_hours),const DeepCollectionEquality().hash(_days));

@override
String toString() {
  return 'WeatherForecast(hours: $hours, days: $days)';
}


}

/// @nodoc
abstract mixin class _$WeatherForecastCopyWith<$Res> implements $WeatherForecastCopyWith<$Res> {
  factory _$WeatherForecastCopyWith(_WeatherForecast value, $Res Function(_WeatherForecast) _then) = __$WeatherForecastCopyWithImpl;
@override @useResult
$Res call({
 List<HourlyWeather> hours, List<DailyWeather> days
});




}
/// @nodoc
class __$WeatherForecastCopyWithImpl<$Res>
    implements _$WeatherForecastCopyWith<$Res> {
  __$WeatherForecastCopyWithImpl(this._self, this._then);

  final _WeatherForecast _self;
  final $Res Function(_WeatherForecast) _then;

/// Create a copy of WeatherForecast
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hours = null,Object? days = null,}) {
  return _then(_WeatherForecast(
hours: null == hours ? _self._hours : hours // ignore: cast_nullable_to_non_nullable
as List<HourlyWeather>,days: null == days ? _self._days : days // ignore: cast_nullable_to_non_nullable
as List<DailyWeather>,
  ));
}


}

// dart format on
