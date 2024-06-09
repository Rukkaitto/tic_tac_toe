import 'package:bloc/bloc.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:logging/logging.dart';

import '../../../domain/entities/entities.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({required List<String> playerNames})
      : super(GameState.initialize(size: 3, playerNames: playerNames));

  final Logger log = Logger('GameCubit');

  void play({
    required int playerId,
    required int index,
  }) {
    if (!state.canIPlay(playerId)) {
      return;
    }

    final GameGridCellValue cellValue = state.getPlayerCellValue(playerId);

    try {
      final GameGrid newGrid = state.grid.setCellValue(cellValue, index: index);

      final Player? winner =
          state.getWinner(grid: newGrid, players: state.players);

      final bool isGameOver = winner != null || newGrid.isFull;

      int? nextPlayerId;

      if (!isGameOver) {
        // Switch to the next player
        nextPlayerId = (state.currentPlayerId + 1) % state.players.length;
      }

      emit(
        state.copyWith(
          grid: newGrid,
          currentPlayerId: nextPlayerId,
          winner: winner,
          isGameOver: isGameOver,
        ),
      );
    } on Exception catch (error) {
      log.warning(error);
      return;
    }
  }

  void reset() {
    emit(
      GameState.initialize(
        size: state.grid.size,
        playerNames: state.players.map((Player player) => player.name).toList(),
      ),
    );
  }
}
