import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/entities/entities.dart';
import 'package:tic_tac_toe/features/game/presentation/bloc/game/game_cubit.dart';

void main() {
  late Player player1;
  late Player player2;
  late GameState state;

  setUp(() {
    player1 = LocalPlayer(
      name: 'Player 1',
      cellValue: GameGridCellValue.cross,
      completer: Completer<Move>(),
    );

    player2 = LocalPlayer(
      name: 'Player 2',
      cellValue: GameGridCellValue.circle,
      completer: Completer<Move>(),
    );

    state = GameState(
      grid: GameGrid.generate(size: 3),
      currentPlayer: player1,
      player1: player1,
      player2: player2,
    );
  });

  group('canPlay', () {
    test('should return true if the player can play', () {
      expect(player1.canPlay(state), true);
    });

    test('should return false if the player cannot play', () {
      expect(player2.canPlay(state), false);
    });
  });

  group('getOpponent', () {
    test('should return the opponent of the player', () {
      expect(player1.getOpponent(state), player2);
      expect(player2.getOpponent(state), player1);
    });
  });
}
