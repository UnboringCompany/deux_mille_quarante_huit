import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

class ScoreWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameProvider>(
      builder: (context, gameProvider, child) {
        return Text('Score: ${gameProvider.score}');
      },
    );
  }
}
