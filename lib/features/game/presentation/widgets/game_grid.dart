import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game_grid/game_grid_cubit.dart';
import 'widgets.dart';

class GameGrid extends StatelessWidget {
  const GameGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameGridCubit>(
      create: (_) => GameGridCubit(),
      child: BlocBuilder<GameGridCubit, GameGridState>(
        builder: (BuildContext context, GameGridState state) {
          return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: state.gridSize,
            ),
            itemCount: state.flattenedGrid.length,
            itemBuilder: (BuildContext context, int index) {
              return GameGridCellWidget(
                cell: state.flattenedGrid[index],
              );
            },
          );
        },
      ),
    );
  }
}
