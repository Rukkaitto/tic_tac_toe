import 'package:flutter/material.dart';

import '../../domain/entities/entities.dart';
import 'widgets.dart';

class GameGridWidget extends StatelessWidget {
  const GameGridWidget({super.key, required this.grid});

  final GameGrid grid;

  static const double kStrokeWidth = 5.0;
  static const double kBorderRadius = 12.0;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(kBorderRadius),
        boxShadow: const <BoxShadow>[
          BoxShadow(
            offset: Offset(0.0, 10.0),
          ),
        ],
      ),
      padding: const EdgeInsets.all(kStrokeWidth),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(kBorderRadius),
        child: ColoredBox(
          color: Colors.black,
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: EdgeInsets.zero,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: grid.size,
              mainAxisSpacing: kStrokeWidth,
              crossAxisSpacing: kStrokeWidth,
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
