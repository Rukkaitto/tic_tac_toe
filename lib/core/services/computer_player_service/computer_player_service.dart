import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/game/domain/entities/entities.dart';
import '../../../features/game/presentation/bloc/game/game_cubit.dart';

class ComputerPlayerService {
  final Random _random = Random();

  Future<void> makeMove(BuildContext context) async {
    final GameCubit gameCubit = context.read<GameCubit>();

    // Wait for a random duration to simulate thinking (between 1 and 2 seconds)
    await Future<void>.delayed(Duration(seconds: _random.nextInt(2) + 1));

    final int bestMove = _findBestMove(gameCubit.state);

    gameCubit.play(playerId: 1, index: bestMove);
  }

  int _getScore(GameState state, int depth) {
    if (state.isGameOver) {
      if (state.winner == null) {
        return 0;
      } else if (state.winner?.index == 1) {
        return 10 - depth;
      } else if (state.winner?.index == 0) {
        return depth - 10;
      }
    }

    return 0;
  }

  int _minimax(GameState state, int depth, bool isMax) {
    if (state.isGameOver) {
      return _getScore(state, depth);
    }

    if (isMax) {
      int bestScore = -1000;

      for (int i = 0; i < state.grid.length; i++) {
        if (state.grid.getCell(i).value == GameGridCellValue.empty) {
          final GameGrid newGrid =
              state.grid.setCellValue(GameGridCellValue.circle, index: i);

          final Player? winner =
              state.getWinner(grid: newGrid, players: state.players);

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
          final GameGrid newGrid =
              state.grid.setCellValue(GameGridCellValue.cross, index: i);

          final Player? winner =
              state.getWinner(grid: newGrid, players: state.players);

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

  int _findBestMove(GameState state) {
    int bestScore = -1000;
    int bestMove = -1;

    for (int i = 0; i < state.grid.length; i++) {
      if (state.grid.getCell(i).value == GameGridCellValue.empty) {
        final GameGrid newGrid =
            state.grid.setCellValue(GameGridCellValue.circle, index: i);

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
}
