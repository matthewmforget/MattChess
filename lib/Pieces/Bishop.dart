import '../Game/Board.dart';
import 'Piece.dart';

class Bishop extends Piece {
  // Constructor
  Bishop(List<int> position, String type, String team) : super(position, type, team);

  // Copy method
  Bishop copy() {
    return Bishop(this.position, this.type, this.team);
  }

  // Calculate legal moves method
  List<List<int>> calculateLegalMove(Board board) {

    if (this.areLegalMovesCalculated()){
      return this.legalMoves;
    }

    List<List<int>> moves = [];

    int row = this.position[0];
    int column = this.position[1];

    // Check tiles left and below this bishop
    for (int i = row - 1, j = column - 1; i >= 0 && j >= 0; i--, j--) {
      if (board.getBoard()[i][j] != null) {
        if (board.getBoard()[i][j]?.getTeam() == this.team) {
          break;
        } else {
          List<int> move = [i, j];
          if (board.validateMove(this, move, false)) {
            moves.add(move);
          }
          break;
        }
      } else {
        List<int> move = [i, j];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check tiles left and above this bishop
    for (int i = row + 1, j = column - 1; i < 8 && j >= 0; i++, j--) {
      if (board.getBoard()[i][j] != null) {
        if (board.getBoard()[i][j]?.getTeam() == this.team) {
          break;
        } else {
          List<int> move = [i, j];
          if (board.validateMove(this, move, false)) {
            moves.add(move);
          }
          break;
        }
      } else {
        List<int> move = [i, j];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check tiles right and below this bishop
    for (int i = row - 1, j = column + 1; i >= 0 && j < 8; i--, j++) {
      if (board.getBoard()[i][j] != null) {
        if (board.getBoard()[i][j]?.getTeam() == this.team) {
          break;
        } else {
          List<int> move = [i, j];
          if (board.validateMove(this, move, false)) {
            moves.add(move);
          }
          break;
        }
      } else {
        List<int> move = [i, j];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check tiles right and above this bishop
    for (int i = row + 1, j = column + 1; i < 8 && j < 8; i++, j++) {
      if (board.getBoard()[i][j] != null) {
        if (board.getBoard()[i][j]?.getTeam() == this.team) {
          break;
        } else {
          List<int> move = [i, j];
          if (board.validateMove(this, move, false)) {
            moves.add(move);
          }
          break;
        }
      } else {
        List<int> move = [i, j];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    this.legalMoves = moves;
    this.setLegalMovesCalculated(true);
    return moves;
  }

  // Moves check checker method
  List<List<int>> movesCheckChecker(List<List<Piece?>> board) {
    List<List<int>> moves = [];

    int row = this.position[0];
    int column = this.position[1];

    // Check tiles left and below this bishop
    for (int i = row - 1, j = column - 1; i >= 0 && j >= 0; i--, j--) {
      if (board[i][j] != null) {
        if (board[i][j]?.getTeam() == this.team) {
          break;
        } else {
          List<int> move = [i, j];
          moves.add(move);
          break;
        }
      } else {
        List<int> move = [i, j];
        moves.add(move);
      }
    }

    // Check tiles left and above this bishop
    for (int i = row + 1, j = column - 1; i < 8 && j >= 0; i++, j--) {
      if (board[i][j] != null) {
        if (board[i][j]?.getTeam() == this.team) {
          break;
        } else {
          List<int> move = [i, j];
          moves.add(move);
          break;
        }
      } else {
        List<int> move = [i, j];
        moves.add(move);
      }
    }

    // Check tiles right and below this bishop
    for (int i = row - 1, j = column + 1; i >= 0 && j < 8; i--, j++) {
      if (board[i][j] != null) {
        if (board[i][j]?.team == this.team) {
          break;
        } else {
          List<int> move = [i, j];
          moves.add(move);
          break;
        }
      } else {
        List<int> move = [i, j];
        moves.add(move);
      }
    }

    // Check tiles right and above this bishop
    for (int i = row + 1, j = column + 1; i < 8 && j < 8; i++, j++) {
      if (board[i][j] != null) {
        if (board[i][j]?.team == this.team) {
          break;
        } else {
          List<int> move = [i, j];
          moves.add(move);
          break;
        }
      } else {
        List<int> move = [i, j];
        moves.add(move);
      }
    }

    return moves;
  }
}