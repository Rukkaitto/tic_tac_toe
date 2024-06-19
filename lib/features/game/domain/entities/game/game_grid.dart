import 'dart:math';

import 'package:equatable/equatable.dart';

import '../entities.dart';

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

  /// Returns `true` if the grid is full.
  bool get isFull =>
      !_cells.any((GameGridCell cell) => cell.value == GameGridCellValue.empty);

  @override
  List<Object?> get props => <Object?>[_cells];

  /// Returns the [GameGridCell] at the given [index].
  GameGridCell getCell(int index) {
    return _cells[index];
  }

  /// Returns a copy of the [GameGrid] with the given [value] set at the given [index].
  GameGrid applyMove(Move move) {
    if (!move.isValid(this)) {
      throw Exception('Invalid move');
    }

    // Copy the cells and update the cell at the given index
    final List<GameGridCell> newCells = List<GameGridCell>.from(_cells)
      ..[move.index] = GameGridCell(
        move.value,
        index: move.index,
      );

    return copyWith(cells: newCells);
  }

  /// Returns a list of [GameGridCell] for the given row [index].
  List<GameGridCell> getRow(int index) {
    final List<GameGridCell> row = <GameGridCell>[];

    for (int i = 0; i < size; i++) {
      row.add(getCell(index * size + i));
    }

    return row;
  }

  /// Returns a list of [GameGridCell] for the given column [index].
  List<GameGridCell> getColumn(int index) {
    final List<GameGridCell> column = <GameGridCell>[];

    for (int i = 0; i < size; i++) {
      column.add(getCell(i * size + index));
    }

    return column;
  }

  /// Returns a list of [GameGridCell] for the first diagonal.
  List<GameGridCell> getDiagonal1() {
    final List<GameGridCell> diagonal = <GameGridCell>[];

    for (int i = 0; i < size; i++) {
      diagonal.add(getCell(i * size + i));
    }

    return diagonal;
  }

  /// Returns a list of [GameGridCell] for the second diagonal.
  List<GameGridCell> getDiagonal2() {
    final List<GameGridCell> diagonal = <GameGridCell>[];

    for (int i = 0; i < size; i++) {
      diagonal.add(getCell(i * size + (size - i - 1)));
    }

    return diagonal;
  }

  /// Returns a copy of the [GameGrid] with the given [cells].
  GameGrid copyWith({
    List<GameGridCell>? cells,
  }) {
    return GameGrid._(
      cells: cells ?? _cells,
    );
  }

  /// Returns a string representation of the grid.
  @override
  String toString() {
    final StringBuffer buffer = StringBuffer();

    for (int i = 0; i < size; i++) {
      final List<GameGridCell> row = getRow(i);

      for (int j = 0; j < row.length; j++) {
        final GameGridCellValue value = row[j].value;
        if (value == GameGridCellValue.circle) {
          buffer.write('O');
        } else if (value == GameGridCellValue.cross) {
          buffer.write('X');
        } else {
          buffer.write(' ');
        }

        if (j < row.length - 1) {
          buffer.write(' | ');
        }
      }

      if (i < size - 1) {
        buffer.write('\n');
        buffer.write('---------');
        buffer.write('\n');
      }
    }

    return buffer.toString();
  }
}
