import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/entities/entities.dart';
import 'package:tic_tac_toe/features/game/presentation/bloc/game/game_cubit.dart';

void main() {
  group('GameState.initialize', () {
    test('should generate a new GameState', () {
      final GameState state = GameState.initialize(
        size: 3,
        playerNames: const <String>['Player 1', 'Player 2'],
      );

      expect(state.grid.size, 3);
      expect(state.players.length, 2);
      expect(state.players[0].name, 'Player 1');
      expect(state.players[0].index, 0);
      expect(state.players[1].name, 'Player 2');
      expect(state.players[1].index, 1);
      expect(state.currentPlayerId, 0);
      expect(state.isGameOver, false);
      expect(state.winner, isNull);
    });
  });

  group('canIPlay', () {
    test("should return true if it is the given player's turn", () {
      final GameState state = GameState(
        grid: GameGrid.generate(size: 3),
        players: const <Player>[
          Player(index: 0, name: 'Player 1'),
          Player(index: 1, name: 'Player 2'),
        ],
      );

      final bool canIPlay = state.canIPlay(0);

      expect(canIPlay, true);
    });

    test("should return false if it is not the given player's turn", () {
      final GameState state = GameState(
        grid: GameGrid.generate(size: 3),
        players: const <Player>[
          Player(index: 0, name: 'Player 1'),
          Player(index: 1, name: 'Player 2'),
        ],
        currentPlayerId: 1,
      );

      final bool canIPlay = state.canIPlay(0);

      expect(canIPlay, false);
    });
  });

  group('getPlayerCellValue', () {
    test('should return the correct cell value (1)', () {
      final GameState state = GameState(
        grid: GameGrid.generate(size: 3),
        players: const <Player>[
          Player(index: 0, name: 'Player 1'),
          Player(index: 1, name: 'Player 2'),
        ],
      );

      final GameGridCellValue cellValue = state.getPlayerCellValue(0);

      expect(cellValue, GameGridCellValue.cross);
    });

    test('should return the correct cell value (2)', () {
      final GameState state = GameState(
        grid: GameGrid.generate(size: 3),
        players: const <Player>[
          Player(index: 0, name: 'Player 1'),
          Player(index: 1, name: 'Player 2'),
        ],
      );

      final GameGridCellValue cellValue = state.getPlayerCellValue(1);

      expect(cellValue, GameGridCellValue.circle);
    });
  });

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
