import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../features/game/presentation/bloc/game/game_cubit.dart';

class ComputerPlayerService {
  final Random _random = Random();

  Future<void> makeMove(BuildContext context) async {
    final GameCubit gameCubit = context.read<GameCubit>();

    // Wait for a random duration to simulate thinking (between 1 and 3 seconds)
    await Future<void>.delayed(Duration(seconds: _random.nextInt(3) + 1));

    // Find all valid moves
    final List<int> validCellIndices = <int>[];
    for (int i = 0; i < gameCubit.state.grid.length; i++) {
      if (gameCubit.state.grid.isMoveValid(i)) {
        validCellIndices.add(i);
      }
    }

    // If there are no valid moves, return
    if (validCellIndices.isEmpty) {
      return;
    }

    // Get a random valid move
    final int randomIndex =
        validCellIndices[_random.nextInt(validCellIndices.length)];

    // Make the move
    gameCubit.play(playerId: 1, index: randomIndex);
  }
}
