import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/city_details/data/repository/weather_repository.dart';
import 'package:weather_app/features/city_details/ui/cubit/city_details_cubit.dart';
import 'package:weather_app/features/city_details/ui/page/components/city_details_view.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';

class CityDetailsPage extends StatelessWidget {
  const CityDetailsPage({required this.city, super.key});

  final City city;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CityDetailsCubit(weatherRepository: context.read<WeatherRepository>())
            ..loadForecast(latitude: city.latitude, longitude: city.longitude),
      child: CityDetailsView(city: city),
    );
  }
}
