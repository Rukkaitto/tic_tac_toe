import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import '../../../domain/entities/entities.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required Player player1,
    required Player player2,
  }) : super(
          GameState.initialize(
            size: 3,
            player1: player1,
            player2: player2,
          ),
        );

  final Logger log = Logger('GameCubit');

  Future<void> startGame() async {
    await Future.doWhile(() async {
      // Wait for the current player to make a move
      final Move move = await state.currentPlayer.play(state);

      // Check if the move is valid
      if (move.isValid(state.grid)) {
        // Update the grid with the new move
        final GameGrid newGrid = state.grid.applyMove(move);

        // Check if the game is over
        final Player? winner = state.getWinner(
          grid: newGrid,
          player1: state.player1,
          player2: state.player2,
        );

        final bool isGameOver = winner != null || newGrid.isFull;

        // Update the state
        emit(
          state.copyWith(
            grid: newGrid,
            currentPlayer: state.currentPlayer == state.player1
                ? state.player2
                : state.player1,
            winner: winner,
            isGameOver: isGameOver,
          ),
        );
      }

      return !state.isGameOver;
    });
  }

  void resetGame() {
    emit(
      GameState.initialize(
        size: 3,
        player1: state.player1,
        player2: state.player2,
      ),
    );

    startGame();
  }
}
