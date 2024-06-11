import 'dart:async';

import '../../presentation/bloc/game/game_cubit.dart';
import 'entities.dart';

class LocalPlayer extends Player {
  LocalPlayer({
    required super.name,
    required super.cellValue,
    required Completer<int> completer,
  }) : _completer = completer;

  Completer<int> _completer;

  @override
  Future<int> play(GameState state) {
    return _completer.future;
  }

  void complete(int index) {
    if (!_completer.isCompleted) {
      _completer.complete(index);

      // Reset the completer to allow the player to play again
      _completer = Completer<int>();
    }
  }
}
