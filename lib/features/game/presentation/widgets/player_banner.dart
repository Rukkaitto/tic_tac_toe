import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rive/rive.dart';

import '../../../../core/constants/rive/rive.dart';
import '../../../../core/constants/text_styles.dart';
import '../../../../core/services/asset_service/asset_service.dart';
import '../../../../core/services/dependency_injection_service/dependency_injection_service.dart';
import '../../../../core/services/enviromnent_service/environment_service.dart';
import '../../../../core/ui_components/raised_container/raised_container.dart';
import '../../domain/entities/entities.dart';
import '../bloc/game/game_cubit.dart';
import '../extensions/game_grid_cell_value_extension.dart';

class PlayerBanner extends StatelessWidget {
  const PlayerBanner({super.key, required this.player});

  final Player player;

  static const double _iconSize = 50;
  static const double _height = 80;
  static const double _horizontalPadding = 25;
  static const double _iconPadding = 10;

  Widget _buildLoader() {
    // Don't show the loader in UI tests to avoid infinite pumpWidget
    if (sl<EnvironmentService>().isUITest) {
      return const SizedBox();
    }

    return BlocBuilder<GameCubit, GameState>(
      builder: (BuildContext context, GameState state) {
        if (player.canPlay(state)) {
          return SizedBox(
            width: _iconSize,
            height: _iconSize,
            child: RiveAnimation.asset(
              AssetService().rive.crossCircleLoader,
              artboard: RiveArtboards.Loader,
            ),
          );
        }

        return const SizedBox();
      },
    );
  }

  Widget _buildPlayerName() {
    return Text(
      player.name,
      style: TextStyles.title,
    );
  }

  @override
  Widget build(BuildContext context) {
    return RaisedContainer(
      height: _height,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: _horizontalPadding),
        child: Row(
          children: <Widget>[
            player.cellValue.icon(iconSize: _iconSize),
            const SizedBox(width: _iconPadding),
            _buildPlayerName(),
            const Spacer(),
            _buildLoader(),
          ],
        ),
      ),
    );
  }
}
