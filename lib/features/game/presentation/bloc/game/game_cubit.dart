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
      final int move = await state.currentPlayer.play(state);

      if (state.grid.isMoveValid(move)) {
        final GameGrid newGrid = state.grid.setCellValue(
          state.currentPlayer.cellValue,
          index: move,
        );

        final Player? winner = state.getWinner(
          grid: newGrid,
          player1: state.player1,
          player2: state.player2,
        );

        final bool isGameOver = winner != null || newGrid.isFull;

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
}
