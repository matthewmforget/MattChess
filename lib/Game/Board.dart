import '../Pieces/King.dart';
import '../Pieces/Queen.dart';
import '../Pieces/Bishop.dart';
import '../Pieces/Knight.dart';
import '../Pieces/Rook.dart';
import '../Pieces/Pawn.dart';
import '../Pieces/Piece.dart';
import 'Move.dart';
import 'Game.dart';

class Board {
  List<List<Piece?>> board;
  String inCheck = 'N';

  /**
   * Constructor. Initializes a new board with new pieces in position
   */
  Board(bool isPlayerWhite) : board = List.generate(8, (_) => List.filled(8, null)) {
    this.inCheck = 'N';

    if (isPlayerWhite) {
      // Initialize black pieces
      // Black pieces
      this.board[0][0] = Rook([0, 0], 'R', 'B');
      this.board[0][1] = Knight([0, 1], 'N', 'B');
      this.board[0][2] = Bishop([0, 2], 'B', 'B');
      this.board[0][3] = Queen([0, 3], 'Q', 'B');
      this.board[0][4] = King([0, 4], 'K', 'B');
      this.board[0][5] = Bishop([0, 5], 'B', 'B');
      this.board[0][6] = Knight([0, 6], 'N', 'B');
      this.board[0][7] = Rook([0, 7], 'R', 'B');

      // Black pawns
      for (int i = 0; i < 8; i++) {
        this.board[1][i] = Pawn([1, i], 'P', 'B');
      }

      // Initialize white pieces
      // White pieces
      this.board[7][0] = Rook([7, 0], 'R', 'W');
      this.board[7][1] = Knight([7, 1], 'N', 'W');
      this.board[7][2] = Bishop([7, 2], 'B', 'W');
      this.board[7][3] = Queen([7, 3], 'Q', 'W');
      this.board[7][4] = King([7, 4], 'K', 'W');
      this.board[7][5] = Bishop([7, 5], 'B', 'W');
      this.board[7][6] = Knight([7, 6], 'N', 'W');
      this.board[7][7] = Rook([7, 7], 'R', 'W');

      // White pawns
      for (int i = 0; i < 8; i++) {
        this.board[6][i] = Pawn([6, i], 'P', 'W');
      }
    }

    else {
      // Black player perspective (inverted)

      // White pieces
      this.board[0][0] = Rook([0, 0], 'R', 'W');
      this.board[0][1] = Knight([0, 1], 'N', 'W');
      this.board[0][2] = Bishop([0, 2], 'B', 'W');
      this.board[0][3] = King([0, 3], 'K', 'W');
      this.board[0][4] = Queen([0, 4], 'Q', 'W');
      this.board[0][5] = Bishop([0, 5], 'B', 'W');
      this.board[0][6] = Knight([0, 6], 'N', 'W');
      this.board[0][7] = Rook([0, 7], 'R', 'W');

      // White pawns
      for (int i = 0; i < 8; i++) {
        this.board[1][i] = Pawn([1, i], 'P', 'W');
      }

      // Black pieces
      this.board[7][0] = Rook([7, 0], 'R', 'B');
      this.board[7][1] = Knight([7, 1], 'N', 'B');
      this.board[7][2] = Bishop([7, 2], 'B', 'B');
      this.board[7][3] = King([7, 3], 'K', 'B');
      this.board[7][4] = Queen([7, 4], 'Q', 'B');
      this.board[7][5] = Bishop([7, 5], 'B', 'B');
      this.board[7][6] = Knight([7, 6], 'N', 'B');
      this.board[7][7] = Rook([7, 7], 'R', 'B');

      // Black pawns
      for (int i = 0; i < 8; i++) {
        this.board[6][i] = Pawn([6, i], 'P', 'B');
      }
    }
  }

  // GET METHODS

  /**
   * Returns if there is a check and which color is in check
   * @return is a String. 'B' for black, 'W' for white, and 'N' for no check
   */
  String getInCheck() {
    return this.inCheck;
  }

