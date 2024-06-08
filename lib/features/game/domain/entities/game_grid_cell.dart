import 'package:equatable/equatable.dart';

import 'entities.dart';

class GameGridCell extends Equatable {
  const GameGridCell(
    this.value, {
    required this.index,
  });

  final GameGridCellValue value;
  final int index;

  @override
  List<Object?> get props => <Object?>[value, index];

  GameGridCell copyWith({
    GameGridCellValue? value,
    int? index,
  }) {
    return GameGridCell(
      value ?? this.value,
      index: index ?? this.index,
    );
  }
}
