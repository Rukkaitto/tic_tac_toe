part of 'game_cubit.dart';

class GameState extends Equatable {
  const GameState({
    required this.grid,
    required this.players,
    this.currentPlayerId = 0,
    this.isGameOver = false,
    this.winner,
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
  final bool isGameOver;
  final Player? winner;

  @override
  List<Object?> get props => <Object?>[
        grid,
        players,
        currentPlayerId,
        isGameOver,
        winner,
      ];

  /// Returns `true` if it's the given [playerId]'s turn.
  bool canIPlay(int playerId) => currentPlayerId == playerId && !isGameOver;

  /// Returns the [GameGridCellValue] for the given [playerId].
  GameGridCellValue getPlayerCellValue(int playerId) {
    return players[playerId].index == 0
        ? GameGridCellValue.cross
        : GameGridCellValue.circle;
  }

  /// Returns the [Player] who won the game.
  /// Returns `null` if no player has won yet.
  Player? getWinner({required GameGrid grid, required List<Player> players}) {
    Player? checkLine(List<GameGridCell> line) {
      if (line.every(
        (GameGridCell cell) =>
            cell.value != GameGridCellValue.empty &&
            cell.value == line.first.value,
      )) {
        return players.firstWhereOrNull(
          (Player player) =>
              getPlayerCellValue(player.index) == line.first.value,
        );
      }
      return null;
    }

    // Check rows and columns
    for (int i = 0; i < grid.size; i++) {
      final Player? winner =
          checkLine(grid.getRow(i)) ?? checkLine(grid.getColumn(i));
      if (winner != null) {
        return winner;
      }
    }

    // Check diagonals
    final Player? winner =
        checkLine(grid.getDiagonal1()) ?? checkLine(grid.getDiagonal2());
    return winner;
  }

  GameState play({
    required int playerId,
    required int index,
  }) {
    if (!canIPlay(playerId)) {
      return this;
    }

    final GameGridCellValue cellValue = getPlayerCellValue(playerId);

    final GameGrid newGrid = grid.setCellValue(cellValue, index: index);

    final Player? winner = getWinner(grid: newGrid, players: players);

    final bool isGameOver = winner != null || newGrid.isFull;

    int? nextPlayerId;

    if (!isGameOver) {
      // Switch to the next player
      nextPlayerId = (currentPlayerId + 1) % players.length;
    }

    return copyWith(
      grid: newGrid,
      currentPlayerId: nextPlayerId,
      winner: winner,
      isGameOver: isGameOver,
    );
  }

  /// Returns a copy of the [GameState] with the given [grid] and [players].
  GameState copyWith({
    GameGrid? grid,
    List<Player>? players,
    int? currentPlayerId,
    bool? isGameOver,
    Player? winner,
  }) {
    return GameState(
      grid: grid ?? this.grid,
      players: players ?? this.players,
      currentPlayerId: currentPlayerId ?? this.currentPlayerId,
      isGameOver: isGameOver ?? this.isGameOver,
      winner: winner ?? this.winner,
    );
  }
}
