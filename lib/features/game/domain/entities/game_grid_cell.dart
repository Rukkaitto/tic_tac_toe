import 'package:equatable/equatable.dart';

enum GameGridCellValue {
  empty,
  cross,
  circle,
}

class GameGridCell extends Equatable {
  const GameGridCell(
    this.value, {
    required this.x,
    required this.y,
  });

  final GameGridCellValue value;
  final int x;
  final int y;

  @override
  List<Object?> get props => <Object?>[value, x, y];

  GameGridCell copyWith({
    GameGridCellValue? value,
    int? x,
    int? y,
  }) {
    return GameGridCell(
      value ?? this.value,
      x: x ?? this.x,
      y: y ?? this.y,
    );
  }
}
