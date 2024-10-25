import '../Game/Board.dart'; // Assuming there's a board.dart file similar to your Java version for handling the chess board
import 'Piece.dart'; // Assuming there's a piece.dart file for the abstract Piece class

class Rook extends Piece {

  bool isFirstMove;

  // Constructor
  Rook(List<int> position, String type, String team)
      : isFirstMove = true, // Correctly initialize in the initializer list
        super(position, type, team);

  @override
  Rook copy() {
    return Rook(List.from(this.getPosition()), this.getType(), this.getTeam());
  }

  // GET

  // MOVEMENTS

  /**
   * @return A list of lists representing the possible positions this piece can move to on the board
   */
  @override
  List<List<int>> calculateLegalMove(Board board) {

    if (this.areLegalMovesCalculated()) {
      return this.legalMoves;
    }

    List<List<int>> moves = [];

    int row = this.getPosition()[0];
    int column = this.getPosition()[1];

    // Check tiles to the left of the rook
    for (int i = column - 1; i >= 0; i--) {
      if (board.getBoard()[row][i] != null) {
        if (board.getBoard()[row][i]?.getTeam() == this.getTeam()) {
          break;
        } else {
          List<int> move = [row, i];
          if (board.validateMove(this, move, false)) {
            moves.add(move);
          }
          break;
        }
      } else {
        List<int> move = [row, i];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check tiles to the right of the rook
    for (int i = column + 1; i < 8; i++) {
      if (board.getBoard()[row][i] != null) {
        if (board.getBoard()[row][i]?.getTeam() == this.getTeam()) {
          break;
        } else {
          List<int> move = [row, i];
          if (board.validateMove(this, move, false)) {
            moves.add(move);
          }
          break;
        }
      } else {
        List<int> move = [row, i];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check tiles above the rook
    for (int i = row - 1; i >= 0; i--) {
      if (board.getBoard()[i][column] != null) {
        if (board.getBoard()[i][column]?.getTeam() == this.getTeam()) {
          break;
        } else {
          List<int> move = [i, column];
          if (board.validateMove(this, move, false)) {
            moves.add(move);
          }
          break;
        }
      } else {
        List<int> move = [i, column];
        if (board.validateMove(this, move, false)) {
          moves.add(move);
        }
      }
    }

    // Check tiles below the rook
    for (int i = row + 1; i < 8; i++) {
      if (board.getBoard()[i][column] != null) {
        if (board.getBoard()[i][column]?.getTeam() == this.getTeam()) {
          break;
        } else {
          List<int> move = [i, column];
          if (board.validateMove(this, move, false)) {
            moves.add(move);
          }
          break;
        }
      } else {
        List<int> move = [i, column];
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

    int row = this.getPosition()[0];
    int column = this.getPosition()[1];

    // Check tiles to the left of the rook
    for (int i = column - 1; i >= 0; i--) {
      if (board[row][i] != null) {
        if (board[row][i]!.getTeam() == this.getTeam()) {
          break;
        } else {
          List<int> move = [row, i];
          moves.add(move);
          break;
        }
      } else {
        List<int> move = [row, i];
        moves.add(move);
      }
    }

    // Check tiles to the right of the rook
    for (int i = column + 1; i < 8; i++) {
      if (board[row][i] != null) {
        if (board[row][i]!.getTeam() == this.getTeam()) {
          break;
        } else {
          List<int> move = [row, i];
          moves.add(move);
          break;
        }
      } else {
        List<int> move = [row, i];
        moves.add(move);
      }
    }

    // Check tiles above the rook
    for (int i = row - 1; i >= 0; i--) {
      if (board[i][column] != null) {
        if (board[i][column]!.getTeam() == this.getTeam()) {
          break;
        } else {
          List<int> move = [i, column];
          moves.add(move);
          break;
        }
      } else {
        List<int> move = [i, column];
        moves.add(move);
      }
    }

    // Check tiles below the rook
    for (int i = row + 1; i < 8; i++) {
      if (board[i][column] != null) {
        if (board[i][column]!.getTeam() == this.getTeam()) {
          break;
        } else {
          List<int> move = [i, column];
          moves.add(move);
          break;
        }
      } else {
        List<int> move = [i, column];
        moves.add(move);
      }
    }

    return moves;
  }
}