import 'dart:async';

import '../../../presentation/bloc/game/game_cubit.dart';
import '../entities.dart';

abstract class Player {
  const Player({
    required this.name,
    required this.cellValue,
  });

  final String name;
  final GameGridCellValue cellValue;

  Future<Move> play(GameState state);

  /// Returns `true` if the player can play in the current state.
  bool canPlay(GameState state) {
    return this == state.currentPlayer && !state.isGameOver;
  }

  /// Returns the opponent of the player.
  Player getOpponent(GameState state) =>
      this == state.player1 ? state.player2 : state.player1;
}
