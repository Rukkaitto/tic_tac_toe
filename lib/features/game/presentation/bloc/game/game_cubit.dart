import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/entities.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({required List<String> playerNames})
      : super(GameState.initialize(size: 3, playerNames: playerNames));

  void play({
    required int playerId,
    required int index,
  }) {
    if (!state.isItMyTurn(playerId)) {
      return;
    }

    final GameGridCellValue cellValue = state.getPlayerCellValue(playerId);

    try {
      final GameGrid newGrid = state.grid.setCellValue(cellValue, index: index);

      // Switch to the next player
      final int nextPlayerId =
          (state.currentPlayerId + 1) % state.players.length;

      emit(
        state.copyWith(
          grid: newGrid,
          currentPlayerId: nextPlayerId,
        ),
      );
    } on Exception catch (error) {
      print(error);
      return;
    }
  }
}
