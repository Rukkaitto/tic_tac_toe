part of 'game_grid_cubit.dart';

class GameGridState extends Equatable {
  const GameGridState(this.grid);

  factory GameGridState.initialize({required int size}) {
    return GameGridState(
      List<List<GameGridCell>>.generate(
        size,
        (int x) => List<GameGridCell>.generate(
          size,
          (int y) => GameGridCell(
            GameGridCellValue.empty,
            x: x,
            y: y,
          ),
        ),
      ),
    );
  }

  final List<List<GameGridCell>> grid;

  int get gridSize => grid.length;

  List<GameGridCell> get flattenedGrid =>
      grid.expand((List<GameGridCell> i) => i).toList();

  @override
  List<Object> get props => <Object>[grid];

  GameGridState copyWith({
    List<List<GameGridCell>>? grid,
  }) {
    return GameGridState(
      grid ?? this.grid,
    );
  }
}
