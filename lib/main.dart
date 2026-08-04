import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/network/dio_api_client.dart';
import 'package:weather_app/core/router/app_router.dart';
import 'package:weather_app/core/theme/app_theme.dart';
import 'package:weather_app/features/city_search/data/data_sources/city_search_data_source_impl.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository.dart';
import 'package:weather_app/features/city_search/data/repository/city_search_repository_impl.dart';
import 'package:weather_app/features/city_search/ui/cubit/city_search_cubit.dart';

void main() {
  final apiClient = DioApiClient();

  final citySearchRepository = CitySearchRepositoryImpl(
    dataSource: CitySearchDataSourceImpl(apiClient: apiClient),
  );

  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider<CitySearchRepository>.value(
          value: citySearchRepository,
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => CitySearchCubit(
              repository: context.read<CitySearchRepository>(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Weather App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,
      routerConfig: AppRouter.router,
    );
  }
}
