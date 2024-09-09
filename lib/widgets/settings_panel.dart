import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

class SettingsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();

    return Container(
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Settings',
            style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 16.0),
          SwitchListTile(
            title: Text('Mode Dyscalculique'),
            value: gameProvider.isDyscalculicModeEnabled,
            onChanged: (value) {
              gameProvider.isDyscalculicModeEnabled = value;
              gameProvider.notifyListeners();
            },
          ),
        ],
      ),
    );
  }
}
