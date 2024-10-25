import 'Piece.dart';
import '../Game/Board.dart';
import 'Rook.dart';
import '../Game/Game.dart';

class King extends Piece {
  bool isFirstMove;

  /// Constructor
  /// [position] is the position in the 2D array (the board) that this piece is on
  /// [type] is the type of piece (bishop, rook, etc.)
  /// [team] is the team the piece is on (black or white)
  King(List<int> position, String type, String team)
      : isFirstMove = true,
        super(position, type, team);

  // GET METHODS

  /// Returns true if this is the king's first move
  bool getIsFirstMove() {
        return this.isFirstMove;
  }

  @override
  King copy() {
    King copy = King(this.position, this.type, this.team);
    if (!this.isFirstMove) {
      copy.setIsFirstMove();
    }
    return copy;
  }

  // SET METHODS

  /// Method to set if this is the king's first move or not
  void setIsFirstMove() {
    this.isFirstMove = false;
  }

  // MOVEMENTS //

  /// Finds the king's possible move
  /// Returns a list of lists corresponding to the possible positions this piece can move to on the board
  List<List<int>> calculateLegalMove(Board board) {

    if (this.areLegalMovesCalculated()){
      return this.legalMoves;
    }
    List<List<int>> moves = [];

    // Get the king's position on the board
    int row = this.position[0];
    int column = this.position[1];

    // Check all possible moves
    List<List<int>> potentialMoves = [
      [row - 1, column - 1],
      [row - 1, column + 1],
      [row + 1, column - 1],
      [row + 1, column + 1],
      [row + 1, column],
      [row - 1, column],
      [row, column + 1],
      [row, column - 1],
    ];

    for (var move in potentialMoves) {
      int newRow = move[0];
      int newCol = move[1];
      if (newRow >= 0 && newRow < 8 && newCol >= 0 && newCol < 8) {
        if (board.board[newRow][newCol] == null || 
            board.board[newRow][newCol]?.getTeam() != this.team) {
          List<int> movePosition = [newRow, newCol];
          if (board.validateMove(this, movePosition, false)) {
            moves.add(movePosition);
          }
        }
      }
    }

    // Now check if castling is possible
    if (castleKingSide(board, moves)) {
      if (Game.playerIsWhite) {
        moves.add([this.position[0], this.position[1] + 2]);
      }
      else {
        moves.add([this.position[0], this.position[1] - 2]);
      }
    }

    if (castleQueenSide(board, moves)) {
      if (Game.playerIsWhite) {
        moves.add([this.position[0], this.position[1] - 2]);
      }
      else {
        moves.add([this.position[0], this.position[1] + 2]);
      }
    }

    this.legalMoves = moves;
    this.setLegalMovesCalculated(true);
    return moves;
  }

  @override
  List<List<int>> movesCheckChecker(List<List<Piece?>> board) {
    List<List<int>> moves = [];

    // Get the king's position on the board
    int row = this.position[0];
    int column = this.position[1];

    List<List<int>> potentialMoves = [
      [row - 1, column - 1],
      [row - 1, column + 1],
      [row + 1, column - 1],
      [row + 1, column + 1],
      [row + 1, column],
      [row - 1, column],
      [row, column + 1],
      [row, column - 1],
    ];

    for (var move in potentialMoves) {
      int newRow = move[0];
      int newCol = move[1];
      if (newRow >= 0 && newRow < 8 && newCol >= 0 && newCol < 8) {
        if (board[newRow][newCol] == null || 
            board[newRow][newCol]?.getTeam()  != this.team) {
          moves.add([newRow, newCol]);
        }
      }
    }

    return moves;
  }