  /**
   * Returns the current board
   * @return is a List<List<Piece?>> corresponding with the current board
   */
  List<List<Piece?>> getBoard() {
    return this.board;
  }

  // SET METHODS

  /**
   * Sets if a player is in check
   * @param inCheck is a String to set if a player is in check or not
   */
  void setInCheck(String inCheck) {
    this.inCheck = inCheck;
  }

  void setBoard(Piece piece, List<int> index) {
    this.board[index[0]][index[1]] = piece;
  }

  // UTILITY METHODS

  void updateBoard(int row, int col, int targetRow, int targetCol, Map<String, String> currentBoard, Game game) {

    // Check if the piece at board[row][col] is not null
    if (board[row][col] != null) {

      bool kingSideCastle = false;

      // Get the piece at the current location
      Piece piece = board[row][col] as Piece;

      if (piece.getType() == 'P') {
        int team = 0;
        if (Game.playerIsWhite) {
          team = 1;
        }
        else {
          team = -1;
        }
        Pawn pawn = board[row][col] as Pawn;
        pawn.setIsFirstMove();

        // Check if attack is an en passant
        if (pawn.getTeam() == 'W') {
          if (board[targetRow][targetCol] == null){
            if (board[targetRow+(1*team)][targetCol] != null) {
              board[targetRow+(1*team)][targetCol] = null;
              // Remove pawn from GUI board
              currentBoard.remove('${targetRow+(1*team)}$targetCol'); // Remove old rook
            }
          }
        }
        else {
          if (board[targetRow][targetCol] == null){
            if (board[targetRow-(1*team)][targetCol] != null) {
              board[targetRow-(1*team)][targetCol] = null;
              // Remove pawn from GUI board
              currentBoard.remove('${targetRow-(1*team)}$targetCol'); // Remove old rook
            }
          }
        }
      }

      if (piece.getType() == 'R') {
        Rook rook = board[row][col] as Rook;
        rook.isFirstMove = false;
      }

      // Check if king side castle
      if (piece.getType() == 'K') {

        King king = piece as King;
        king.setIsFirstMove();

        if (Game.playerIsWhite) {
          if (targetCol - piece.getPosition()[1] == 2){

              kingSideCastle = true;

              // Change rooks isFirstMove
              Rook rook = board[row][col+3] as Rook;
              rook.isFirstMove = false;

              // Set rook position
              List<int> newRookPosition = [];
              newRookPosition.add(targetRow);
              newRookPosition.add(5);
              rook.setPosition(newRookPosition);
              board[targetRow][7] = null;
              board[targetRow][5] = rook;

                // Update currentBoard in GUI/board.dart with new rook position
                if (rook.getTeam() == 'B') {
                  currentBoard.remove('${targetRow}7'); // Remove old rook
                  currentBoard['${targetRow}5'] = 'b_rook'; // Add new rook position
                }

                else {
                  currentBoard.remove('${targetRow}7'); // Remove old rook
                  currentBoard['${targetRow}5'] = 'w_rook'; // Add new rook position
                }

            }
        }
      

          // If player is black
          else {
            if (piece.getPosition()[1] - targetCol == 2){

                kingSideCastle = true;

                // Change rooks isFirstMove
                Rook rook = board[row][col-3] as Rook;
                rook.isFirstMove = false;

                // Set rook position
                List<int> newRookPosition = [];
                newRookPosition.add(targetRow);
                newRookPosition.add(2);
                rook.setPosition(newRookPosition);
                board[targetRow][0] = null;
                board[targetRow][2] = rook;

                  // Update currentBoard in GUI/board.dart with new rook position
                  if (rook.getTeam() == 'B') {
                    currentBoard.remove('${targetRow}0'); // Remove old rook
                    currentBoard['${targetRow}2'] = 'b_rook'; // Add new rook position
                  }

                  else {
                    currentBoard.remove('${targetRow}0'); // Remove old rook
                    currentBoard['${targetRow}2'] = 'w_rook'; // Add new rook position
                  }

            }
          }
        }

      // Check if queen side castle
      if (piece.getType() == 'K') {
        if (Game.playerIsWhite) {
          if (!kingSideCastle) {
            if (piece.getPosition()[1] - targetCol == 2){
              King king = piece as King;
              king.setIsFirstMove();

              // Change rooks isFirstMove
              Rook rook = board[row][col-4] as Rook;
              rook.isFirstMove = false;

              // Set rook position
              List<int> newRookPosition = [];
              newRookPosition.add(targetRow);
              newRookPosition.add(3);
              rook.setPosition(newRookPosition);
              board[targetRow][0] = null;
              board[targetRow][3] = rook;

              if (rook.getTeam() == 'B') {
                currentBoard.remove('${targetRow}0'); // Remove old rook
                currentBoard['${targetRow}3'] = 'b_rook'; // Add new rook position
              }

              else {
                currentBoard.remove('${targetRow}0'); // Remove old rook
                currentBoard['${targetRow}3'] = 'w_rook'; // Add new rook position
              }
            }
          }
        }

        // If player is black
        else {
          if (!kingSideCastle) {
            if (targetCol - piece.getPosition()[1] == 2){
              King king = piece as King;
              king.setIsFirstMove();

              // Change rooks isFirstMove
              Rook rook = board[row][col+4] as Rook;
              rook.isFirstMove = false;

              // Set rook position
              List<int> newRookPosition = [];
              newRookPosition.add(targetRow);
              newRookPosition.add(4);
              rook.setPosition(newRookPosition);
              board[targetRow][0] = null;
              board[targetRow][4] = rook;

              if (rook.getTeam() == 'B') {
                currentBoard.remove('${targetRow}7'); // Remove old rook
                currentBoard['${targetRow}4'] = 'b_rook'; // Add new rook position
              }

              else {
                currentBoard.remove('${targetRow}7'); // Remove old rook
                currentBoard['${targetRow}4'] = 'w_rook'; // Add new rook position
              }
            }
          }          
        }
      }

      // Move the piece to the target location
      board[targetRow][targetCol] = piece;

      // Clear the old position
      board[row][col] = null;

      List<int> newPosition = [];
      newPosition.add(targetRow);
      newPosition.add(targetCol);

      piece?.setPosition(newPosition);

      // Add move to moveHistory
      List<int> oldPosition = []; oldPosition.add(row); oldPosition.add(col);
      Move move = Move(oldPosition, newPosition, piece, null, board);
      Game.moveHistory.add(move);
    }

    // Since me made a move, lets reset legal moves for all Piece objects on the board
    for (int r=0; r<8; r++){
      for (int c=0; c<8; c++){
        this.board[r][c]?.setLegalMovesCalculated(false);
      }
    }

    game.setTurn();
  }

