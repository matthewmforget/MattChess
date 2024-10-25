import '../Game/Board.dart'; // Ensure to replace this with the correct import
import 'Piece.dart'; // Ensure to replace this with the correct import
import '../Game/Game.dart';

class Pawn extends Piece {
  bool isFirstMove;

  /**
   * Constructor
   * @param position is the position in the 2D array (the board) that this piece is on
   * @param type is the type of piece (bishop, rook, etc.)
   * @param team is the team the piece is on (black or white)
   */
  Pawn(List<int> position, String type, String team)
      : isFirstMove = true,
        super(position, type, team);

  // GET METHODS

  /**
   * Returns true if this is the pawn's first move
   * @return a boolean value to tell if this is the pawn's first move
   */
  bool getIsFirstMove() {
    return isFirstMove;
  }

  @override
  Pawn copy() {
    Pawn copy = Pawn(getPosition(), getType(), getTeam());
    if (!isFirstMove) {
      copy.setIsFirstMove();
    }
    return copy;
  }

  // SET METHODS

  /**
   * Method to set if this is the pawn's first move or not
   * @param a boolean value to tell if this is the pawn's first move
   */
  void setIsFirstMove() {
    isFirstMove = false;
  }

  // MOVEMENTS //

  /**
   * @return returns a list of lists corresponding to the possible positions this piece can move to on the
   *         board
   */
  @override
  List<List<int>> calculateLegalMove(Board board) {

    if (this.areLegalMovesCalculated()){
      return this.legalMoves;
    }

    List<List<int>> moves = [];

    int row = getPosition()[0];
    int column = getPosition()[1];
    int team = getTeam() == 'W' ? -1 : 1;
    if (!Game.playerIsWhite) {
      team = team*(-1);
    }

    // Check first move
    if (row + team >= 0 && row + team < 8) {
      if (board.getBoard()[row + team][column] == null) {
        if (board.validateMove(this, [row + team, column], false)) {
          moves.add([row + team, column]);
        }
      }
    }

    if (isFirstMove) {
      if (board.getBoard()[row + team][column] == null &&
          board.getBoard()[row + team + team][column] == null) {
        if (board.validateMove(this, [row + team + team, column], false)) {
          moves.add([row + team + team, column]);
        }
      }
    }

    // Check en passant to the right
    if (!isFirstMove && Game.moveHistory.isNotEmpty) {
      if (column + 1 < 8) {
        if (board.getBoard()[row][column + 1] != null) {
          if (board.getBoard()[row][column + 1]!.getType() == 'P' &&
              board.getBoard()[row][column + 1]!.getTeam() != this.getTeam()) {
            if (Game.moveHistory.last.movedPiece ==
                    board.getBoard()[row][column + 1] &&
                Game.moveHistory.last.oldPosition[0] ==
                    board.getBoard()[row][column + 1]!.getPosition()[0] + 2*team) {
              if (board.validateMove(this, [row + team, column + 1], true)) {
                moves.add([row + team, column + 1]);
              }
            }
          }
        }
      }
    }

    // Check en passant to the left
    if (!isFirstMove && Game.moveHistory.isNotEmpty) {
      if (column - 1 >= 0) {
        if (board.getBoard()[row][column - 1] != null) {
          if (board.getBoard()[row][column - 1]!.getType() == 'P' &&
              board.getBoard()[row][column - 1]!.getTeam() != getTeam()) {
            if (Game.moveHistory.last.movedPiece ==
                    board.getBoard()[row][column - 1] &&
                Game.moveHistory.last.oldPosition[0] ==
                    board.getBoard()[row][column - 1]!.getPosition()[0] + 2*team) {
              if (board.validateMove(this, [row + team, column - 1], true)) {
                moves.add([row + team, column - 1]);
              }
            }
          }
        }
      }
    }

    // Check possible diagonal attack
    if (row + team < 8 && row + team >= 0 && column + 1 < 8) {
      if (board.getBoard()[row + team][column + 1] != null) {
        if (board.getBoard()[row + team][column + 1]!.getTeam() != getTeam()) {
          if (board.validateMove(this, [row + team, column + 1], false)) {
            moves.add([row + team, column + 1]);
          }
        }
      }
    }

    // Check other possible diagonal attack
    if (row + team < 8 && row + team >= 0 && column - 1 >= 0) {
      if (board.getBoard()[row + team][column - 1] != null) {
        if (board.getBoard()[row + team][column - 1]!.getTeam() != getTeam()) {
          if (board.validateMove(this, [row + team, column - 1], false)) {
            moves.add([row + team, column - 1]);
          }
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

    int row = getPosition()[0];
    int column = getPosition()[1];
    int team = getTeam() == 'W' ? -1 : 1;
    if (!Game.playerIsWhite) {
      team = team*(-1);
    }

    // Check first move
    if (row + team >= 0 && row + team < 8) {
      if (board[row + team][column] == null) {
        moves.add([row + team, column]);
      }
    }

    if (isFirstMove) {
      if (board[row + team][column] == null &&
          board[row + team + team][column] == null) {
        moves.add([row + team + team, column]);
      }
    }

    // Check en passant
    if (!isFirstMove && Game.moveHistory.isNotEmpty) {
      if (column + 1 < 8) {
        if (board[row][column + 1] != null) {
          if (board[row][column + 1]!.getType() == 'P' &&
              board[row][column + 1]!.getTeam() != getTeam()) {
            if (Game.moveHistory.last.movedPiece ==
                    board[row][column + 1] &&
                Game.moveHistory.last.oldPosition[0] ==
                    board[row][column + 1]!.getPosition()[0] - 2) {
              moves.add([row + team, column + 1]);
            }
          }
        }
      }
    }

    // Check en passant
    if (!isFirstMove && Game.moveHistory.isNotEmpty) {
      if (column - 1 >= 0) {
        if (board[row][column - 1] != null) {
          if (board[row][column - 1]!.getType() == 'P' &&
              board[row][column - 1]!.getTeam() != getTeam()) {
            if (Game.moveHistory.last.movedPiece ==
                    board[row][column - 1] &&
                Game.moveHistory.last.oldPosition[0] ==
                    board[row][column - 1]!.getPosition()[0] - 2) {
              moves.add([row + team, column - 1]);
            }
          }
        }
      }
    }

    // Check possible diagonal attack
    if (row + team < 8 && row + team >= 0 && column + 1 < 8) {
      if (board[row + team][column + 1] != null) {
        if (board[row + team][column + 1]!.getTeam() != getTeam()) {
          moves.add([row + team, column + 1]);
        }
      }
    }

    // Check other possible diagonal attack
    if (row + team < 8 && row + team >= 0 && column - 1 >= 0) {
      if (board[row + team][column - 1] != null) {
        if (board[row + team][column - 1]!.getTeam() != getTeam()) {
          moves.add([row + team, column - 1]);
        }
      }
    }

    return moves;
  }
}