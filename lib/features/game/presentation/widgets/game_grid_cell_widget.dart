import 'package:flutter/material.dart';

import '../../domain/entities/game_grid_cell.dart';

class GameGridCellWidget extends StatelessWidget {
  const GameGridCellWidget({super.key, required this.cell});

  final GameGridCell cell;

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
