import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/game_grid_cell.dart';

part 'game_grid_state.dart';

class GameGridCubit extends Cubit<GameGridState> {
  GameGridCubit() : super(GameGridState.initialize(size: 3));

  void updateCell(GameGridCell cell) {
    final GameGrid copiedGrid = <List<GameGridCell>>[
      for (final List<GameGridCell> sublist in state.grid)
        <GameGridCell>[...sublist],
    ];

    final bool isCellOutOfBounds = cell.x < 0 ||
        cell.x >= state.gridSize ||
        cell.y < 0 ||
        cell.y >= state.gridSize;

    if (isCellOutOfBounds) {
      return;
    }

    copiedGrid[cell.x][cell.y] = cell;

    emit(state.copyWith(grid: copiedGrid));
  }
}
