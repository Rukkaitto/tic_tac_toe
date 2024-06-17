import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../../../core/constants/artboards.dart';
import '../../../../core/services/asset_service/asset_service.dart';
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
      final Move move = Move(
        value: currentPlayer.cellValue,
        index: cell.index,
      );

      currentPlayer.complete(move);

      // Vibration feedback
      HapticFeedback.mediumImpact();
    }
  }

  Widget _buildIcon(GameGridCell cell) {
    return switch (cell.value) {
      GameGridCellValue.empty => const SizedBox(),
      GameGridCellValue.cross => RiveAnimation.asset(
          AssetService().rive.crossCircleLoader,
          artboard: kCrossArtboard,
        ),
      GameGridCellValue.circle => RiveAnimation.asset(
          AssetService().rive.crossCircleLoader,
          artboard: kCircleArtboard,
        )
    };
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _handleTap(context, cell: cell),
      child: Container(
        color: Colors.white,
        alignment: Alignment.center,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _buildIcon(cell),
        ),
      ),
    );
  }
}
