import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/computer_player_service/computer_player_service.dart';
import '../bloc/game/game_cubit.dart';
import '../widgets/player_banner.dart';
import '../widgets/widgets.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameCubit>(
      create: (_) => GameCubit(playerNames: <String>['J1', 'CPU']),
      child: BlocListener<GameCubit, GameState>(
        listener: (BuildContext context, GameState state) {
          if (state.currentPlayerId == 1) {
            ComputerPlayerService().makeMove(context);
          }
        },
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.all(35),
            child: BlocBuilder<GameCubit, GameState>(
              builder: (BuildContext context, GameState state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    PlayerBanner(player: state.players[1]),
                    const GameGrid(),
                    PlayerBanner(player: state.players[0]),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
