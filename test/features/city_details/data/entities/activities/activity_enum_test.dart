import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/city_details/data/entities/activities/activity_enum.dart';

void main() {
  group('ActivityEnum', () {
    test('retourne le libellé de chaque activité', () {
      expect(ActivityEnum.walking.label, 'Balade');
      expect(ActivityEnum.running.label, 'Course');
      expect(ActivityEnum.picnic.label, 'Pique-nique');
    });
  });

  group('ActivityRecommendation', () {
    test('retourne le libellé de chaque recommandation', () {
      expect(ActivityRecommendation.recommended.label, 'Recommandée');
      expect(ActivityRecommendation.possible.label, 'Possible');
      expect(ActivityRecommendation.discouraged.label, 'Déconseillée');
    });
  });
}
