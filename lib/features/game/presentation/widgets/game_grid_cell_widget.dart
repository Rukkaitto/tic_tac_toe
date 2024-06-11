import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../bloc/game/game_cubit.dart';

class GameGridCellWidget extends StatelessWidget {
  const GameGridCellWidget({super.key, required this.cell});

  final GameGridCell cell;

  void _handleTap(
    BuildContext context, {
    required GameGridCell cell,
  }) {
    final Player currentPlayer = context.read<GameCubit>().state.currentPlayer;

    if (currentPlayer is LocalPlayer) {
      currentPlayer.complete(cell.index);

      // Vibration feedback
      HapticFeedback.mediumImpact();
    }
  }

  Widget _buildIcon(GameGridCell cell, {required double size}) {
    return switch (cell.value) {
      GameGridCellValue.empty => const SizedBox(),
      GameGridCellValue.cross => Icon(Icons.close, size: size),
      GameGridCellValue.circle => Icon(Icons.circle_outlined, size: size),
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context, cell: cell),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Center(
          child: _buildIcon(cell, size: 70.0),
        ),
      ),
    );
  }
}
