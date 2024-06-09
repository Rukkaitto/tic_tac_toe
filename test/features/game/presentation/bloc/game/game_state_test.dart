import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/entities/entities.dart';
import 'package:tic_tac_toe/features/game/presentation/bloc/game/game_cubit.dart';

void main() {
  group('getWinner', () {
    test('should return null if there are no winners', () {
      final List<Player> players = <Player>[
        const Player(index: 0, name: 'Player 1'),
        const Player(index: 1, name: 'Player 2'),
      ];

      final GameGrid grid = GameGrid.generate(size: 3);

      final GameState state = GameState(
        grid: grid,
        players: players,
      );

      final Player? winner = state.getWinner(grid: grid, players: players);

      expect(winner, isNull);
    });

    test('should return the winner (1)', () {
      final List<Player> players = <Player>[
        const Player(index: 0, name: 'Player 1'),
        const Player(index: 1, name: 'Player 2'),
      ];

      GameGrid grid = GameGrid.generate(size: 3);

      grid = grid.setCellValue(GameGridCellValue.cross, index: 6);
      grid = grid.setCellValue(GameGridCellValue.cross, index: 7);
      grid = grid.setCellValue(GameGridCellValue.cross, index: 8);

      grid = grid.setCellValue(GameGridCellValue.circle, index: 3);
      grid = grid.setCellValue(GameGridCellValue.circle, index: 4);

      final GameState state = GameState(
        grid: grid,
        players: players,
      );

      final Player? winner = state.getWinner(grid: grid, players: players);

      expect(winner, players[0]);
    });

    test('should return the winner (2)', () {
      final List<Player> players = <Player>[
        const Player(index: 0, name: 'Player 1'),
        const Player(index: 1, name: 'Player 2'),
      ];

      GameGrid grid = GameGrid.generate(size: 3);

      grid = grid.setCellValue(GameGridCellValue.cross, index: 6);
      grid = grid.setCellValue(GameGridCellValue.cross, index: 4);
      grid = grid.setCellValue(GameGridCellValue.cross, index: 2);

      grid = grid.setCellValue(GameGridCellValue.circle, index: 7);
      grid = grid.setCellValue(GameGridCellValue.circle, index: 5);

      final GameState state = GameState(
        grid: grid,
        players: players,
      );

      final Player? winner = state.getWinner(grid: grid, players: players);

      expect(winner, players[0]);
    });

    test('should return the winner (3)', () {
      final List<Player> players = <Player>[
        const Player(index: 0, name: 'Player 1'),
        const Player(index: 1, name: 'Player 2'),
      ];

      GameGrid grid = GameGrid.generate(size: 3);

      grid = grid.setCellValue(GameGridCellValue.cross, index: 0);
      grid = grid.setCellValue(GameGridCellValue.cross, index: 4);
      grid = grid.setCellValue(GameGridCellValue.cross, index: 8);

      grid = grid.setCellValue(GameGridCellValue.circle, index: 3);
      grid = grid.setCellValue(GameGridCellValue.circle, index: 5);

      final GameState state = GameState(
        grid: grid,
        players: players,
      );

      final Player? winner = state.getWinner(grid: grid, players: players);

      expect(winner, players[0]);
    });

    test('should return the winner (4)', () {
      final List<Player> players = <Player>[
        const Player(index: 0, name: 'Player 1'),
        const Player(index: 1, name: 'Player 2'),
      ];

      GameGrid grid = GameGrid.generate(size: 3);

      grid = grid.setCellValue(GameGridCellValue.circle, index: 1);
      grid = grid.setCellValue(GameGridCellValue.circle, index: 4);
      grid = grid.setCellValue(GameGridCellValue.circle, index: 7);

      grid = grid.setCellValue(GameGridCellValue.circle, index: 3);
      grid = grid.setCellValue(GameGridCellValue.circle, index: 8);

      final GameState state = GameState(
        grid: grid,
        players: players,
      );

      final Player? winner = state.getWinner(grid: grid, players: players);

      expect(winner, players[1]);
    });

    test('should return the winner (5)', () {
      final List<Player> players = <Player>[
        const Player(index: 0, name: 'Player 1'),
        const Player(index: 1, name: 'Player 2'),
      ];

      GameGrid grid = GameGrid.generate(size: 3);

      grid = grid.setCellValue(GameGridCellValue.circle, index: 2);
      grid = grid.setCellValue(GameGridCellValue.circle, index: 5);
      grid = grid.setCellValue(GameGridCellValue.circle, index: 8);

      grid = grid.setCellValue(GameGridCellValue.circle, index: 1);
      grid = grid.setCellValue(GameGridCellValue.circle, index: 4);

      final GameState state = GameState(
        grid: grid,
        players: players,
      );

      final Player? winner = state.getWinner(grid: grid, players: players);

      expect(winner, players[1]);
    });
  });
}
