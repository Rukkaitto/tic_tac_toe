import 'dart:async';

import '../../presentation/bloc/game/game_cubit.dart';
import 'entities.dart';

abstract class Player {
  const Player({
    required this.name,
    required this.cellValue,
  });

  final String name;
  final GameGridCellValue cellValue;

  Future<int> play(GameState state);
}
