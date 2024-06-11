import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../bloc/game/game_cubit.dart';

class PlayerBanner extends StatelessWidget {
  const PlayerBanner({super.key, required this.player});

  final Player player;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Text(player.name, style: const TextStyle(fontSize: 30)),
        const Spacer(),
        BlocBuilder<GameCubit, GameState>(
          builder: (BuildContext context, GameState state) {
            if (state.canIPlay(player) && !state.isGameOver) {
              return const CircularProgressIndicator();
            }

            return const SizedBox();
          },
        ),
      ],
    );
  }
}
