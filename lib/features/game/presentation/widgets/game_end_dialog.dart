import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../bloc/game/game_cubit.dart';

class GameEndDialog extends StatelessWidget {
  const GameEndDialog({super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      key: key,
      actions: <CupertinoDialogAction>[
        CupertinoDialogAction(
          onPressed: () {
            Navigator.of(context).pop();
            context.read<GameCubit>().resetGame();
          },
          child: Text(AppLocalizations.of(context)!.gameOverPlayAgain),
        ),
      ],
    );
  }
}
