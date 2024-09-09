import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

class ScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();
    
   return Column(
      children: [
        Text(
          'Score: ${gameProvider.score}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Text(
          'Meilleur Score: ${gameProvider.bestScore}',  // Afficher le meilleur score
          style: TextStyle(fontSize: 18, color: Colors.grey),
        ),
      ],
    );
  }
}
