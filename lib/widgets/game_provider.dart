import 'dart:math';
import 'package:flutter/material.dart';

class GameProvider with ChangeNotifier {
  List<List<int>> grid = List.generate(4, (_) => List.generate(4, (_) => 0));
  int score = 0;
  VoidCallback onGameOver = () {};

  GameProvider() {
    resetGame();
  }

  void resetGame() {
    grid = List.generate(4, (_) => List.generate(4, (_) => 0));
    score = 0;
    _spawnRandom();
    _spawnRandom();
    notifyListeners();
  }

  void _spawnRandom() {
    final emptyTiles = <Point<int>>[];
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        if (grid[row][col] == 0) {
          emptyTiles.add(Point(row, col));
        }
      }
    }

    if (emptyTiles.isNotEmpty) {
      final randomTile = emptyTiles[Random().nextInt(emptyTiles.length)];
      grid[randomTile.x][randomTile.y] = Random().nextInt(10) == 0 ? 4 : 2;
      notifyListeners();
    }
  }

  void moveLeft() {
    for (int row = 0; row < 4; row++) {
      grid[row] = _slideAndMerge(grid[row]);
    }
  }

  void moveRight() {
    for (int row = 0; row < 4; row++) {
      grid[row] = _slideAndMerge(grid[row].reversed.toList()).reversed.toList();
    }
  }

  void moveUp() {
    for (int col = 0; col < 4; col++) {
      List<int> column = List.generate(4, (i) => grid[i][col]);
      List<int> newColumn = _slideAndMerge(column);
      for (int row = 0; row < 4; row++) {
        grid[row][col] = newColumn[row];
      }
    }
  }

  void moveDown() {
    for (int col = 0; col < 4; col++) {
      List<int> column = List.generate(4, (i) => grid[i][col]);
      List<int> newColumn = _slideAndMerge(column.reversed.toList()).reversed.toList();
      for (int row = 0; row < 4; row++) {
        grid[row][col] = newColumn[row];
      }
    }
  }

  List<int> _slideAndMerge(List<int> row) {
    row = row.where((e) => e != 0).toList(); // Enlever les zéros
    for (int i = 0; i < row.length - 1; i++) {
      if (row[i] == row[i + 1]) {
        row[i] = row[i] * 2;
        score += row[i];
        row[i + 1] = 0;
      }
    }
    row = row.where((e) => e != 0).toList();
    return List.generate(4, (i) => i < row.length ? row[i] : 0);
  }

  bool _isGridFull() {
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        if (grid[row][col] == 0) {
          return false;  // Il y a encore de la place
        }
      }
    }
    return true;
  }

  void nextTurn() {
    _spawnRandom();
    notifyListeners();

    if (_isGameOver() && onGameOver != null) {
      onGameOver();
    }
  }

  bool _canMergeTiles() {
    for (int row = 0; row < 4; row++) {
      for (int col = 0; col < 4; col++) {
        int current = grid[row][col];
        // Vérifier à droite
        if (col < 3 && grid[row][col + 1] == current) {
          return true;
        }
        // Vérifier en bas
        if (row < 3 && grid[row + 1][col] == current) {
          return true;
        }
      }
    }
    return false;
  }

  bool _isGameOver() {
    if (!_isGridFull() || _canMergeTiles()) {
      return false;  // Si la grille n'est pas pleine ou des fusions sont possibles, pas de défaite
    }
    return true;  // Sinon, la partie est terminée
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
            // Reset du jeu ou d'autres actions
          },
          child: Text("Rejouer"),
        ),
      ],
    ),
  );
}


}
