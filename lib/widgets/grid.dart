import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

class GridWidget extends StatelessWidget {
  final ScrollPhysics physics;

  GridWidget({required this.physics});

  @override
  Widget build(BuildContext context) {
    final grid = context.watch<GameProvider>().grid;
    
    return GridView.builder(
      physics: physics, // Applique la physique ici
      padding: EdgeInsets.all(16),
      itemCount: 16,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemBuilder: (context, index) {
        final row = index ~/ 4;
        final col = index % 4;
        final value = grid[row][col];

        return Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: _getTileColor(value),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            value == 0 ? '' : '$value',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }
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
