import '../Game/Board.dart';

// Abstract class Piece
abstract class Piece {
  List<int> position; // The location of this Piece on the chessboard, which is a 2D array
  String type; // 'P' for pawn, 'R' for rook, etc.
  String team; // 'W' for white, 'B' for black
  bool legalMovesCalculated = false;
  List<List<int>> legalMoves = [];

  // Constructor
  Piece(this.position, this.type, this.team);

  // GET METHODS //

  // Returns the current team for this piece
  String getTeam() {
    return this.team;
  }

  // Return if the legal moves are calculated
  bool areLegalMovesCalculated(){
    return this.legalMovesCalculated;
  }

  // Returns the current type for this piece
  String getType() {
    return this.type;
  }

  // Returns the current position for this piece
  List<int> getPosition() {
    return this.position;
  }

  // SET METHODS //

  // Sets the team for this piece
  void setTeam(String team) {
    this.team = team;
  }

  // Sets if the legal moves are calculated
  void setLegalMovesCalculated(bool calculated){
    this.legalMovesCalculated = calculated;
  }

  // Sets the type for this piece
  void setType(String type) {
    this.type = type;
  }

  // Sets the position on the chessboard for this piece
  void setPosition(List<int> position) {
    this.position = position;
  }

  // MOVEMENTS //
  
  // Abstract methods to be implemented in child classes
  List<List<int>> calculateLegalMove(Board board);
  List<List<int>> movesCheckChecker(List<List<Piece?>> board);
  Piece copy();
}