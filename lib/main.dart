import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/score.dart';
import 'widgets/grid.dart';
import 'widgets/game_provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MaterialApp(
        home: Scaffold(
          body: Column(
            children: [
              ScoreWidget(),
              GridWidget(),
            ],
          ),
        ),
      ),
    );
  }
}
