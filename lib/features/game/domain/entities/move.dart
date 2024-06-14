import 'entities.dart';

class Move {
  const Move({
    required this.value,
    required this.index,
  });

  final GameGridCellValue value;
  final int index;

  /// Returns `true` if the move is valid.
  bool isValid(GameGrid grid) {
    final bool isCellOutOfBounds = index >= grid.length;

    if (isCellOutOfBounds) {
      return false;
    }

    final bool isCellAtIndexEmpty =
        grid.getCell(index).value == GameGridCellValue.empty;

    if (!isCellAtIndexEmpty) {
      return false;
    }

    return true;
  }
}