  /**
   * Returns a list of black pieces on the board
   * @return a List<Piece> with team = 'B' (team black)
   */
  List<Piece> getBlackPieces() {
    List<Piece> blackPieces = [];
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (this.board[i][j] != null && this.board[i][j]!.team == 'B') {
          blackPieces.add(this.board[i][j]!);
        }
      }
    }
    return blackPieces;
  }

  /**
   * Returns a list of white pieces on the board
   * @return a List<Piece> with team = 'W' (team white)
   */
  List<Piece> getWhitePieces() {
    List<Piece> whitePieces = [];
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (this.board[i][j] != null && this.board[i][j]!.team == 'W') {
          whitePieces.add(this.board[i][j]!);
        }
      }
    }
    return whitePieces;
  }

  King? getKing(String team, List<List<Piece?>> board) {
    for (int i = 0; i < 8; i++) {
      for (int j = 0; j < 8; j++) {
        if (board[i][j] != null &&
            board[i][j]!.type == 'K' &&
            board[i][j]!.team == team) {
          return board[i][j] as King;
        }
      }
    }
    return null;
  }

  bool isKingInCheck(String team, List<List<Piece?>> board) {
    // Lets return all the pieces causing the king to be in check
    // TODO add this functionality. Replace return value 'boolean' with 'Map<Piece, List<int>>'
    Map<Piece, List<int>> piecesCausingCheck = {};

    // An array to store the pieces from the chess board and one to store each pieces moves
    List<Piece> pieces = [];
    List<List<int>> moves = [];

    // Get the king
    King? king = getKing(team, board);

    // Get black or white pieces on current board
    if (team == 'W') {
      // get black pieces
      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          if (board[i][j] != null && board[i][j]!.team == 'B') {
            pieces.add(board[i][j]!);
          }
        }
      }
    } else {
      // get white pieces
      for (int i = 0; i < 8; i++) {
        for (int j = 0; j < 8; j++) {
          if (board[i][j] != null && board[i][j]!.team == 'W') {
            pieces.add(board[i][j]!);
          }
        }
      }
    }

    // For each piece, calculate its legal moves, and see if any of the moves land on the king's space
    // If it does, then the current move on the board object is illegal since it puts the ally king in check
    for (Piece piece in pieces) {
      moves = piece.movesCheckChecker(board);
      for (List<int> move in moves) {
        if (move[0] == king!.position[0] && move[1] == king.position[1]) {
          for (int r = 0; r < 8; r++) {
            for (int c = 0; c < 8; c++) {
              if (board[r][c] == null) {
                print(" - "); // Empty square
              } else {
                print(" ${board[r][c]!.type} "); // Piece's symbol
              }
            }
            print(""); // Move to the next row
          }
          print("");
          return true;
        }
      }
    }

    return false;
  }

  bool validateMove(Piece piece, List<int> move, bool enPassant) {
    if (enPassant) {
      List<List<Piece?>> newBoard = List.generate(8, (_) => List.filled(8, null));

      // Copy original board
      for (int r = 0; r < 8; r++) {
        for (int c = 0; c < 8; c++) {
          newBoard[r][c] = this.board[r][c]?.copy();
        }
      }

      Piece copy = newBoard[piece.position[0]][piece.position[1]]!;
      newBoard[move[0]][move[1]] = copy;
      copy.setPosition([move[0], move[1]]);
      List<int> nums = piece.position;
      newBoard[nums[0]][nums[1]] = null;
      int team = piece.team == 'W' ? -1 : 1;
      newBoard[move[0] - team][move[1]] = null;

      return !isKingInCheck(piece.team, newBoard);
    }

    List<List<Piece?>> newBoard = List.generate(8, (_) => List.filled(8, null));

    // Copy original board
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        newBoard[r][c] = this.board[r][c]?.copy();
      }
    }

    Piece copy = newBoard[piece.position[0]][piece.position[1]]!;
    newBoard[move[0]][move[1]] = copy;
    copy.setPosition([move[0], move[1]]);
    List<int> nums = piece.position;
    newBoard[nums[0]][nums[1]] = null;

    return !isKingInCheck(piece.team, newBoard);
  }

  /**
   * Moves a piece from its current position to the new position on the board.
   * @param piece The piece being moved.
   * @param move The target position for the piece.
   */
  void movePiece(Piece piece, List<int> move) {
    this.board[move[0]][move[1]] = piece;
    this.board[piece.position[0]][piece.position[1]] = null;
    piece.setPosition(move);
  }

  /**
   * Prints the current board in console
   */
  void printBoard() {
  for (int r = 0; r < 8; r++) {
    String rowOutput = ""; // Initialize an empty string for each row
    for (int c = 0; c < 8; c++) {
      if (this.board[r][c] == null || this.board[r][c]!.type == "") {
        rowOutput += " - "; // Append "-" for empty squares
      } else {
        rowOutput += " ${this.board[r][c]!.type} "; // Append the piece's type
      }
    }
    print(rowOutput); // Print the entire row at once after building it
  }
}


  /*void printBoard() {
    for (int r = 0; r < 8; r++) {
      for (int c = 0; c < 8; c++) {
        if (this.board[r][c] == null) {
          print(" - "); // Empty square
        } else {
          print(" ${this.board[r][c]!.type} "); // Piece's symbol
        }
      }
      print(""); // Move to the next row
    }
  }*/
}