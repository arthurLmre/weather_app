import 'package:weather_app/features/city_details/data/entities/activities/activity_enum.dart';

class ActivityRecommendationResult {
  const ActivityRecommendationResult({
    required this.recommendation,
    required this.reason,
  });

  final ActivityRecommendation recommendation;
  final String reason;
}
