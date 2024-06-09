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
    try {
      emit(state.play(playerId: playerId, index: index));
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
