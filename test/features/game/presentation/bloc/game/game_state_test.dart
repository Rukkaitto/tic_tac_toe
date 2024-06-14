import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/entities/entities.dart';
import 'package:tic_tac_toe/features/game/presentation/bloc/game/game_cubit.dart';

void main() {
  late Player player1;
  late Player player2;
  late GameState state;

  setUp(() {
    final GameGrid grid = GameGrid.generate(size: 3);

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
      grid: grid,
      currentPlayer: player1,
      player1: player1,
      player2: player2,
    );
  });

  group('GameState.initialize', () {
    test('should generate a new GameState', () {
      final GameState state = GameState.initialize(
        size: 3,
        player1: LocalPlayer(
          name: 'Player 1',
          cellValue: GameGridCellValue.cross,
          completer: Completer<Move>(),
        ),
        player2: LocalPlayer(
          name: 'Player 2',
          cellValue: GameGridCellValue.circle,
          completer: Completer<Move>(),
        ),
      );

      expect(state.grid.size, 3);
      expect(state.player1.name, 'Player 1');
      expect(state.player2.name, 'Player 2');
      expect(state.currentPlayer, state.player1);
      expect(state.isGameOver, false);
      expect(state.winner, isNull);
    });
  });

  group('getWinner', () {
    test('should return null if there are no winners', () {
      final Player? winner = state.getWinner(
        grid: state.grid,
        player1: state.player1,
        player2: state.player2,
      );

      expect(winner, isNull);
    });

    test('should return the winner (1)', () {
      GameGrid grid = state.grid;

      grid = grid.applyMove(
        const Move(value: GameGridCellValue.cross, index: 6),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.cross, index: 7),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.cross, index: 8),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 3),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 4),
      );

      state = state.copyWith(grid: grid);

      final Player? winner = state.getWinner(
        grid: grid,
        player1: state.player1,
        player2: state.player2,
      );

      expect(winner, state.player1);
    });

    test('should return the winner (2)', () {
      GameGrid grid = state.grid;

      grid = grid.applyMove(
        const Move(value: GameGridCellValue.cross, index: 6),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.cross, index: 4),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.cross, index: 2),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 7),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 5),
      );

      state = state.copyWith(grid: grid);

      final Player? winner = state.getWinner(
        grid: grid,
        player1: state.player1,
        player2: state.player2,
      );

      expect(winner, state.player1);
    });

    test('should return the winner (3)', () {
      GameGrid grid = state.grid;

      grid = grid.applyMove(
        const Move(value: GameGridCellValue.cross, index: 0),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.cross, index: 4),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.cross, index: 8),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 3),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 5),
      );

      state = state.copyWith(grid: grid);

      final Player? winner = state.getWinner(
        grid: grid,
        player1: state.player1,
        player2: state.player2,
      );

      expect(winner, state.player1);
    });

    test('should return the winner (4)', () {
      GameGrid grid = state.grid;

      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 1),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 4),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 7),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 3),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 8),
      );

      state = state.copyWith(grid: grid);

      final Player? winner = state.getWinner(
        grid: grid,
        player1: state.player1,
        player2: state.player2,
      );

      expect(winner, state.player2);
    });

    test('should return the winner (5)', () {
      GameGrid grid = state.grid;

      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 2),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 5),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 8),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 1),
      );
      grid = grid.applyMove(
        const Move(value: GameGridCellValue.circle, index: 4),
      );

      state = state.copyWith(grid: grid);

      final Player? winner = state.getWinner(
        grid: grid,
        player1: state.player1,
        player2: state.player2,
      );

      expect(winner, state.player2);
    });
  });
}
