import 'package:equatable/equatable.dart';

class Player extends Equatable {
  const Player({
    required this.name,
    required this.index,
  });

  final String name;
  final int index;

  @override
  List<Object?> get props => <Object?>[name, index];
}
