import 'package:flutter/material.dart';
import 'package:weather_app/features/city_details/data/entities/activities/acitivity_recommandation_result.dart';
import 'package:weather_app/features/city_details/data/entities/activities/activity_enum.dart';

class ActivityRecommendationBadge extends StatelessWidget {
  const ActivityRecommendationBadge({required this.result, super.key});

  final ActivityRecommendationResult result;

  @override
  Widget build(BuildContext context) {
    final visual = _visualFor(result.recommendation);
    final colorScheme = Theme.of(context).colorScheme;

    final backgroundColor = Color.alphaBlend(
      visual.color.withValues(alpha: 0.14),
      colorScheme.surface,
    );

    return Semantics(
      label: '${result.recommendation.label}. ${result.reason}',
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: visual.color.withValues(alpha: 0.4)),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          child: Row(
            children: [
              Icon(visual.icon, color: visual.color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      result.recommendation.label,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: visual.color,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      result.reason,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _RecommendationVisual _visualFor(ActivityRecommendation recommendation) {
    return switch (recommendation) {
      ActivityRecommendation.recommended => const _RecommendationVisual(
        icon: Icons.check_circle_outline,
        color: Colors.green,
      ),
      ActivityRecommendation.possible => const _RecommendationVisual(
        icon: Icons.info_outline,
        color: Colors.orange,
      ),
      ActivityRecommendation.discouraged => const _RecommendationVisual(
        icon: Icons.cancel_outlined,
        color: Colors.red,
      ),
    };
  }
}

class _RecommendationVisual {
  const _RecommendationVisual({required this.icon, required this.color});

  final IconData icon;
  final Color color;
}
