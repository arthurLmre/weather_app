import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/city_details/ui/page/components/weather_conditions.dart';

void main() {
  group('WeatherCondition.category', () {
    final cases = <int, WeatherCategory>{
      0: WeatherCategory.clear,
      1: WeatherCategory.partlyCloudy,
      2: WeatherCategory.partlyCloudy,
      3: WeatherCategory.cloudy,
      45: WeatherCategory.fog,
      48: WeatherCategory.fog,
      51: WeatherCategory.drizzle,
      57: WeatherCategory.drizzle,
      61: WeatherCategory.rain,
      67: WeatherCategory.rain,
      71: WeatherCategory.snow,
      77: WeatherCategory.snow,
      80: WeatherCategory.showers,
      82: WeatherCategory.showers,
      85: WeatherCategory.snowShowers,
      86: WeatherCategory.snowShowers,
      95: WeatherCategory.thunderstorm,
      99: WeatherCategory.thunderstorm,
      -1: WeatherCategory.unknown,
      4: WeatherCategory.unknown,
      100: WeatherCategory.unknown,
    };

    for (final entry in cases.entries) {
      test('returns ${entry.value.name} for code ${entry.key}', () {
        expect(WeatherCondition.category(entry.key), entry.value);
      });
    }
  });

  group('WeatherCondition.label', () {
    test('returns the corresponding French label', () {
      expect(WeatherCondition.label(0), 'Ciel dégagé');
      expect(WeatherCondition.label(63), 'Pluie');
      expect(WeatherCondition.label(95), 'Orage');
      expect(WeatherCondition.label(100), 'Conditions variables');
    });
  });

  group('WeatherCondition.icon', () {
    test('returns the corresponding icon', () {
      expect(WeatherCondition.icon(0), Icons.wb_sunny_outlined);
      expect(WeatherCondition.icon(63), Icons.water_drop_outlined);
      expect(WeatherCondition.icon(85), Icons.ac_unit);
      expect(WeatherCondition.icon(100), Icons.cloud_outlined);
    });
  });
}
