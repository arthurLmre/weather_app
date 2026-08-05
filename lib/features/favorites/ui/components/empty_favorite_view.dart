import 'package:flutter/material.dart';

class EmptyFavoritesView extends StatelessWidget {
  const EmptyFavoritesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.favorite_border, size: 48),
            SizedBox(height: 16),
            Text('Aucune ville favorite', textAlign: TextAlign.center),
            SizedBox(height: 8),
            Text(
              'Ajoutez une ville depuis sa fiche météo.',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
