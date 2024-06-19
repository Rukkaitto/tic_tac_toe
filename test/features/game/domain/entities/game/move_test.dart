import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/entities/entities.dart';

void main() {
  late GameGrid grid;

  setUp(() {
    grid = GameGrid.generate(size: 3);
  });

  group('isValid', () {
    test('should return true if the move is valid', () {
      const Move move = Move(value: GameGridCellValue.cross, index: 0);
      expect(move.isValid(grid), true);
    });

    test('should return false if the move is out of bounds', () {
      const Move move = Move(value: GameGridCellValue.cross, index: 9);
      expect(move.isValid(grid), false);
    });

    test('should return false if the cell at the index is not empty', () {
      final GameGrid updatedGrid = grid.applyMove(
        const Move(value: GameGridCellValue.cross, index: 0),
      );
      const Move move = Move(value: GameGridCellValue.cross, index: 0);
      expect(move.isValid(updatedGrid), false);
    });
  });
}
