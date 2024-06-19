import '../../../../features/game/domain/entities/entities.dart';

class QueryParams {
  const QueryParams(this.params);

  final Map<String, String> params;

  String? getString(String key) {
    return params[key];
  }

  int? getInt(String key) {
    final String? value = params[key];

    if (value == null) {
      return null;
    }

    return int.tryParse(value);
  }

  ComputerPlayerDifficulty? getComputerPlayerDifficulty(String key) {
    final int? difficultyInt = getInt(key);

    if (difficultyInt == null ||
        difficultyInt < 0 ||
        difficultyInt >= ComputerPlayerDifficulty.values.length) {
      return null;
    }

    return ComputerPlayerDifficulty.values[difficultyInt];
  }
}