  bool castleKingSide(Board board, List<List<int>> moves) {
    // Check if this is the king's first move and the king is not in check
    if (!this.isFirstMove || board.isKingInCheck(this.team, board.board)) {
      return false;
    }

    Rook rook;

    // HANDLE LOGIC IS PLAYER IS WHITE
    if (Game.playerIsWhite) {
      // Get the appropriate rook
      if (this.team == 'W') {
        rook = board.board[7][7]!.copy() as Rook; // Ensure the piece is not null
      }
      else {
        rook = board.board[0][7]!.copy() as Rook; // Ensure the piece is not null
      }
      

      // Check if it's the rook's first move
      if (!rook.isFirstMove) {
        return false;
      }

      // Check if the squares between the rook and king are empty
      // int[] rookPosition = rook.getPosition();
      if (board.board[rook.getPosition()[0]][rook.getPosition()[1] - 1] != null ||
          board.board[rook.getPosition()[0]][rook.getPosition()[1] - 2] != null) {
        return false;
      }

      // Now we need to check if the squares in between the king and the rook are in check
      // The king cannot castle through check

      // Check the square right beside the king
      bool clearPath = moves.any((move) =>
          move[0] == this.position[0] &&
          move[1] == this.position[1] + 1);

      if (!clearPath) {
        return false;
      }

      // Now check the square two spaces from the king
      // Copy board then call validate move to see if it's legal
      List<List<Piece?>> newBoard = List.generate(8, (_) => List.filled(8, null));

      List<int> newMove = [this.position[0], this.position[1] + 2];
      if (!board.validateMove(this, newMove, false)) {
        return false;
      }

      // Now check if once we castle, the king is in check
      // Copy original board
      for (int r = 0; r < 8; r++) {
        for (int c = 0; c < 8; c++) {
          newBoard[r][c] = board.board[r][c]?.copy();
        }
      }

      // Change rook's position
      newBoard[rook.position[0]][rook.position[1]] = null;
      newBoard[rook.position[0]][rook.position[1] - 2] = rook;
      rook.setPosition([rook.position[0], rook.position[1] - 2]);

      // Now you would need to implement further logic to check for check after castling.

      return true;
    }


    // NOW HANDLE LOGIC IF PLAYER IS BLACK
    else {
            // Get the appropriate rook
      if (this.team == 'W') {
        rook = board.board[0][0]!.copy() as Rook; // Ensure the piece is not null
      }
      else {
        rook = board.board[7][0]!.copy() as Rook; // Ensure the piece is not null
      }
      

      // Check if it's the rook's first move
      if (!rook.isFirstMove) {
        return false;
      }

      // Check if the squares between the rook and king are empty
      // int[] rookPosition = rook.getPosition();
      if (board.board[rook.getPosition()[0]][rook.getPosition()[1] + 1] != null ||
          board.board[rook.getPosition()[0]][rook.getPosition()[1] + 2] != null) {
        return false;
      }

      // Now we need to check if the squares in between the king and the rook are in check
      // The king cannot castle through check

      // Check the square right beside the king
      bool clearPath = moves.any((move) =>
          move[0] == this.position[0] &&
          move[1] == this.position[1] - 1);

      if (!clearPath) {
        return false;
      }

      // Now check the square two spaces from the king
      // Copy board then call validate move to see if it's legal
      List<List<Piece?>> newBoard = List.generate(8, (_) => List.filled(8, null));

      List<int> newMove = [this.position[0], this.position[1] - 2];
      if (!board.validateMove(this, newMove, false)) {
        return false;
      }

      // Now check if once we castle, the king is in check
      // Copy original board
      for (int r = 0; r < 8; r++) {
        for (int c = 0; c < 8; c++) {
          newBoard[r][c] = board.board[r][c]?.copy();
        }
      }

      // Change rook's position
      newBoard[rook.position[0]][rook.position[1]] = null;
      newBoard[rook.position[0]][rook.position[1] + 2] = rook;
      rook.setPosition([rook.position[0], rook.position[1] + 2]);

      // Now you would need to implement further logic to check for check after castling.

      // Check if the king is in check after castling
      if (board.isKingInCheck(this.getTeam(), newBoard)) {
        return false;
      } else {
        return true;
      }
    }
  }

