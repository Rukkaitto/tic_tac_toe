part of 'game_cubit.dart';

class GameState extends Equatable {
  const GameState({
    required this.grid,
    required this.player1,
    required this.player2,
    required this.currentPlayer,
    this.isGameOver = false,
    this.winner,
  });

  /// Generates a new [GameState] with the given [size] and [playerNames].
  factory GameState.initialize({
    required int size,
    required Player player1,
    required Player player2,
  }) {
    final Player currentPlayer = player1;

    return GameState(
      grid: GameGrid.generate(size: size),
      currentPlayer: currentPlayer,
      player1: player1,
      player2: player2,
    );
  }

  final GameGrid grid;
  final Player player1;
  final Player player2;
  final Player currentPlayer;
  final bool isGameOver;
  final Player? winner;

  @override
  List<Object?> get props => <Object?>[
        grid,
        player1,
        player2,
        currentPlayer,
        isGameOver,
        winner,
      ];

  /// Returns the [Player] who won the game.
  /// Returns `null` if no player has won yet.
  Player? getWinner({
    required GameGrid grid,
    required Player player1,
    required Player player2,
  }) {
    Player? checkLine(List<GameGridCell> line) {
      if (line.every(
        (GameGridCell cell) =>
            cell.value != GameGridCellValue.empty &&
            cell.value == line.first.value,
      )) {
        return line.first.value == GameGridCellValue.cross ? player1 : player2;
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

  /// Returns a copy of the [GameState] with the given [grid] and [players].
  GameState copyWith({
    GameGrid? grid,
    Player? player1,
    Player? player2,
    Player? currentPlayer,
    bool? isGameOver,
    Player? winner,
  }) {
    return GameState(
      player1: player1 ?? this.player1,
      player2: player2 ?? this.player2,
      grid: grid ?? this.grid,
      currentPlayer: currentPlayer ?? this.currentPlayer,
      isGameOver: isGameOver ?? this.isGameOver,
      winner: winner ?? this.winner,
    );
  }
}
