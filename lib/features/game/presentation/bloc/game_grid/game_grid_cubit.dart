import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/game_grid_cell.dart';

part 'game_grid_state.dart';

class GameGridCubit extends Cubit<GameGridState> {
  GameGridCubit() : super(GameGridState.initialize(size: 3));
}
