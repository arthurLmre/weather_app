import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/city_details/data/entities/activities/activity_enum.dart';
import 'package:weather_app/features/city_details/ui/page/components/activities/activity_selector.dart';

void main() {
  Widget buildSubject({
    required ActivityEnum selectedActivity,
    required ValueChanged<ActivityEnum> onActivitySelected,
  }) {
    return MaterialApp(
      home: Scaffold(
        body: ActivitySelector(
          selectedActivity: selectedActivity,
          onActivitySelected: onActivitySelected,
        ),
      ),
    );
  }

  testWidgets('affiche les trois activités et leurs icônes', (tester) async {
    await tester.pumpWidget(
      buildSubject(
        selectedActivity: ActivityEnum.walking,
        onActivitySelected: (_) {},
      ),
    );

    expect(find.text('Balade'), findsOneWidget);
    expect(find.text('Course'), findsOneWidget);
    expect(find.text('Pique-nique'), findsOneWidget);
    expect(find.byIcon(Icons.directions_walk_outlined), findsOneWidget);
    expect(find.byIcon(Icons.directions_run_outlined), findsOneWidget);
    expect(find.byIcon(Icons.park_outlined), findsOneWidget);
  });

  testWidgets('transmet l’activité choisie au callback', (tester) async {
    ActivityEnum? selectedActivity;

    await tester.pumpWidget(
      buildSubject(
        selectedActivity: ActivityEnum.walking,
        onActivitySelected: (activity) {
          selectedActivity = activity;
        },
      ),
    );

    await tester.tap(find.text('Course'));
    await tester.pump();

    expect(selectedActivity, ActivityEnum.running);
  });

  testWidgets('expose l’activité sélectionnée au SegmentedButton', (
    tester,
  ) async {
    await tester.pumpWidget(
      buildSubject(
        selectedActivity: ActivityEnum.picnic,
        onActivitySelected: (_) {},
      ),
    );

    final segmentedButton = tester.widget<SegmentedButton<ActivityEnum>>(
      find.byType(SegmentedButton<ActivityEnum>),
    );

    expect(segmentedButton.selected, {ActivityEnum.picnic});
  });
}
