import 'package:weather_app/features/city_details/data/entities/activities/acitivity_recommandation_result.dart';
import 'package:weather_app/features/city_details/data/entities/activities/activity_enum.dart';

abstract interface class ActivityRecommendationService {
  ActivityRecommendationResult evaluate({
    required ActivityEnum activity,
    required double minimumTemperature,
    required double maximumTemperature,
    required int precipitationProbability,
    required double maximumWindSpeed,
  });
}

final class ActivityRecommendationServiceImpl
    implements ActivityRecommendationService {
  const ActivityRecommendationServiceImpl();

  bool _hasComfortableTemperatureWindow({
    required double minimumTemperature,
    required double maximumTemperature,
    required double comfortableMinimum,
    required double comfortableMaximum,
  }) {
    return maximumTemperature >= comfortableMinimum &&
        minimumTemperature <= comfortableMaximum;
  }

  @override
  ActivityRecommendationResult evaluate({
    required ActivityEnum activity,
    required double minimumTemperature,
    required double maximumTemperature,
    required int precipitationProbability,
    required double maximumWindSpeed,
  }) {
    final criticalReason = _criticalReason(
      minimumTemperature: minimumTemperature,
      maximumTemperature: maximumTemperature,
      precipitationProbability: precipitationProbability,
      maximumWindSpeed: maximumWindSpeed,
    );

    if (criticalReason != null) {
      return ActivityRecommendationResult(
        recommendation: ActivityRecommendation.discouraged,
        reason: criticalReason,
      );
    }

    return switch (activity) {
      ActivityEnum.walking => _evaluateWalking(
        minimumTemperature: minimumTemperature,
        maximumTemperature: maximumTemperature,
        precipitationProbability: precipitationProbability,
        maximumWindSpeed: maximumWindSpeed,
      ),
      ActivityEnum.running => _evaluateRunning(
        minimumTemperature: minimumTemperature,
        maximumTemperature: maximumTemperature,
        precipitationProbability: precipitationProbability,
        maximumWindSpeed: maximumWindSpeed,
      ),
      ActivityEnum.picnic => _evaluatePicnic(
        minimumTemperature: minimumTemperature,
        maximumTemperature: maximumTemperature,
        precipitationProbability: precipitationProbability,
        maximumWindSpeed: maximumWindSpeed,
      ),
    };
  }

  String? _criticalReason({
    required double minimumTemperature,
    required double maximumTemperature,
    required int precipitationProbability,
    required double maximumWindSpeed,
  }) {
    if (minimumTemperature <= -5) {
      return 'Températures très basses';
    }

    if (maximumTemperature >= 36 && minimumTemperature >= 22) {
      return 'Chaleur excessive';
    }

    if (precipitationProbability >= 80) {
      return 'Fort risque de pluie';
    }

    if (maximumWindSpeed >= 60) {
      return 'Vent trop important';
    }

    return null;
  }

  ActivityRecommendationResult _evaluateWalking({
    required double minimumTemperature,
    required double maximumTemperature,
    required int precipitationProbability,
    required double maximumWindSpeed,
  }) {
    if (precipitationProbability > 60) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.possible,
        reason: 'Prévoyez une protection contre la pluie',
      );
    }

    if (maximumWindSpeed > 45) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.possible,
        reason: 'Vent soutenu pendant la journée',
      );
    }

    final temperatureIsIdeal =
        minimumTemperature >= 5 && maximumTemperature <= 32;

    if (temperatureIsIdeal &&
        precipitationProbability <= 30 &&
        maximumWindSpeed <= 35) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.recommended,
        reason: 'Conditions agréables pour marcher',
      );
    }

    final hasComfortableWindow = _hasComfortableTemperatureWindow(
      minimumTemperature: minimumTemperature,
      maximumTemperature: maximumTemperature,
      comfortableMinimum: 5,
      comfortableMaximum: 32,
    );

    if (hasComfortableWindow) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.possible,
        reason: 'Choisissez les heures les plus agréables',
      );
    }

    return const ActivityRecommendationResult(
      recommendation: ActivityRecommendation.discouraged,
      reason: 'Températures peu adaptées à une balade',
    );
  }

  ActivityRecommendationResult _evaluateRunning({
    required double minimumTemperature,
    required double maximumTemperature,
    required int precipitationProbability,
    required double maximumWindSpeed,
  }) {
    if (minimumTemperature < 0) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.possible,
        reason: 'Privilégiez les heures les plus douces',
      );
    }

    if (precipitationProbability > 50) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.possible,
        reason: 'Risque de pluie pendant la journée',
      );
    }

    if (maximumWindSpeed > 40) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.possible,
        reason: 'Vent soutenu, adaptez votre parcours',
      );
    }

    final temperatureIsIdeal =
        minimumTemperature >= 5 && maximumTemperature <= 28;

    if (temperatureIsIdeal &&
        precipitationProbability <= 40 &&
        maximumWindSpeed <= 35) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.recommended,
        reason: 'Bonnes conditions pour courir',
      );
    }

    final hasComfortableWindow = _hasComfortableTemperatureWindow(
      minimumTemperature: minimumTemperature,
      maximumTemperature: maximumTemperature,
      comfortableMinimum: 0,
      comfortableMaximum: 32,
    );

    if (hasComfortableWindow) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.possible,
        reason: 'Choisissez le moment le plus adapté de la journée',
      );
    }

    return const ActivityRecommendationResult(
      recommendation: ActivityRecommendation.discouraged,
      reason: 'Températures peu adaptées à la course',
    );
  }

  ActivityRecommendationResult _evaluatePicnic({
    required double minimumTemperature,
    required double maximumTemperature,
    required int precipitationProbability,
    required double maximumWindSpeed,
  }) {
    if (precipitationProbability > 50) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.discouraged,
        reason: 'Risque de pluie trop important',
      );
    }

    if (maximumWindSpeed > 40) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.discouraged,
        reason: 'Vent trop important pour un pique-nique',
      );
    }

    if (maximumTemperature < 12) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.discouraged,
        reason: 'Température trop basse pour un pique-nique',
      );
    }

    if (maximumTemperature >= 14 &&
        maximumTemperature <= 32 &&
        precipitationProbability <= 30 &&
        maximumWindSpeed <= 30) {
      return const ActivityRecommendationResult(
        recommendation: ActivityRecommendation.recommended,
        reason: 'Conditions agréables pour un pique-nique',
      );
    }

    return const ActivityRecommendationResult(
      recommendation: ActivityRecommendation.possible,
      reason: 'Prévoyez une solution de repli',
    );
  }
}
