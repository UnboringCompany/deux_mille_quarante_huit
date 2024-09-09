import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/game_provider.dart';
import 'widgets/grid.dart';
import 'widgets/score.dart';
import 'widgets/settings_panel.dart';


class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _isSettingsPanelOpen = false;

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text("2048 Flutter"),
        actions: [
          IconButton(
            icon: Icon(Icons.settings),
            onPressed: () {
              setState(() {
                _isSettingsPanelOpen = !_isSettingsPanelOpen;
              });
            },
          ),
        ],
      ),
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
        child: Stack(
          children: [
            Column(
              children: [
                ScoreWidget(),
                AspectRatio(
                  aspectRatio: 1, 
                  child: GridWidget(
                    physics: NeverScrollableScrollPhysics(),
                  ),
                ),
              ],
            ),
            AnimatedPositioned(
              duration: Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              right: _isSettingsPanelOpen ? 0 : -MediaQuery.of(context).size.width * 0.8,
              width: MediaQuery.of(context).size.width * 0.75,
              height: MediaQuery.of(context).size.height,
              child: Container(
                color: Colors.white,
                child: SettingsPanel(),
              ),
            ),
          ],
        ),

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
