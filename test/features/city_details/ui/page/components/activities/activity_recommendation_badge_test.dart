import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/city_details/data/entities/activities/acitivity_recommandation_result.dart';
import 'package:weather_app/features/city_details/data/entities/activities/activity_enum.dart';
import 'package:weather_app/features/city_details/ui/page/components/activities/activity_recommendation_badge.dart';

void main() {
  Widget buildSubject(ActivityRecommendationResult result) {
    return MaterialApp(
      home: Scaffold(body: ActivityRecommendationBadge(result: result)),
    );
  }

  testWidgets('affiche une recommandation favorable', (tester) async {
    await tester.pumpWidget(
      buildSubject(
        const ActivityRecommendationResult(
          recommendation: ActivityRecommendation.recommended,
          reason: 'Conditions agréables',
        ),
      ),
    );

    expect(find.text('Recommandée'), findsOneWidget);
    expect(find.text('Conditions agréables'), findsOneWidget);
    expect(find.byIcon(Icons.check_circle_outline), findsOneWidget);
  });

  testWidgets('affiche une recommandation possible', (tester) async {
    await tester.pumpWidget(
      buildSubject(
        const ActivityRecommendationResult(
          recommendation: ActivityRecommendation.possible,
          reason: 'Prévoyez une protection',
        ),
      ),
    );

    expect(find.text('Possible'), findsOneWidget);
    expect(find.text('Prévoyez une protection'), findsOneWidget);
    expect(find.byIcon(Icons.info_outline), findsOneWidget);
  });

  testWidgets('affiche une recommandation défavorable', (tester) async {
    await tester.pumpWidget(
      buildSubject(
        const ActivityRecommendationResult(
          recommendation: ActivityRecommendation.discouraged,
          reason: 'Conditions dangereuses',
        ),
      ),
    );

    expect(find.text('Déconseillée'), findsOneWidget);
    expect(find.text('Conditions dangereuses'), findsOneWidget);
    expect(find.byIcon(Icons.cancel_outlined), findsOneWidget);
  });
  testWidgets('fournit un libellé sémantique complet', (tester) async {
    final semanticsHandle = tester.ensureSemantics();

    try {
      await tester.pumpWidget(
        buildSubject(
          const ActivityRecommendationResult(
            recommendation: ActivityRecommendation.recommended,
            reason: 'Conditions agréables',
          ),
        ),
      );

      expect(
        find.bySemanticsLabel('Recommandée. Conditions agréables'),
        findsOneWidget,
      );
    } finally {
      semanticsHandle.dispose();
    }
  });
}
