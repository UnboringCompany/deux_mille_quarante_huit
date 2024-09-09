import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';
import 'tile.dart';

class GridWidget extends StatelessWidget {
  final ScrollPhysics physics;

  GridWidget({required this.physics});

  @override
  Widget build(BuildContext context) {
    final grid = context.watch<GameProvider>().grid;
    final isDyscalculicModeEnabled = context.watch<GameProvider>().isDyscalculicModeEnabled;

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

        return Tile(
          value: value,
          isDyscalculicModeEnabled: isDyscalculicModeEnabled,
        );
      },
    );
  }
}
