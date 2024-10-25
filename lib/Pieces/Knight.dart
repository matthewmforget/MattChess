import '../Game/Board.dart';
import 'Piece.dart';

class Knight extends Piece {
  /// Constructor
  /// [position] is the position in the 2D array (the board) that this piece is on
  /// [type] is the type of piece (bishop, rook, etc.)
  /// [team] is the team the piece is on (black or white)
  Knight(List<int> position, String type, String team) : super(position, type, team);

  @override
  Knight copy() {
    return Knight(this.position, this.type, this.team);
  }

  // MOVEMENTS //

  /// @return returns a list of lists corresponding to the possible positions this piece can move to on the board
  List<List<int>> calculateLegalMove(Board board) {

    if (this.areLegalMovesCalculated()){
      return this.legalMoves;
    }
    
    List<List<int>> moves = [];

    // Get the knight's position on the board
    int row = this.position[0];
    int column = this.position[1];

    // Check first possible move
    if (row - 2 >= 0 && column - 1 >= 0) {
      if (board.getBoard()[row - 2][column - 1] == null ||
          board.getBoard()[row - 2][column - 1]?.getTeam() != this.team) {
        List<int> move = [row - 2, column - 1];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check second possible move
    if (row - 2 >= 0 && column + 1 < 8) {
      if (board.getBoard()[row - 2][column + 1] == null ||
          board.getBoard()[row - 2][column + 1]?.getTeam()!= this.team) {
        List<int> move = [row - 2, column + 1];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check third possible move
    if (row + 2 < 8 && column - 1 >= 0) {
      if (board.getBoard()[row + 2][column - 1] == null ||
          board.getBoard()[row + 2][column - 1]?.getTeam() != this.team) {
        List<int> move = [row + 2, column - 1];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check fourth possible move
    if (row + 2 < 8 && column + 1 < 8) {
      if (board.getBoard()[row + 2][column + 1] == null ||
          board.getBoard()[row + 2][column + 1]?.getTeam() != this.team) {
        List<int> move = [row + 2, column + 1];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check fifth possible move
    if (row + 1 < 8 && column + 2 < 8) {
      if (board.getBoard()[row + 1][column + 2] == null ||
          board.getBoard()[row + 1][column + 2]?.getTeam() != this.team) {
        List<int> move = [row + 1, column + 2];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check sixth possible move
    if (row + 1 < 8 && column - 2 >= 0) {
      if (board.getBoard()[row + 1][column - 2] == null ||
          board.getBoard()[row + 1][column - 2]?.getTeam() != this.team) {
        List<int> move = [row + 1, column - 2];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check seventh possible move
    if (row - 1 >= 0 && column + 2 < 8) {
      if (board.getBoard()[row - 1][column + 2] == null ||
          board.getBoard()[row - 1][column + 2]?.getTeam() != this.team) {
        List<int> move = [row - 1, column + 2];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check eighth possible move
    if (row - 1 >= 0 && column - 2 >= 0) {
      if (board.getBoard()[row - 1][column - 2] == null ||
          board.getBoard()[row - 1][column - 2]?.getTeam() != this.team) {
        List<int> move = [row - 1, column - 2];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    this.legalMoves = moves;
    this.setLegalMovesCalculated(true);
    return moves;
  }

  @override
  List<List<int>> movesCheckChecker(List<List<Piece?>> board) {
    List<List<int>> moves = [];

    // Get the knight's position on the board
    int row = this.position[0];
    int column = this.position[1];

    // Check first possible move
    if (row - 2 >= 0 && column - 1 >= 0) {
      if (board[row - 2][column - 1] == null ||
          board[row - 2][column - 1]!.team != this.team) {
        moves.add([row - 2, column - 1]);
      }
    }

    // Check second possible move
    if (row - 2 >= 0 && column + 1 < 8) {
      if (board[row - 2][column + 1] == null ||
          board[row - 2][column + 1]!.team != this.team) {
        moves.add([row - 2, column + 1]);
      }
    }

    // Check third possible move
    if (row + 2 < 8 && column - 1 >= 0) {
      if (board[row + 2][column - 1] == null ||
          board[row + 2][column - 1]!.team != this.team) {
        moves.add([row + 2, column - 1]);
      }
    }

    // Check fourth possible move
    if (row + 2 < 8 && column + 1 < 8) {
      if (board[row + 2][column + 1] == null ||
          board[row + 2][column + 1]!.team != this.team) {
        moves.add([row + 2, column + 1]);
      }
    }

    // Check fifth possible move
    if (row + 1 < 8 && column + 2 < 8) {
      if (board[row + 1][column + 2] == null ||
          board[row + 1][column + 2]!.team != this.team) {
        moves.add([row + 1, column + 2]);
      }
    }

    // Check sixth possible move
    if (row + 1 < 8 && column - 2 >= 0) {
      if (board[row + 1][column - 2] == null ||
          board[row + 1][column - 2]!.team != this.team) {
        moves.add([row + 1, column - 2]);
      }
    }

    // Check seventh possible move
    if (row - 1 >= 0 && column + 2 < 8) {
      if (board[row - 1][column + 2] == null ||
          board[row - 1][column + 2]!.team != this.team) {
        moves.add([row - 1, column + 2]);
      }
    }

    // Check eighth possible move
    if (row - 1 >= 0 && column - 2 >= 0) {
      if (board[row - 1][column - 2] == null ||
          board[row - 1][column - 2]!.team != this.team) {
        moves.add([row - 1, column - 2]);
      }
    }

    return moves;
  }
}
