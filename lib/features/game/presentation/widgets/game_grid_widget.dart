import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';
import 'widgets.dart';

class GameGridWidget extends StatelessWidget {
  const GameGridWidget({super.key, required this.grid});

  final GameGrid grid;

  static const double _strokeWidth = 5.0;
  static const double _borderRadius = 12.0;
  static const Offset _shadowOffset = Offset(0.0, 10.0);
  static const Color _borderColor = Colors.black;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: _borderColor,
        borderRadius: BorderRadius.circular(_borderRadius),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: _shadowOffset,
          ),
        ],
      ),
      padding: const EdgeInsets.all(_strokeWidth),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(_borderRadius),
        child: ColoredBox(
          color: _borderColor,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: grid.size,
              mainAxisSpacing: _strokeWidth,
              crossAxisSpacing: _strokeWidth,
            ),
            itemCount: grid.length,
            itemBuilder: (BuildContext context, int index) {
              return GameGridCellWidget(
                cell: grid.getCell(index),
              );
            },
          ),
        ),
      ),
    );
  }
}
