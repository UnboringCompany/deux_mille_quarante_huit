import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

class GridWidget extends StatefulWidget {
  @override
  _GridWidgetState createState() => _GridWidgetState();
}

class _GridWidgetState extends State<GridWidget> {
  List<List<int>> _grid = List.generate(4, (_) => List.filled(4, 0));

  @override
  void initState() {
    super.initState();
    _addRandomTile();
    _addRandomTile();
  }

  void _addRandomTile() {
    List<int> emptyTiles = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (_grid[i][j] == 0) {
          emptyTiles.add(i * 4 + j);
        }
      }
    }
    if (emptyTiles.isNotEmpty) {
      int randomIndex = emptyTiles[Random().nextInt(emptyTiles.length)];
      int row = randomIndex ~/ 4;
      int col = randomIndex % 4;
      _grid[row][col] = Random().nextInt(2) + 1; // 1 or 2
      setState(() {});
    }
  }

  void _moveTiles(Direction direction) {
    // Implement your tile movement logic here
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          _moveTiles(Direction.up);
        } else if (details.primaryVelocity! > 0) {
          _moveTiles(Direction.down);
        }
      },
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! < 0) {
          _moveTiles(Direction.left);
        } else if (details.primaryVelocity! > 0) {
          _moveTiles(Direction.right);
        }
      },
      child: GridView.builder(
        itemCount: 16,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
        ),
        itemBuilder: (context, index) {
          int row = index ~/ 4;
          int col = index % 4;
          return Container(
            margin: EdgeInsets.all(4),
            color: _getTileColor(_grid[row][col]),
            child: Center(
              child: Text(
                _grid[row][col] != 0 ? '${_grid[row][col]}' : '',
                style: TextStyle(fontSize: 24),
              ),
            ),
          );
        },
      ),
    );
  }

  Color? _getTileColor(int value) {
    switch (value) {
      case 0:
        return Colors.grey[300];
      case 2:
        return Colors.blue[100];
      case 4:
        return Colors.blue[200];
      case 8:
        return Colors.blue[300];
      case 16:
        return Colors.blue[400];
      case 32:
        return Colors.blue[500];
      case 64:
        return Colors.blue[600];
      case 128:
        return Colors.blue[700];
      case 256:
        return Colors.blue[800];
      case 512:
        return Colors.blue[900];
      case 1024:
        return Colors.purple;
      case 2048:
        return Colors.pink;
      default:
        return Colors.black;
    }
  }
}

enum Direction { up, down, left, right }
