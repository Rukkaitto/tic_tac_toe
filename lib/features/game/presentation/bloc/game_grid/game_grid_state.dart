part of 'game_grid_cubit.dart';

typedef GameGrid = List<List<GameGridCell>>;

class GameGridState extends Equatable {
  const GameGridState(this.grid);

  factory GameGridState.initialize({required int size}) {
    return GameGridState(
      GameGrid.generate(
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

  final GameGrid grid;

  int get gridSize => grid.length;

  List<GameGridCell> get flattenedGrid =>
      grid.expand((List<GameGridCell> i) => i).toList();

  @override
  List<Object?> get props => <Object?>[grid];

  GameGridState copyWith({
    GameGrid? grid,
  }) {
    return GameGridState(
      grid ?? this.grid,
    );
  }
}
