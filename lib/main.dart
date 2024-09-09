import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/game_provider.dart';
import 'widgets/grid.dart';
import 'widgets/score.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();

    return Scaffold(
      appBar: AppBar(title: Text("2048 Flutter")),
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dx > 0) {
            gameProvider.moveRight();
          } else if (details.velocity.pixelsPerSecond.dx < 0) {
            gameProvider.moveLeft();
          }
        },
        onVerticalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dy > 0) {
            gameProvider.moveDown();
          } else if (details.velocity.pixelsPerSecond.dy < 0) {
            gameProvider.moveUp();
          }
        },
        child: Column(
  children: [
    ScoreWidget(),
    AspectRatio(
      aspectRatio: 1, // Maintenir une grille carrée
      child: GridWidget(
        physics: NeverScrollableScrollPhysics(),
      ),
    ),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: gameProvider.isGameOver
          ? Column(
              children: [
                Text(
                  "Game Over",
                  style: TextStyle(fontSize: 32, color: Colors.red, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: Icon(Icons.refresh, size: 48),
                  onPressed: () {
                    context.read<GameProvider>().resetGame();
                  },
                ),
              ],
            )
          : IconButton(
              icon: Icon(Icons.refresh, size: 48),
              onPressed: () {
                context.read<GameProvider>().resetGame();
              },
            ),
    ),
  ],
),

      ),
    );
  }
}




void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => GameProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Désactive le bandeau "Debug"
        home: GameScreen(),
      ),
    ),
  );
}

