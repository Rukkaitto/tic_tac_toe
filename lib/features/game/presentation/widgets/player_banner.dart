import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rive/rive.dart';

import '../../../../core/constants/artboards.dart';
import '../../../../core/services/asset_service/asset_service.dart';
import '../../../../core/ui_components/raised_container/raised_container.dart';
import '../../domain/entities/entities.dart';
import '../bloc/game/game_cubit.dart';

class PlayerBanner extends StatelessWidget {
  const PlayerBanner({super.key, required this.player});

  final Player player;

  Widget _buildLoader() {
    return BlocBuilder<GameCubit, GameState>(
      builder: (BuildContext context, GameState state) {
        if (player.canPlay(state)) {
          return SizedBox(
            width: 50,
            height: 50,
            child: RiveAnimation.asset(
              AssetService().rive.crossCircleLoader,
              artboard: kLoaderArtboard,
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
      style: GoogleFonts.jost(
        color: Colors.black,
        fontSize: 32.0,
        fontWeight: FontWeight.w700,
      ),
    );
  }

  Widget _buildPlayerIcon() {
    return switch (player.cellValue) {
      GameGridCellValue.cross => SvgPicture.asset(
          AssetService().svgs.cross,
          width: 50,
          height: 50,
        ),
      GameGridCellValue.circle => SvgPicture.asset(
          AssetService().svgs.circle,
          width: 50,
          height: 50,
        ),
      GameGridCellValue.empty => const SizedBox(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return RaisedContainer(
      height: 80.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25),
        child: Row(
          children: <Widget>[
            _buildPlayerIcon(),
            const SizedBox(width: 10),
            _buildPlayerName(),
            const Spacer(),
            _buildLoader(),
          ],
        ),
      ),
    );
  }
}
