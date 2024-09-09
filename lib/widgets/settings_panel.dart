import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'game_provider.dart';

class SettingsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final gameProvider = context.watch<GameProvider>();

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Settings',
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.w900,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 16.0),
          SwitchListTile(
            title: const Text('Mode Dyscalculique',
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                )),
            value: gameProvider.isDyscalculicModeEnabled,
            activeColor: Colors.blueAccent,
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
