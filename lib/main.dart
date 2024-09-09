import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'widgets/game_provider.dart';
import 'widgets/grid.dart';
import 'widgets/score.dart';
import 'widgets/settings_panel.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  bool _isSettingsPanelOpen = false;

  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();

    return Scaffold(
      backgroundColor: const Color.fromRGBO(225, 215, 198, 1),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(225, 215, 198, 1),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
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
                const Text(
                  "(Not)Boring 2048",
                  style: TextStyle(fontSize: 36, fontWeight: FontWeight.w900, color: Colors.blueAccent),
                ),
                const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
                ScoreWidget(),
                AspectRatio(
                  aspectRatio: 1,
                  child: GridWidget(
                    physics: const NeverScrollableScrollPhysics(),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: gameProvider.isGameOver
                      ? Column(
                          children: [
                            const Text(
                              "Game Over",
                              style: TextStyle(fontSize: 32, color: Colors.blueAccent),
                            ),
                            IconButton(
                              icon: const Icon(Icons.refresh, size: 48),
                              onPressed: () {
                                context.read<GameProvider>().resetGame();
                              },
                            ),
                          ],
                        )
                      : IconButton(
                          icon: const Icon(Icons.refresh, size: 48),
                          onPressed: () {
                            context.read<GameProvider>().resetGame();
                          },
                        ),
                ),
              ],
            ),
            AnimatedPositioned(
              duration: const Duration(milliseconds: 200),
              curve: Curves.easeInOut,
              right: _isSettingsPanelOpen
                  ? 0
                  : -MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Container(
                color: const Color.fromRGBO(225, 215, 198, 1),
                child: SettingsPanel(),
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
      child: const MaterialApp(
        debugShowCheckedModeBanner: false, // Désactive le bandeau "Debug"
        home: GameScreen(),
      ),
    ),
  );
}
