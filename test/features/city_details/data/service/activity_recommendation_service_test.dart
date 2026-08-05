import 'package:flutter_test/flutter_test.dart';
import 'package:weather_app/features/city_details/data/entities/activities/activity_enum.dart';
import 'package:weather_app/features/city_details/data/service/activity_repository.dart';

void main() {
  const service = ActivityRecommendationServiceImpl();

  void expectEvaluation({
    required ActivityEnum activity,
    required double minimumTemperature,
    required double maximumTemperature,
    required int precipitationProbability,
    required double maximumWindSpeed,
    required ActivityRecommendation recommendation,
    required String reason,
  }) {
    final result = service.evaluate(
      activity: activity,
      minimumTemperature: minimumTemperature,
      maximumTemperature: maximumTemperature,
      precipitationProbability: precipitationProbability,
      maximumWindSpeed: maximumWindSpeed,
    );

    expect(result.recommendation, recommendation);
    expect(result.reason, reason);
  }

  group('conditions critiques communes', () {
    test('déconseille toute activité en cas de froid extrême', () {
      expectEvaluation(
        activity: ActivityEnum.walking,
        minimumTemperature: -5,
        maximumTemperature: 2,
        precipitationProbability: 0,
        maximumWindSpeed: 10,
        recommendation: ActivityRecommendation.discouraged,
        reason: 'Températures très basses',
      );
    });

    test('déconseille toute activité en cas de chaleur excessive', () {
      expectEvaluation(
        activity: ActivityEnum.running,
        minimumTemperature: 22,
        maximumTemperature: 36,
        precipitationProbability: 0,
        maximumWindSpeed: 10,
        recommendation: ActivityRecommendation.discouraged,
        reason: 'Chaleur excessive',
      );
    });

    test(
      'déconseille toute activité lorsque le risque de pluie atteint 80 %',
      () {
        expectEvaluation(
          activity: ActivityEnum.picnic,
          minimumTemperature: 15,
          maximumTemperature: 24,
          precipitationProbability: 80,
          maximumWindSpeed: 10,
          recommendation: ActivityRecommendation.discouraged,
          reason: 'Fort risque de pluie',
        );
      },
    );

    test('déconseille toute activité lorsque le vent atteint 60 km/h', () {
      expectEvaluation(
        activity: ActivityEnum.walking,
        minimumTemperature: 15,
        maximumTemperature: 24,
        precipitationProbability: 10,
        maximumWindSpeed: 60,
        recommendation: ActivityRecommendation.discouraged,
        reason: 'Vent trop important',
      );
    });
  });

  group('balade', () {
    test('recommande la balade lorsque les conditions sont idéales', () {
      expectEvaluation(
        activity: ActivityEnum.walking,
        minimumTemperature: 10,
        maximumTemperature: 25,
        precipitationProbability: 20,
        maximumWindSpeed: 20,
        recommendation: ActivityRecommendation.recommended,
        reason: 'Conditions agréables pour marcher',
      );
    });

    test('reste possible avec un risque de pluie supérieur à 60 %', () {
      expectEvaluation(
        activity: ActivityEnum.walking,
        minimumTemperature: 10,
        maximumTemperature: 25,
        precipitationProbability: 61,
        maximumWindSpeed: 20,
        recommendation: ActivityRecommendation.possible,
        reason: 'Prévoyez une protection contre la pluie',
      );
    });

    test('reste possible avec un vent supérieur à 45 km/h', () {
      expectEvaluation(
        activity: ActivityEnum.walking,
        minimumTemperature: 10,
        maximumTemperature: 25,
        precipitationProbability: 20,
        maximumWindSpeed: 46,
        recommendation: ActivityRecommendation.possible,
        reason: 'Vent soutenu pendant la journée',
      );
    });

    test('reste possible lorsqu’une plage confortable existe', () {
      expectEvaluation(
        activity: ActivityEnum.walking,
        minimumTemperature: 0,
        maximumTemperature: 10,
        precipitationProbability: 40,
        maximumWindSpeed: 20,
        recommendation: ActivityRecommendation.possible,
        reason: 'Choisissez les heures les plus agréables',
      );
    });

    test('est déconseillée sans plage de température confortable', () {
      expectEvaluation(
        activity: ActivityEnum.walking,
        minimumTemperature: 33,
        maximumTemperature: 35,
        precipitationProbability: 20,
        maximumWindSpeed: 20,
        recommendation: ActivityRecommendation.discouraged,
        reason: 'Températures peu adaptées à une balade',
      );
    });
  });

  group('course', () {
    test('recommande la course lorsque les conditions sont idéales', () {
      expectEvaluation(
        activity: ActivityEnum.running,
        minimumTemperature: 8,
        maximumTemperature: 24,
        precipitationProbability: 20,
        maximumWindSpeed: 20,
        recommendation: ActivityRecommendation.recommended,
        reason: 'Bonnes conditions pour courir',
      );
    });

    test('reste possible lorsque la température minimale est négative', () {
      expectEvaluation(
        activity: ActivityEnum.running,
        minimumTemperature: -1,
        maximumTemperature: 8,
        precipitationProbability: 20,
        maximumWindSpeed: 20,
        recommendation: ActivityRecommendation.possible,
        reason: 'Privilégiez les heures les plus douces',
      );
    });

    test('reste possible avec un risque de pluie supérieur à 50 %', () {
      expectEvaluation(
        activity: ActivityEnum.running,
        minimumTemperature: 8,
        maximumTemperature: 24,
        precipitationProbability: 51,
        maximumWindSpeed: 20,
        recommendation: ActivityRecommendation.possible,
        reason: 'Risque de pluie pendant la journée',
      );
    });

    test('reste possible avec un vent supérieur à 40 km/h', () {
      expectEvaluation(
        activity: ActivityEnum.running,
        minimumTemperature: 8,
        maximumTemperature: 24,
        precipitationProbability: 20,
        maximumWindSpeed: 41,
        recommendation: ActivityRecommendation.possible,
        reason: 'Vent soutenu, adaptez votre parcours',
      );
    });

    test('reste possible lorsqu’une plage confortable existe', () {
      expectEvaluation(
        activity: ActivityEnum.running,
        minimumTemperature: 29,
        maximumTemperature: 31,
        precipitationProbability: 20,
        maximumWindSpeed: 20,
        recommendation: ActivityRecommendation.possible,
        reason: 'Choisissez le moment le plus adapté de la journée',
      );
    });

    test('est déconseillée sans plage de température confortable', () {
      expectEvaluation(
        activity: ActivityEnum.running,
        minimumTemperature: 33,
        maximumTemperature: 35,
        precipitationProbability: 20,
        maximumWindSpeed: 20,
        recommendation: ActivityRecommendation.discouraged,
        reason: 'Températures peu adaptées à la course',
      );
    });
  });

  group('pique-nique', () {
    test('recommande le pique-nique lorsque les conditions sont idéales', () {
      expectEvaluation(
        activity: ActivityEnum.picnic,
        minimumTemperature: 10,
        maximumTemperature: 24,
        precipitationProbability: 20,
        maximumWindSpeed: 20,
        recommendation: ActivityRecommendation.recommended,
        reason: 'Conditions agréables pour un pique-nique',
      );
    });

    test('le déconseille avec un risque de pluie supérieur à 50 %', () {
      expectEvaluation(
        activity: ActivityEnum.picnic,
        minimumTemperature: 10,
        maximumTemperature: 24,
        precipitationProbability: 51,
        maximumWindSpeed: 20,
        recommendation: ActivityRecommendation.discouraged,
        reason: 'Risque de pluie trop important',
      );
    });

    test('le déconseille avec un vent supérieur à 40 km/h', () {
      expectEvaluation(
        activity: ActivityEnum.picnic,
        minimumTemperature: 10,
        maximumTemperature: 24,
        precipitationProbability: 20,
        maximumWindSpeed: 41,
        recommendation: ActivityRecommendation.discouraged,
        reason: 'Vent trop important pour un pique-nique',
      );
    });

    test(
      'le déconseille lorsque la température maximale est inférieure à 12 °C',
      () {
        expectEvaluation(
          activity: ActivityEnum.picnic,
          minimumTemperature: 5,
          maximumTemperature: 11,
          precipitationProbability: 20,
          maximumWindSpeed: 20,
          recommendation: ActivityRecommendation.discouraged,
          reason: 'Température trop basse pour un pique-nique',
        );
      },
    );

    test('reste possible lorsque les conditions ne sont pas idéales', () {
      expectEvaluation(
        activity: ActivityEnum.picnic,
        minimumTemperature: 8,
        maximumTemperature: 13,
        precipitationProbability: 20,
        maximumWindSpeed: 20,
        recommendation: ActivityRecommendation.possible,
        reason: 'Prévoyez une solution de repli',
      );
    });
  });
}
