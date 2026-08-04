import 'package:flutter/material.dart';

enum WeatherCategory {
  clear,
  partlyCloudy,
  cloudy,
  fog,
  drizzle,
  rain,
  snow,
  showers,
  snowShowers,
  thunderstorm,
  unknown,
}

abstract final class WeatherCondition {
  static WeatherCategory category(int code) {
    return switch (code) {
      0 => WeatherCategory.clear,
      >= 1 && <= 2 => WeatherCategory.partlyCloudy,
      3 => WeatherCategory.cloudy,
      45 || 48 => WeatherCategory.fog,
      >= 51 && <= 57 => WeatherCategory.drizzle,
      >= 61 && <= 67 => WeatherCategory.rain,
      >= 71 && <= 77 => WeatherCategory.snow,
      >= 80 && <= 82 => WeatherCategory.showers,
      85 || 86 => WeatherCategory.snowShowers,
      >= 95 && <= 99 => WeatherCategory.thunderstorm,
      _ => WeatherCategory.unknown,
    };
  }

  static String label(int code) {
    return switch (category(code)) {
      WeatherCategory.clear => 'Ciel dégagé',
      WeatherCategory.partlyCloudy => 'Partiellement nuageux',
      WeatherCategory.cloudy => 'Couvert',
      WeatherCategory.fog => 'Brouillard',
      WeatherCategory.drizzle => 'Bruine',
      WeatherCategory.rain => 'Pluie',
      WeatherCategory.snow => 'Neige',
      WeatherCategory.showers => 'Averses',
      WeatherCategory.snowShowers => 'Averses de neige',
      WeatherCategory.thunderstorm => 'Orage',
      WeatherCategory.unknown => 'Conditions variables',
    };
  }

  static IconData icon(int code) {
    return switch (category(code)) {
      WeatherCategory.clear => Icons.wb_sunny_outlined,
      WeatherCategory.partlyCloudy => Icons.wb_cloudy_outlined,
      WeatherCategory.cloudy => Icons.cloud_outlined,
      WeatherCategory.fog => Icons.foggy,
      WeatherCategory.drizzle => Icons.grain,
      WeatherCategory.rain => Icons.water_drop_outlined,
      WeatherCategory.snow || WeatherCategory.snowShowers => Icons.ac_unit,
      WeatherCategory.showers => Icons.shower_outlined,
      WeatherCategory.thunderstorm => Icons.thunderstorm_outlined,
      WeatherCategory.unknown => Icons.cloud_outlined,
    };
  }
}
