import 'Board.dart';
import 'Player.dart';
import 'Move.dart';

class Game {
  Board board;
  late Player black;
  late Player white;
  bool whitesTurn = true;
  static List<Move> moveHistory = [];
  static bool playerIsWhite = true;

    Game(bool isPlayerWhite)
      : board = Board(isPlayerWhite) { // Initialize the board here
      

    // Initialize players in the constructor body
    black = Player('B', board.getBlackPieces(), this); // Pass the already initialized board
    white = Player('W', board.getWhitePieces(), this); // Pass the already initialized board
    playerIsWhite = isPlayerWhite;
  }

  // GET METHODS //
  
  /// Returns the current board of the game.
  /// @return the Board object representing the current state of the chess board.
  Board get getBoard => this.board;
  
  /// Returns the black player in the game.
  /// @return the Player object representing the black player.
  Player get getBlack => this.black;
  
  /// Returns the white player in the game.
  /// @return the Player object representing the white player.
  Player get getWhite => this.white;

  bool get getWhitesTurn => this.whitesTurn;

  
  List<Move> get getMoveHistory => moveHistory;

  // SET METHODS //

  void updateBoard(int row, int col, int targetRow, int targetCol, Map<String, String> currentBoard) {
    this.board.updateBoard(row, col, targetRow, targetCol, currentBoard, this);
  }

  void setTurn() {
    if (whitesTurn) {
      whitesTurn = false;
    }
    else {
      whitesTurn = true;
    }
  }
  
  /// Sets the board for the game.
  /// @param board the Board object to be set as the current chess board.
  void setBoard(Board board) {
    this.board = board;
  }
  
  /// Sets the black player for the game.
  /// @param black the Player object to be set as the black player.
  void setBlack(Player black) {
    this.black = black;
  }
  
  /// Sets the white player for the game.
  /// @param white the Player object to be set as the white player.
  void setWhite(Player white) {
    this.white = white;
  }
  
  void setMoveHistory(List<Move> history) {
    moveHistory = history;
  }

  // UTILITY METHODS
  void addToMoveHistory(Move move) {
    moveHistory.add(move);
  }
  
  Move getLastMove() {
    return moveHistory.last;
  }
  
  bool makeMove(Move move) {
    List<List<int>> moves = move.getMovedPiece().calculateLegalMove(board);
    // Check if legal moves contain this move we want to make
    for (var moveCoordinate in moves) {
      if (moveCoordinate[0] == move.getNewPosition()[0] && 
          moveCoordinate[1] == move.getNewPosition()[1]) {
        return true;
      }
    }
    return false;
  }
}