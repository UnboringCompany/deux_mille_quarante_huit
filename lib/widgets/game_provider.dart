import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class GameProvider with ChangeNotifier {
  List<List<int>> grid = List.generate(4, (_) => List.generate(4, (_) => 0));
  int score = 0;
  bool isDyscalculicModeEnabled = false;
  int bestScore = 0;
  bool isGameOver = false;


  GameProvider() {
    resetGame();
    _loadBestScore();
  }

  Future<void> _loadBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    bestScore = prefs.getInt('bestScore') ?? 0;  // 0 si aucune valeur n'est encore enregistrée
    notifyListeners();
  }

  Future<void> _saveBestScore() async {
    final prefs = await SharedPreferences.getInstance();
    if (score > bestScore) {
      bestScore = score;
      await prefs.setInt('bestScore', bestScore);
      notifyListeners();
    }
  }

  void resetGame() {
    grid = List.generate(4, (_) => List.generate(4, (_) => 0));
    score = 0;
    isGameOver = false;
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

  void move(Function getLine, Function setLine) {
    bool hasChanged = false;

    for (int i = 0; i < 4; i++) {
      List<int> originalLine = getLine(i);
      List<int> newLine = _slideAndMerge(originalLine);
      if (!listEquals(originalLine, newLine)) {
        hasChanged = true;
      }
      setLine(i, newLine);
    }

    if (hasChanged) {
      nextTurn();
    }
  }

  void moveLeft() {
    move((i) => grid[i], (i, newLine) => grid[i] = newLine);
  }

  void moveRight() {
    move(
      (i) => grid[i].reversed.toList(),
      (i, newLine) => grid[i] = newLine.reversed.toList(),
    );
  }

  void moveUp() {
    move(
      (i) => List.generate(4, (j) => grid[j][i]),
      (i, newColumn) {
        for (int j = 0; j < 4; j++) {
          grid[j][i] = newColumn[j];
        }
      },
    );
  }

  void moveDown() {
    move(
      (i) => List.generate(4, (j) => grid[j][i]).reversed.toList(),
      (i, newColumn) {
        for (int j = 0; j < 4; j++) {
          grid[j][i] = newColumn.reversed.toList()[j];
        }
      },
    );
  }

  List<int> _slideAndMerge(List<int> line) {
    line = line.where((e) => e != 0).toList(); // Enlever les zéros
    for (int i = 0; i < line.length - 1; i++) {
      if (line[i] == line[i + 1]) {
        line[i] = line[i] * 2;
        score += line[i];
        line[i + 1] = 0;
      }
    }
    line = line.where((e) => e != 0).toList();
    return List.generate(4, (i) => i < line.length ? line[i] : 0);
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
    // Add a delay before spawning a new tile
    Future.delayed(const Duration(milliseconds: 150), () {
      _spawnRandom();
      notifyListeners();

      if (_isGameOver()) {
        isGameOver = true;
      }

      _saveBestScore();
    });
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
              resetGame(); // Reset du jeu après la défaite
            },
            child: Text("Rejouer"),
          ),
        ],
      ),
    );
  }
  
  void toggleDyscalculicMode() {
    isDyscalculicModeEnabled = !isDyscalculicModeEnabled;
    notifyListeners();
  }
}
