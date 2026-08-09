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

  final cases =
      <
        ({
          ActivityRecommendation recommendation,
          String reason,
          String label,
          IconData icon,
        })
      >[
        (
          recommendation: ActivityRecommendation.recommended,
          reason: 'Conditions agréables',
          label: 'Recommandée',
          icon: Icons.check_circle_outline,
        ),
        (
          recommendation: ActivityRecommendation.possible,
          reason: 'Prévoyez une protection',
          label: 'Possible',
          icon: Icons.info_outline,
        ),
        (
          recommendation: ActivityRecommendation.discouraged,
          reason: 'Conditions dangereuses',
          label: 'Déconseillée',
          icon: Icons.cancel_outlined,
        ),
      ];

  for (final testCase in cases) {
    testWidgets('affiche le badge ${testCase.label}', (tester) async {
      await tester.pumpWidget(
        buildSubject(
          ActivityRecommendationResult(
            recommendation: testCase.recommendation,
            reason: testCase.reason,
          ),
        ),
      );

      expect(find.text(testCase.label), findsOneWidget);
      expect(find.text(testCase.reason), findsOneWidget);
      expect(find.byIcon(testCase.icon), findsOneWidget);
    });
  }

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
