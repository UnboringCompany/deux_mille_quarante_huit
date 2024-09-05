import 'package:flutter/material.dart';

class GameProvider extends ChangeNotifier {
  int _score = 0;

  int get score => _score;

  void addScore(int points) {
    _score += points;
    notifyListeners();
  }
}
