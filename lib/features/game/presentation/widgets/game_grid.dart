import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/game/game_cubit.dart';
import 'widgets.dart';

class GameGrid extends StatelessWidget {
  const GameGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GameCubit, GameState>(
      builder: (BuildContext context, GameState state) {
        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: state.grid.size,
          ),
          itemCount: state.grid.length,
          itemBuilder: (BuildContext context, int index) {
            return GameGridCellWidget(
              cell: state.grid.getCell(index),
            );
          },
        );
      },
    );
  }
}
