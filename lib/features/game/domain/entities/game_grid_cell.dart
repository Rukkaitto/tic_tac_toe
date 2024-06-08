enum GameGridCellValue {
  empty,
  cross,
  circle,
}

class GameGridCell {
  const GameGridCell(
    this.value, {
    required this.x,
    required this.y,
  });

  final GameGridCellValue value;
  final int x;
  final int y;
}
