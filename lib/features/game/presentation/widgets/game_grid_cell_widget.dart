import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/game_grid_cell.dart';
import '../bloc/game_grid/game_grid_cubit.dart';

class GameGridCellWidget extends StatelessWidget {
  const GameGridCellWidget({super.key, required this.cell});

  final GameGridCell cell;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<GameGridCubit>().updateCell(
              cell.copyWith(
                value: GameGridCellValue.cross,
              ),
            );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(),
        ),
        child: Center(
          child: Text(
            cell.value.toString(),
            style: const TextStyle(
              fontSize: 32,
            ),
          ),
        ),
      ),
    );
  }
}
