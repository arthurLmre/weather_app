# Weather App — Météo de sortie

Application Flutter réalisée dans le cadre d’un test technique. Elle permet de rechercher une ville, de consulter ses prévisions météo et d’évaluer si une activité extérieure est recommandée selon les conditions prévues.

## Fonctionnalités

- Recherche de villes avec l’API de géocodage Open-Meteo.
- Anti-rebond de 500 ms et annulation des requêtes précédentes.
- Gestion des états de chargement, d’erreur et d’absence de résultat.
- Historique local des 10 dernières villes consultées.
- Prévisions horaires sur 24 heures et quotidiennes sur 7 jours.
- Recommandations pour la balade, la course et le pique-nique.
- Ajout et suppression de villes favorites avec persistance locale.
- Thèmes clair et sombre selon les préférences du système.
- Cache local des prévisions pour les 10 dernières villes consultées.
- Affichage des dernières données mises en cache en cas d’échec réseau.

Les données proviennent exclusivement des API publiques et gratuites d’[Open-Meteo](https://open-meteo.com/), sans clé API.

## Prérequis

- Flutter **3.44.7**
- Dart **3.12.2**
- Android Studio et/ou Xcode selon la plateforme ciblée
- Un émulateur, un simulateur ou un appareil physique configuré
- [FVM](https://fvm.app/) recommandé pour utiliser la bonne version de Flutter

## Installation et lancement

```bash
git clone https://github.com/arthurLmre/weather_app.git
cd weather_app

fvm install 3.44.7
fvm use 3.44.7
fvm flutter pub get
fvm flutter run
```

Sans FVM, les mêmes commandes peuvent être exécutées avec une installation locale de Flutter 3.44.7 :

```bash
flutter pub get
flutter run
```

## Architecture

Le projet utilise une architecture organisée par features :

```text
lib/
├── core/
│   ├── network/     # Client HTTP et gestion des erreurs
│   ├── router/      # Navigation
│   ├── storage/     # Abstraction du stockage local
│   └── theme/       # Thèmes clair et sombre
└── features/
    ├── city_search/
    ├── city_details/
    └── favorites/
```

Chaque fonctionnalité sépare :

- **UI** : pages et composants Flutter ;
- **Cubit** : état et logique de présentation ;
- **Repository** : orchestration des sources de données ;
- **Data sources** : API distante ou stockage local ;
- **DTO / Entities** : modèles de transport et objets utilisés par l’application.

Les dépendances sont créées au démarrage puis injectées avec `RepositoryProvider` et `BlocProvider`. Les interfaces placées devant les repositories, services et sources de données permettent de les remplacer facilement dans les tests.

Utilisation de Cubit, plus léger à implémenter que Bloc pour un test technique

## Bibliothèques principales

- **flutter_bloc** : gestion d’état avec Cubit ;
- **dio** : appels HTTP, délais d’attente et annulation des requêtes ;
- **go_router** : navigation et barre d’onglets ;
- **shared_preferences** : favoris, historique et cache local ;
- **freezed / json_serializable** : modèles immuables et sérialisation JSON ;
- **equatable** : comparaison des états ;
- **bloc_test / mocktail** : tests des Cubits et dépendances simulées.

## Règles de recommandation météo

La recommandation utilise la température minimale et maximale, la probabilité de précipitation et la vitesse maximale du vent.

### Conditions critiques communes

L’activité est directement **déconseillée** dans les cas suivants :

- température minimale inférieure ou égale à **-5 °C** ;
- température maximale supérieure ou égale à **36 °C** avec une minimale d’au moins **24 °C** ;
- probabilité de pluie supérieure ou égale à **80 %** ;
- vent supérieur ou égal à **60 km/h**.

### Balade

- **Recommandée** : température comprise entre 5 et 32 °C, pluie ≤ 30 % et vent ≤ 35 km/h.
- **Possible** : risque de pluie jusqu’à 79 %, vent soutenu ou présence d’une plage de température acceptable dans la journée.
- **Déconseillée** : températures incompatibles avec une balade et absence de plage confortable.

### Course

- **Recommandée** : température comprise entre 5 et 28 °C, pluie ≤ 40 % et vent ≤ 35 km/h.
- **Possible** : température légèrement négative, pluie modérée, vent soutenu ou créneau plus favorable dans la journée.
- **Déconseillée** : températures incompatibles avec la pratique et absence de créneau acceptable.

### Pique-nique

- **Recommandé** : température maximale entre 14 et 32 °C, pluie ≤ 30 % et vent ≤ 30 km/h.
- **Possible** : conditions intermédiaires nécessitant une solution de repli.
- **Déconseillé** : pluie > 50 %, vent > 40 km/h ou température maximale < 12 °C.

Ces règles sont volontairement simples, déterministes et isolées dans un service métier afin de rester compréhensibles et facilement testables.

## Analyse et tests

Exécuter toutes les vérifications :

```bash
./tools/check.sh
```

Le script vérifie successivement le formatage, l’analyse statique et les tests unitaires/widget.

Commandes séparées :

```bash
fvm dart format --output=none --set-exit-if-changed lib test
fvm flutter analyze
fvm flutter test
```

Test d’intégration :

```bash
fvm flutter test integration_test/app_test.dart
```

La suite couvre notamment :

- les règles de recommandation météo ;
- les appels réseau simulés et la conversion des réponses API ;
- les repositories, le cache, l’historique et les favoris ;
- les Cubits et leurs différents états ;
- les principaux écrans et composants ;
- trois parcours d’intégration : recherche et consultation, ajout aux favoris, puis fonctionnement avec données météo en cache.

## Intégration continue

Le projet utilise GitHub Actions pour exécuter automatiquement les vérifications de qualité lors des Pull Requests vers les branches dev et main.

Ces mêmes vérifications sont également exécutées localement avant les commits et les push grâce aux Git hooks présents dans .githooks. Cela permet de détecter les erreurs le plus tôt possible et d’éviter d’envoyer du code non vérifié sur le dépôt distant.

La CI constitue ensuite une seconde validation, exécutée dans un environnement indépendant avant l’intégration du code.

## Limites et compromis

- La recherche commence à partir de trois caractères et ne gère pas la pagination. Pour cet usage, affiner la saisie a été privilégié plutôt que parcourir une longue liste de résultats.
- Le cache est limité aux 10 dernières villes afin de garder un stockage local simple et borné.
- Les données en cache ne possèdent pas de durée d’expiration : en cas de panne réseau, la dernière prévision disponible est affichée même si elle peut être ancienne.
- L’interface est principalement pensée pour un usage mobile ; aucune adaptation spécifique aux tablettes n’a été développée.
- Les recommandations reposent sur des seuils simples et ne prennent pas en compte tous les facteurs possibles, comme l’ensoleillement, le ressenti et surtout l’heure exacte de l’activité.

## Utilisation de l’IA

Utilisation de ChatGPT et Claude comme outil d’assistance pour :

- discuter de certains choix technique, d’architecture et de découpage ;
- proposer et compléter des scénarios de tests ;
- relire et structurer la documentation.