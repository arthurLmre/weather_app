import 'package:bloc_test/bloc_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:weather_app/features/city_search/data/entities/city.dart';
import 'package:weather_app/features/city_search/ui/cubit/city_search_cubit.dart';
import 'package:weather_app/features/city_search/ui/page/city_search_page.dart';

final class MockCitySearchCubit extends MockCubit<CitySearchState>
    implements CitySearchCubit {}

void main() {
  late MockCitySearchCubit cubit;

  setUp(() {
    cubit = MockCitySearchCubit();
  });

  Widget buildPage() {
    return MaterialApp(
      home: BlocProvider<CitySearchCubit>.value(
        value: cubit,
        child: const CitySearchPage(),
      ),
    );
  }

  testWidgets('shows helper content in initial state', (tester) async {
    when(() => cubit.state).thenReturn(const CitySearchInitial());

    await tester.pumpWidget(buildPage());

    expect(find.textContaining('Saisis au moins 3 caractères'), findsOneWidget);
  });

  testWidgets('shows loading indicator in loading state', (tester) async {
    when(() => cubit.state).thenReturn(const CitySearchLoading());

    await tester.pumpWidget(buildPage());

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets('shows cities in success state', (tester) async {
    const lyon = City(
      id: 2996944,
      name: 'Lyon',
      latitude: 45.7485,
      longitude: 4.8467,
      country: 'France',
      region: 'Auvergne-Rhône-Alpes',
    );

    when(() => cubit.state).thenReturn(const CitySearchSuccess(cities: [lyon]));

    await tester.pumpWidget(buildPage());

    expect(find.text('Lyon'), findsOneWidget);
    expect(find.text('Auvergne-Rhône-Alpes, France'), findsOneWidget);
  });

  testWidgets('forwards submitted query to the cubit', (tester) async {
    when(() => cubit.state).thenReturn(const CitySearchInitial());

    when(() => cubit.onQueryChanged(any())).thenAnswer((_) async {});
    when(() => cubit.searchImmediately(any())).thenAnswer((_) async {});

    await tester.pumpWidget(buildPage());

    await tester.enterText(find.byType(TextField), 'Lyon');

    await tester.testTextInput.receiveAction(TextInputAction.search);

    verify(() => cubit.onQueryChanged('Lyon')).called(1);
    verify(() => cubit.searchImmediately('Lyon')).called(1);
  });
}
