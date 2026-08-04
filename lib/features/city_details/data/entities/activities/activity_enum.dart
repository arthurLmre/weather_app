enum ActivityEnum {
  walking,
  running,
  picnic;

  String get label {
    return switch (this) {
      ActivityEnum.walking => 'Balade',
      ActivityEnum.running => 'Course',
      ActivityEnum.picnic => 'Pique-nique',
    };
  }
}

enum ActivityRecommendation {
  recommended,
  possible,
  discouraged;

  String get label {
    return switch (this) {
      ActivityRecommendation.recommended => 'Recommandée',
      ActivityRecommendation.possible => 'Possible',
      ActivityRecommendation.discouraged => 'Déconseillée',
    };
  }
}