  bool castleQueenSide(Board board, List<List<int>> moves) {
    // Check if this is the king's first move and if the king is not in check
    if (!this.isFirstMove || board.isKingInCheck(this.getTeam(), board.getBoard())) {
      return false;
    }

    Rook? rook;

    if (Game.playerIsWhite) {
      // Get the appropriate rook
      if (this.getTeam() == 'W') {
        rook = board.getBoard()[7][0]?.copy() as Rook?;
      } else {
        rook = board.getBoard()[0][0]?.copy() as Rook?;
      }

      // If rook is null or it’s not the rook's first move, return false
      if (rook == null || !rook.isFirstMove) {
        return false;
      }

      // Check if the squares between the rook and king are empty
      List<int> rookPosition = rook.getPosition();
      if (board.getBoard()[rookPosition[0]][rookPosition[1] + 1] != null ||
          board.getBoard()[rookPosition[0]][rookPosition[1] + 2] != null ||
          board.getBoard()[rookPosition[0]][rookPosition[1] + 3] != null) {
        return false;
      }

      // Check if the squares between the king and the rook are in check
      // The king cannot castle through check
      bool clearPath = false;
      for (List<int> move in moves) {
        if (move[0] == this.getPosition()[0] && move[1] == this.getPosition()[1] - 1) {
          clearPath = true;
          break;
        }
      }

      if (!clearPath) {
        return false;
      }

      // Now check the square two squares from the king to the rook
      // Copy board and call validateMove to see if it's legal
      List<List<Piece?>> newBoard = List.generate(8, (i) => List.filled(8, null));

      List<int> newMove = [this.getPosition()[0], this.getPosition()[1] - 2];
      if (!board.validateMove(this, newMove, false)) {
        return false;
      }

      // Now check if once we castle, the king is in check
      // Copy original board
      for (int r = 0; r < 8; r++) {
        for (int c = 0; c < 8; c++) {
          if (board.getBoard()[r][c] != null) {
            newBoard[r][c] = board.getBoard()[r][c]?.copy();
          } else {
            newBoard[r][c] = null;
          }
        }
      }

      // Change rook's position
      newBoard[rook.getPosition()[0]][rook.getPosition()[1]] = null;
      newBoard[rook.getPosition()[0]][rook.getPosition()[1] + 3] = rook;
      rook.setPosition([rook.getPosition()[0], rook.getPosition()[1] + 3]);

      King king = newBoard[this.getPosition()[0]][this.getPosition()[1]] as King;
      newBoard[this.getPosition()[0]][this.getPosition()[1] - 2] = king;
      king.setPosition([this.getPosition()[0], this.getPosition()[1] - 2]);
      newBoard[this.getPosition()[0]][this.getPosition()[1]] = null;

      // Check if the king is in check after castling
      if (board.isKingInCheck(this.getTeam(), newBoard)) {
        return false;
      } else {
        return true;
      }
    }


    // HANDLE LOGIC FOR IF PLAYER IS BLACK
    else {
      // Get the appropriate rook
      if (this.getTeam() == 'W') {
        rook = board.getBoard()[0][7]?.copy() as Rook?;
      } else {
        rook = board.getBoard()[7][7]?.copy() as Rook?;
      }

      // If rook is null or it’s not the rook's first move, return false
      if (rook == null || !rook.isFirstMove) {
        return false;
      }

      // Check if the squares between the rook and king are empty
      List<int> rookPosition = rook.getPosition();
      if (board.getBoard()[rookPosition[0]][rookPosition[1] - 1] != null ||
          board.getBoard()[rookPosition[0]][rookPosition[1] - 2] != null ||
          board.getBoard()[rookPosition[0]][rookPosition[1] - 3] != null) {
        return false;
      }

      // Check if the squares between the king and the rook are in check
      // The king cannot castle through check
      bool clearPath = false;
      for (List<int> move in moves) {
        if (move[0] == this.getPosition()[0] && move[1] == this.getPosition()[1] + 1) {
          clearPath = true;
          break;
        }
      }

      if (!clearPath) {
        return false;
      }

      // Now check the square two squares from the king to the rook
      // Copy board and call validateMove to see if it's legal
      List<List<Piece?>> newBoard = List.generate(8, (i) => List.filled(8, null));

      List<int> newMove = [this.getPosition()[0], this.getPosition()[1] + 2];
      if (!board.validateMove(this, newMove, false)) {
        return false;
      }

      // Now check if once we castle, the king is in check
      // Copy original board
      for (int r = 0; r < 8; r++) {
        for (int c = 0; c < 8; c++) {
          if (board.getBoard()[r][c] != null) {
            newBoard[r][c] = board.getBoard()[r][c]?.copy();
          } else {
            newBoard[r][c] = null;
          }
        }
      }

      // Change rook's position
      newBoard[rook.getPosition()[0]][rook.getPosition()[1]] = null;
      newBoard[rook.getPosition()[0]][rook.getPosition()[1] - 3] = rook;
      rook.setPosition([rook.getPosition()[0], rook.getPosition()[1] - 3]);

      King king = newBoard[this.getPosition()[0]][this.getPosition()[1]] as King;
      newBoard[this.getPosition()[0]][this.getPosition()[1] + 2] = king;
      king.setPosition([this.getPosition()[0], this.getPosition()[1] + 2]);
      newBoard[this.getPosition()[0]][this.getPosition()[1]] = null;

      // Check if the king is in check after castling
      if (board.isKingInCheck(this.getTeam(), newBoard)) {
        return false;
      } else {
        return true;
      }
    }
  }

}