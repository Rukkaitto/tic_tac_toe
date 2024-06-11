import 'dart:async';
import 'dart:math';

import '../../presentation/bloc/game/game_cubit.dart';
import 'entities.dart';

class ComputerPlayer extends Player {
  ComputerPlayer({
    required super.cellValue,
    required this.difficulty,
  }) : super(name: 'CPU');

  final Random _random = Random();
  final ComputerPlayerDifficulty difficulty;

  int _evaluate(GameState state, int depth) {
    if (state.isGameOver) {
      if (state.winner == null) {
        return 0;
      } else if (state.winner == this) {
        return 10 - depth;
      } else {
        return depth - 10;
      }
    }

    return 0;
  }

  int _minimax(GameState state, int depth, bool isMax) {
    // Limits the depth of the search depending on the difficulty
    switch (difficulty) {
      case ComputerPlayerDifficulty.easy:
        if (depth == 0) {
          return _evaluate(state, depth);
        }
      case ComputerPlayerDifficulty.medium:
        if (depth == 1) {
          return _evaluate(state, depth);
        }
      case ComputerPlayerDifficulty.hard:
        if (depth == 2) {
          return _evaluate(state, depth);
        }
    }

    if (isMax) {
      int bestScore = -1000;

      for (int i = 0; i < state.grid.length; i++) {
        if (state.grid.getCell(i).value == GameGridCellValue.empty) {
          final GameGrid newGrid = state.grid.setCellValue(cellValue, index: i);

          final Player? winner = state.getWinner(
            grid: newGrid,
            player1: state.player1,
            player2: state.player2,
          );

          final bool isGameOver = winner != null || newGrid.isFull;

          final GameState newState = state.copyWith(
            grid: newGrid,
            isGameOver: isGameOver,
            winner: winner,
          );

          final int score = _minimax(newState, depth + 1, !isMax);

          bestScore = max(score, bestScore);
        }
      }

      return bestScore;
    } else {
      int bestScore = 1000;

      for (int i = 0; i < state.grid.length; i++) {
        if (state.grid.getCell(i).value == GameGridCellValue.empty) {
          final Player opponent = state.player1.cellValue == cellValue
              ? state.player2
              : state.player1;

          final GameGrid newGrid =
              state.grid.setCellValue(opponent.cellValue, index: i);

          final Player? winner = state.getWinner(
            grid: newGrid,
            player1: state.player1,
            player2: state.player2,
          );

          final bool isGameOver = winner != null || newGrid.isFull;

          final GameState newState = state.copyWith(
            grid: newGrid,
            isGameOver: isGameOver,
            winner: winner,
          );

          final int score = _minimax(newState, depth + 1, !isMax);

          bestScore = min(score, bestScore);
        }
      }

      return bestScore;
    }
  }

  int _findRandomMove(GameState state) {
    final List<int> emptyCells = <int>[];

    for (int i = 0; i < state.grid.length; i++) {
      if (state.grid.getCell(i).value == GameGridCellValue.empty) {
        emptyCells.add(i);
      }
    }

    return emptyCells[_random.nextInt(emptyCells.length)];
  }

  int _findBestMove(GameState state) {
    int bestScore = -1000;
    int bestMove = -1;

    for (int i = 0; i < state.grid.length; i++) {
      if (state.grid.getCell(i).value == GameGridCellValue.empty) {
        final GameGrid newGrid = state.grid.setCellValue(cellValue, index: i);

        final GameState newState = state.copyWith(grid: newGrid);

        final int score = _minimax(newState, 0, false);

        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }

    return bestMove;
  }

  @override
  Future<int> play(GameState state) async {
    // Wait for a random duration to simulate thinking (between 1 and 2 seconds)
    //await Future<void>.delayed(Duration(seconds: _random.nextInt(2) + 1));

    int move;

    if (difficulty == ComputerPlayerDifficulty.easy) {
      move = _findRandomMove(state);
    } else {
      move = _findBestMove(state);
    }

    return move;
  }
}
