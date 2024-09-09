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

    gameProvider.onGameOver = () {
      _showGameOverDialog(context);
    };

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
            Future.delayed(Duration(milliseconds: 500), () {
              gameProvider.nextTurn();
            });
          } else if (details.velocity.pixelsPerSecond.dx < 0) {
            gameProvider.moveLeft();
            Future.delayed(Duration(milliseconds: 500), () {
              gameProvider.nextTurn();
            });
          }
        },
        onVerticalDragEnd: (details) {
          if (details.velocity.pixelsPerSecond.dy > 0) {
            gameProvider.moveDown();
            gameProvider.nextTurn();
          } else if (details.velocity.pixelsPerSecond.dy < 0) {
            gameProvider.moveUp();
            Future.delayed(Duration(milliseconds: 500), () {
              gameProvider.nextTurn();
            });
          }
        },
        child: Stack(
          children: [
            Column(
              children: [
                ScoreWidget(),
                Expanded(
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
    );
  }

  void _showGameOverDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Vous avez perdu !"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              // Réinitialiser le jeu ou autres actions
              context.read<GameProvider>().resetGame();
            },
            child: Text("Rejouer"),
          ),
        ],
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
