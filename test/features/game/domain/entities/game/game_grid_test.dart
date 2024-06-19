import 'package:flutter_test/flutter_test.dart';
import 'package:tic_tac_toe/features/game/domain/entities/entities.dart';

void main() {
  late GameGrid grid;

  setUp(() {
    grid = GameGrid.generate(size: 3);
    grid = grid.applyMove(
      const Move(value: GameGridCellValue.cross, index: 0),
    );
    grid = grid.applyMove(
      const Move(value: GameGridCellValue.circle, index: 1),
    );
    grid = grid.applyMove(
      const Move(value: GameGridCellValue.cross, index: 3),
    );
    grid = grid.applyMove(
      const Move(value: GameGridCellValue.circle, index: 5),
    );
    grid = grid.applyMove(
      const Move(value: GameGridCellValue.cross, index: 6),
    );
    grid = grid.applyMove(
      const Move(value: GameGridCellValue.cross, index: 7),
    );
    grid = grid.applyMove(
      const Move(value: GameGridCellValue.cross, index: 8),
    );
  });

  group('GameGrid.generate', () {
    test('should generate a 3x3 grid', () {
      final GameGrid grid = GameGrid.generate(size: 3);
      expect(grid.size, 3);
      expect(grid.length, 9);
    });
  });

  group('size', () {
    test('should return the correct size', () {
      expect(grid.size, 3);
    });
  });

  group('length', () {
    test('should return the correct length', () {
      expect(grid.length, 9);
    });
  });

  group('isFull', () {
    test('should return false if the grid is not full', () {
      expect(grid.isFull, false);
    });

    test('should return true if the grid is full', () {
      GameGrid fullGrid = GameGrid.generate(size: 3);
      for (int i = 0; i < fullGrid.length; i++) {
        fullGrid = fullGrid.applyMove(
          Move(value: GameGridCellValue.cross, index: i),
        );
      }
      expect(fullGrid.isFull, true);
    });
  });

  group('getCell', () {
    test('should return the correct cell', () {
      final GameGridCell cell = grid.getCell(0);
      expect(cell, const GameGridCell(GameGridCellValue.cross, index: 0));
    });
  });

  group('applyMove', () {
    test('should set the correct value', () {
      const Move move = Move(
        value: GameGridCellValue.circle,
        index: 2,
      );
      final GameGrid newGrid = grid.applyMove(move);
      final GameGridCell cell = newGrid.getCell(2);
      expect(cell, const GameGridCell(GameGridCellValue.circle, index: 2));
    });

    test('should throw an exception if the move is invalid', () {
      expect(
        () => grid.applyMove(
          const Move(value: GameGridCellValue.circle, index: 0),
        ),
        throwsException,
      );
    });
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

  group('toString', () {
    test('should return a string representation of the GameGrid', () {
      final String result = grid.toString();

      expect(result, '''
X | O |  
---------
X |   | O
---------
X | X | X''');
    });
  });
}
