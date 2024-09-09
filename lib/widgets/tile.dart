import 'package:flutter/material.dart';

class Tile extends StatelessWidget {
  final int value;
  final bool isDyscalculicModeEnabled;

  Tile({required this.value, required this.isDyscalculicModeEnabled});

  final Map<int, IconData> _iconMap = {
    2: Icons.circle,
    4: Icons.close,
    8: Icons.change_history,
    16: Icons.square,
    32: Icons.favorite,
    64: Icons.star,
    128: Icons.hexagon,
    256: Icons.home,
    512: Icons.cloud,
    1024: Icons.beach_access,
    2048: Icons.audiotrack,
    4096: Icons.circle_outlined,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _getTileColor(value),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Center(
        child: isDyscalculicModeEnabled
            ? Icon(
                _iconMap[value],
                size: 32.0,
                color: Colors.white,
              )
            : Text(
                value == 0 ? '': '$value',
                style: TextStyle(
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
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
  }}