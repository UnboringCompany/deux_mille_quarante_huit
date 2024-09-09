# deux_mille_quarante_huit

Class project to implement the game 2048.

## Getting Started

This new game proposed by the Unboring company will let you dive in the famous game 2048. You'll be able to merge tiles to score a maximum points. Your aim will be to reach the famoius 2048 tile. If you don't like numbers or if you are dyscalculic, no problem, you can enable the dyscalculic mode in the settings and replace numbers by icons.

## Implementation

To create this game, we used a **Game Provider** that handles the game logic, such as moving the tiles, merging them, spawning new tiles, and checking for game over conditions. The GameProvider class extends the ChangeNotifier class, which allows it to notify its listeners when the game state changes.

Then we added multiples widgets to interact : 
- **Tile widget:** The Tile widget is responsible for displaying a single tile in the game grid. It takes the tile value as a parameter and displays the corresponding number or icon based on the game mode (normal or dyslexic). The Tile widget is typically used within the Grid widget to display each tile in the game grid.
- **Grid widget:** The Grid widget is responsible for displaying the game grid and its tiles. It uses a GridView.builder to create a grid of Tile widgets based on the current state of the game grid. The Grid widget is typically used within the GameScreen widget to display the game grid.
- **Score widget**: The Score widget is responsible for displaying the current score of the game. It typically uses the Provider package to access the GameProvider instance and display the current score. The Score widget is typically used within the GameScreen widget to display the score above the game grid.
- **SettingsPanel widget:** The SettingsPanel widget is responsible for displaying the game settings and allowing the user to toggle the dyslexic mode. It typically uses the Provider package to access the GameProvider instance and update the dyslexic mode setting. The SettingsPanel widget is typically used within the GameScreen widget to display the settings panel when the user taps the settings icon in the app bar.

## Date
09/09/2024

## Team
[Léo Wadin](https://github.com/ArKc0s)<br>
[Elena Beylat](https://github.com/PetitCheveu)<br>
