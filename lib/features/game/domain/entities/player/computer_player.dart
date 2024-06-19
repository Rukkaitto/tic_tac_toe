import 'dart:async';
import 'dart:math';

import '../../../presentation/bloc/game/game_cubit.dart';
import '../entities.dart';

class ComputerPlayer extends Player {
  ComputerPlayer({
    required super.cellValue,
    ComputerPlayerDifficulty? difficulty,
    required super.name,
  }) : difficulty = difficulty ?? ComputerPlayerDifficulty.easy;

  final Random _random = Random();
  final ComputerPlayerDifficulty difficulty;

  int _evaluate(GameState state, int depth) {
    if (state.isGameOver) {
      if (state.winner == null) {
        return 0;
      } else if (state.winner == this) {
        return 10 - depth;
      } else if (state.winner == getOpponent(state)) {
        return depth - 10;
      }
    }

    return 0;
  }

  /// Sources:
  /// - https://www.neverstopbuilding.com/blog/minimax
  /// - https://en.wikipedia.org/wiki/Minimax
  int _minimax(GameState state, int depth, bool isMax) {
    if (state.isGameOver) {
      return _evaluate(state, depth);
    }

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
          final Move move = Move(
            value: cellValue,
            index: i,
          );

          final GameGrid newGrid = state.grid.applyMove(move);

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
          final Move move = Move(
            value: getOpponent(state).cellValue,
            index: i,
          );

          final GameGrid newGrid = state.grid.applyMove(move);

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

  Move _findRandomMove(GameState state) {
    final List<int> emptyCells = <int>[];

    for (int i = 0; i < state.grid.length; i++) {
      if (state.grid.getCell(i).value == GameGridCellValue.empty) {
        emptyCells.add(i);
      }
    }

    final int randomIndex = _random.nextInt(emptyCells.length);

    return Move(
      value: cellValue,
      index: emptyCells[randomIndex],
    );
  }

  Move _findBestMove(GameState state) {
    int bestScore = -1000;
    Move bestMove = Move(value: cellValue, index: -1);

    for (int i = 0; i < state.grid.length; i++) {
      if (state.grid.getCell(i).value == GameGridCellValue.empty) {
        final Move move = Move(
          value: cellValue,
          index: i,
        );

        final GameGrid newGrid = state.grid.applyMove(move);

        final GameState newState = state.copyWith(grid: newGrid);

        final int score = _minimax(newState, 0, false);

        if (score > bestScore) {
          bestScore = score;
          bestMove = move;
        }
      }
    }

    return bestMove;
  }

  @override
  Future<Move> play(GameState state) async {
    // Wait for a random duration to simulate thinking (between 1 and 2 seconds)
    await Future<void>.delayed(Duration(seconds: _random.nextInt(2) + 1));

    Move move;

    if (difficulty == ComputerPlayerDifficulty.easy) {
      move = _findRandomMove(state);
    } else {
      move = _findBestMove(state);
    }

    return move;
  }
}
