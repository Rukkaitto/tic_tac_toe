import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';
import 'widgets.dart';

class GameGridWidget extends StatelessWidget {
  const GameGridWidget({super.key, required this.grid});

  final GameGrid grid;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: grid.size,
      ),
      itemCount: grid.length,
      itemBuilder: (BuildContext context, int index) {
        return GameGridCellWidget(
          cell: grid.getCell(index),
        );
      },
    );
  }
}
