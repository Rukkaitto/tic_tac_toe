import 'dart:async';

import '../../presentation/bloc/game/game_cubit.dart';
import 'entities.dart';

class LocalPlayer extends Player {
  LocalPlayer({
    required super.name,
    required super.cellValue,
    required this.completer,
  });

  Completer<int> completer;

  @override
  Future<int> play(GameState state) async {
    final Completer<int> completer = Completer<int>();
    this.completer = completer;

    return completer.future;
  }
}
