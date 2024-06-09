import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/entities/entities.dart';

void main() {
  late GameGrid grid;

  setUp(() {
    grid = GameGrid.generate(size: 3);
    grid = grid.setCellValue(GameGridCellValue.cross, index: 0);
    grid = grid.setCellValue(GameGridCellValue.circle, index: 1);
    grid = grid.setCellValue(GameGridCellValue.cross, index: 3);
    grid = grid.setCellValue(GameGridCellValue.circle, index: 5);
    grid = grid.setCellValue(GameGridCellValue.cross, index: 6);
    grid = grid.setCellValue(GameGridCellValue.cross, index: 7);
    grid = grid.setCellValue(GameGridCellValue.cross, index: 8);
  });

  group('getRow', () {
    test('should return the correct row (1)', () {
      final List<GameGridCell> row = grid.getRow(0);
      expect(row, const <GameGridCell>[
        GameGridCell(GameGridCellValue.cross, index: 0),
        GameGridCell(GameGridCellValue.circle, index: 1),
        GameGridCell(GameGridCellValue.empty, index: 2),
      ]);
    });

    test('should return the correct row (2)', () {
      final List<GameGridCell> row = grid.getRow(1);
      expect(row, const <GameGridCell>[
        GameGridCell(GameGridCellValue.cross, index: 3),
        GameGridCell(GameGridCellValue.empty, index: 4),
        GameGridCell(GameGridCellValue.circle, index: 5),
      ]);
    });

    test('should return the correct row (3)', () {
      final List<GameGridCell> row = grid.getRow(2);
      expect(row, const <GameGridCell>[
        GameGridCell(GameGridCellValue.cross, index: 6),
        GameGridCell(GameGridCellValue.cross, index: 7),
        GameGridCell(GameGridCellValue.cross, index: 8),
      ]);
    });
  });

  group('getColumn', () {
    test('should return the correct column (1)', () {
      final List<GameGridCell> column = grid.getColumn(0);
      expect(column, const <GameGridCell>[
        GameGridCell(GameGridCellValue.cross, index: 0),
        GameGridCell(GameGridCellValue.cross, index: 3),
        GameGridCell(GameGridCellValue.cross, index: 6),
      ]);
    });

    test('should return the correct column (2)', () {
      final List<GameGridCell> column = grid.getColumn(1);
      expect(column, const <GameGridCell>[
        GameGridCell(GameGridCellValue.circle, index: 1),
        GameGridCell(GameGridCellValue.empty, index: 4),
        GameGridCell(GameGridCellValue.cross, index: 7),
      ]);
    });

    test('should return the correct column (3)', () {
      final List<GameGridCell> column = grid.getColumn(2);
      expect(column, const <GameGridCell>[
        GameGridCell(GameGridCellValue.empty, index: 2),
        GameGridCell(GameGridCellValue.circle, index: 5),
        GameGridCell(GameGridCellValue.cross, index: 8),
      ]);
    });
  });

  group('getDiagonal1', () {
    test('should return the correct diagonal', () {
      final List<GameGridCell> diagonal = grid.getDiagonal1();
      expect(diagonal, const <GameGridCell>[
        GameGridCell(GameGridCellValue.cross, index: 0),
        GameGridCell(GameGridCellValue.empty, index: 4),
        GameGridCell(GameGridCellValue.cross, index: 8),
      ]);
    });
  });

  group('getDiagonal2', () {
    test('should return the correct diagonal', () {
      final List<GameGridCell> diagonal = grid.getDiagonal2();
      expect(diagonal, const <GameGridCell>[
        GameGridCell(GameGridCellValue.empty, index: 2),
        GameGridCell(GameGridCellValue.empty, index: 4),
        GameGridCell(GameGridCellValue.cross, index: 6),
      ]);
    });
  });
}
