part of 'game_cubit.dart';

class GameState extends Equatable {
  const GameState({
    required this.grid,
    required this.players,
    this.currentPlayerId = 0,
  }) : assert(players.length == 2);

  /// Generates a new [GameState] with the given [size] and [playerNames].
  factory GameState.initialize({
    required int size,
    required List<String> playerNames,
  }) {
    return GameState(
      grid: GameGrid.generate(size: size),
      players: playerNames
          .asMap()
          .entries
          .map(
            (MapEntry<int, String> entry) => Player(
              index: entry.key,
              name: entry.value,
            ),
          )
          .toList(),
    );
  }

  final GameGrid grid;
  final List<Player> players;
  final int currentPlayerId;

  @override
  List<Object?> get props => <Object?>[grid, players, currentPlayerId];

  /// Returns `true` if it's the given [playerId]'s turn.
  bool isItMyTurn(int playerId) => currentPlayerId == playerId;

  /// Returns the [GameGridCellValue] for the given [playerId].
  GameGridCellValue getPlayerCellValue(int playerId) {
    return players[playerId].index == 0
        ? GameGridCellValue.cross
        : GameGridCellValue.circle;
  }

  /// Returns a copy of the [GameState] with the given [grid] and [players].
  GameState copyWith({
    GameGrid? grid,
    List<Player>? players,
    int? currentPlayerId,
  }) {
    return GameState(
      grid: grid ?? this.grid,
      players: players ?? this.players,
      currentPlayerId: currentPlayerId ?? this.currentPlayerId,
    );
  }
}
