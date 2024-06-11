import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/entities.dart';
import '../bloc/game/game_cubit.dart';
import '../widgets/widgets.dart';

class GamePage extends StatelessWidget {
  const GamePage({super.key});

  void _handleGameEnd(
    BuildContext context, {
    required String title,
    required String content,
  }) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider<GameCubit>.value(
          value: BlocProvider.of<GameCubit>(context),
          child: Builder(
            builder: (BuildContext context) {
              return CupertinoAlertDialog(
                title: Text(title),
                content: Text(content),
                actions: <CupertinoDialogAction>[
                  CupertinoDialogAction(
                    onPressed: () {
                      Navigator.of(context).pop();
                      //context.read<GameCubit>().reset();
                    },
                    child: const Text('Restart Game'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameCubit>(
      create: (_) => GameCubit(
        player1: LocalPlayer(
          name: 'Player 1',
          cellValue: GameGridCellValue.cross,
          completer: Completer<int>(),
        ),
        // player2: LocalPlayer(
        //   name: 'Player 2',
        //   cellValue: GameGridCellValue.circle,
        //   completer: Completer<int>(),
        // ),
        player2: ComputerPlayer(
          cellValue: GameGridCellValue.circle,
          difficulty: ComputerPlayerDifficulty.hard,
        ),
      )..startGame(),
      child: BlocListener<GameCubit, GameState>(
        listener: (BuildContext context, GameState state) {
          if (state.isGameOver) {
            if (state.winner != null) {
              _handleGameEnd(
                context,
                title: 'Game Over',
                content: '${state.winner!.name} wins!',
              );
            } else {
              _handleGameEnd(
                context,
                title: 'Game Over',
                content: "It's a draw!",
              );
            }

            return;
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
                    PlayerBanner(player: state.player2),
                    GameGridWidget(grid: state.grid),
                    PlayerBanner(player: state.player1),
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
