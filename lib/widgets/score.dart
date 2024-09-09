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
          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Colors.blue),
        ),
        Text(
          'Meilleur Score: ${gameProvider.bestScore}',  // Afficher le meilleur score
          style: const TextStyle(fontSize: 18, color: Colors.blueGrey),
        ),
      ],
    );
  }
}
