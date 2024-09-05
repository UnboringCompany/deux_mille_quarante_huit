import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

class ScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final score = context.watch<GameProvider>().score;
    
    return Container(
      padding: EdgeInsets.all(16),
      child: Text(
        'Score: $score',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
