import '../Pieces/Piece.dart';

class Move {
  List<int> oldPosition;
  List<int> newPosition;
  Piece movedPiece;
  Piece? takenPiece; // Assuming takenPiece can be null
  List<List<Piece?>> boardBeforeMove; // Nullable Piece

  /**
   * Constructor
   * @param currentPosition is the current position on the board for the piece. An array with index 0 being
   *        the row of the chess board, and index 1 being the column
   * @param destinationPosition is the destination position on the board for the piece. An array with index 0 being
   *        the row of the chess board, and index 1 being the column
   * @param piece is the Piece object to be moved on the chess board
   */
  Move(this.oldPosition, this.newPosition, this.movedPiece, this.takenPiece, this.boardBeforeMove);

  // GET METHODS

  /**
   * Returns the current position for this move
   * @return returns a List<int> that corresponds to the current position of this move. index 0 of the List<int> is the row on
   *         the chess board, index 1 is the column
   */
  List<int> getOldPosition() {
    return oldPosition;
  }

  /**
   * Returns the destination position for this move
   * @return returns a List<int> that corresponds to the destination position of this move. index 0 of the List<int> is the row on
   *         the chess board, index 1 is the column
   */
  List<int> getNewPosition() {
    return newPosition;
  }

  /**
   * Returns the Piece being moved
   * @return is a Piece object that is being moved
   */
  Piece getMovedPiece() {
    return movedPiece;
  }

  Piece? getTakenPiece() {
    return takenPiece;
  }

  List<List<Piece?>> getBoardBeforeMove() {
    return boardBeforeMove;
  }

  // SET METHODS

  /**
   * Sets the current position for this move
   * @param currentPosition is a List<int> that corresponds to the current position of this move. index 0 of the List<int> is the row on
   *         the chess board, index 1 is the column
   */
  void setCurrentPosition(List<int> currentPosition) {
    oldPosition = currentPosition;
  }

  /**
   * Sets the destination position for this move
   * @param destinationPosition is a List<int> that corresponds to the current position of this move. index 0 of the List<int> is the row on
   *         the chess board, index 1 is the column
   */
  void setDestinationPosition(List<int> destinationPosition) {
    newPosition = destinationPosition;
  }

  /**
   * Sets the Piece for this move
   * @param piece is the Piece object that we want to move on the chess board
   */
  void setMovedPiece(Piece piece) {
    movedPiece = piece;
  }

  void setTakenPiece(Piece? piece) {
    takenPiece = piece;
  }

  void setBoardBeforeMove(List<List<Piece?>> board) {
    boardBeforeMove = board;
  }
}