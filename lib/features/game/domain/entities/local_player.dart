import 'dart:async';

import '../../presentation/bloc/game/game_cubit.dart';
import 'entities.dart';

class LocalPlayer extends Player {
  LocalPlayer({
    required super.name,
    required super.cellValue,
    required Completer<Move> completer,
  }) : _completer = completer;

  Completer<Move> _completer;

  @override
  Future<Move> play(GameState state) {
    return _completer.future;
  }

  void complete(Move move) {
    if (!_completer.isCompleted) {
      _completer.complete(move);

      // Reset the completer to allow the player to play again
      _completer = Completer<Move>();
    }
  }
}
