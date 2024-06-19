import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../core/services/asset_service/asset_service.dart';
import '../../domain/entities/game/game_grid_cell_value.dart';

extension GameGridCellValueExtension on GameGridCellValue {
  Widget icon({required double iconSize}) {
    return switch (this) {
      GameGridCellValue.cross => SvgPicture.asset(
          AssetService().svgs.cross,
          width: iconSize,
          height: iconSize,
        ),
      GameGridCellValue.circle => SvgPicture.asset(
          AssetService().svgs.circle,
          width: iconSize,
          height: iconSize,
        ),
      GameGridCellValue.empty => const SizedBox(),
    };
  }
}
