import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../../../core/constants/widget_keys.dart';
import '../../../../core/ui_components/scrolling_background/scrolling_background.dart';
import '../../domain/entities/entities.dart';
import '../bloc/game/game_cubit.dart';
import '../widgets/game_end_dialog.dart';
import '../widgets/widgets.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    super.key,
    required this.player1,
    required this.player2,
  });

  final Player player1;
  final Player player2;

  static const double _playerBannerHorizontalPadding = 10.0;
  static const double _gameGridHorizontalPadding = 20.0;
  static const double _gameGridVerticalPadding = 30.0;

  void _handleGameEnd(
    BuildContext context, {
    required String title,
    required String content,
    required Key key,
  }) {
    showDialog<void>(
      context: context,
      builder: (_) {
        return BlocProvider<GameCubit>.value(
          value: BlocProvider.of<GameCubit>(context),
          child: GameEndDialog(
            title: title,
            content: content,
            key: key,
          ),
        );
      },
    );
  }

  void _handleGameState(BuildContext context, {required GameState state}) {
    if (state.isGameOver) {
      if (state.winner != null) {
        _handleGameEnd(
          context,
          title: AppLocalizations.of(context)!.gameOverTitle,
          content: AppLocalizations.of(context)!
              .gameOverWinMessage(state.winner!.name),
          key: WidgetKeys.winnerDialog,
        );
      } else {
        _handleGameEnd(
          context,
          title: AppLocalizations.of(context)!.gameOverTitle,
          content: AppLocalizations.of(context)!.gameOverTieMessage,
          key: WidgetKeys.tieDialog,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<GameCubit>(
      create: (_) => GameCubit(
        player1: player1,
        player2: player2,
      )..startGame(),
      child: BlocListener<GameCubit, GameState>(
        listener: (BuildContext context, GameState state) =>
            _handleGameState(context, state: state),
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
          ),
          body: ScrollingBackground(
            child: BlocBuilder<GameCubit, GameState>(
              builder: (BuildContext context, GameState state) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _playerBannerHorizontalPadding,
                      ),
                      child: PlayerBanner(player: state.player2),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _gameGridHorizontalPadding,
                        vertical: _gameGridVerticalPadding,
                      ),
                      child: GameGridWidget(grid: state.grid),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: _playerBannerHorizontalPadding,
                      ),
                      child: PlayerBanner(player: state.player1),
                    ),
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
