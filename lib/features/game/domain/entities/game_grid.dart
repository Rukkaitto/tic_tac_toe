import 'dart:math';

import 'package:equatable/equatable.dart';

import 'entities.dart';

class GameGrid extends Equatable {
  const GameGrid._({
    required List<GameGridCell> cells,
  }) : _cells = cells;

  /// Generates a new [GameState] with the given [size] and [playerNames].
  factory GameGrid.generate({
    required int size,
  }) {
    return GameGrid._(
      cells: List<GameGridCell>.generate(
        size * size,
        (int index) => GameGridCell(
          GameGridCellValue.empty,
          index: index,
        ),
      ),
    );
  }

  final List<GameGridCell> _cells;

  /// Returns the size of the grid.
  /// Ex: 3x3 grid will return 3.
  int get size => sqrt(_cells.length).toInt();

  /// Returns the length of the grid.
  int get length => _cells.length;

  @override
  List<Object?> get props => <Object?>[_cells];

  /// Returns the [GameGridCell] at the given [index].
  GameGridCell getCell(int index) {
    return _cells[index];
  }

  /// Returns a copy of the [GameGrid] with the given [value] set at the given [index].
  GameGrid setCellValue(GameGridCellValue value, {required int index}) {
    if (!isMoveValid(index)) {
      throw Exception('Invalid move');
    }

    // Copy the cells and update the cell at the given index
    final List<GameGridCell> newCells = List<GameGridCell>.from(_cells)
      ..[index] = GameGridCell(
        value,
        index: index,
      );

    return copyWith(cells: newCells);
  }

  bool isMoveValid(int index) {
    final bool isCellOutOfBounds = index >= _cells.length;

    if (isCellOutOfBounds) {
      return false;
    }

    final bool isCurrentCellEmpty =
        getCell(index).value == GameGridCellValue.empty;

    if (!isCurrentCellEmpty) {
      return false;
    }

    return true;
  }

  /// Returns a copy of the [GameGrid] with the given [cells].
  GameGrid copyWith({
    List<GameGridCell>? cells,
  }) {
    return GameGrid._(
      cells: cells ?? _cells,
    );
  }
}
