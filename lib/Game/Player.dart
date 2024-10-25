import '../Pieces/Piece.dart';
import 'Game.dart'; 
import 'Move.dart';

class Player {
  late String team; // Use String instead of char
  List<Piece> pieces; // List of Piece objects
  Game game;

  /**
   * Constructor
   * @param team is a String that tells us what team this player is on. 'W' for white, 'B' for black
   * @param pieces is a list of Piece for this player
   * @param game is the Game object this player is playing on
   */
  Player(this.team, this.pieces, this.game);

  // GET METHODS

  /**
   * Returns the team this player is on
   * @return is a String associated with this player's team. 'W' for white. 'B' for black.
   */
  String getTeam() {
    return team;
  }

  /**
   * Returns this player's active pieces
   * @return is a List of this player's active Piece objects
   */
  List<Piece> getPieces() {
    return pieces;
  }

  /**
   * Returns the game this player is playing
   * @return is a Game object associated with this player
   */
  Game getGame() {
    return game;
  }

  // SET METHODS

  /**
   * Sets the team for this player
   * @param team is a String. Either 'W' for white, or 'B' for black
   */
  void setTeam(String team) {
    this.team = team;
  }

  /**
   * Sets the list of pieces for this player
   * @param pieces is a List of Piece objects for this player
   */
  void setPieces(List<Piece> pieces) {
    this.pieces = pieces;
  }

  /**
   * Sets the Game for this player
   * @param game is a Game object that this player is using
   */
  void setGame(Game game) {
    this.game = game;
  }

  // UTILITY METHODS

  /**
   * Adds a piece to the list of pieces. Mostly for pawn promotion, or potential other game types
   * @param piece is the Piece object to be added
   */
  void addPiece(Piece piece) {
    pieces.add(piece);
  }

  /**
   * Removes a piece to the list of pieces. Mostly for pawn promotion, or potential other game types
   * @param piece is the Piece object to be removed
   */
  void removePiece(Piece piece) {
    pieces.remove(piece);
  }

  void move(Piece piece, List<int> destination) {
    Move move = Move(
      piece.getPosition(),
      destination,
      piece,
      game.board.getBoard()[destination[0]][destination[1]],
      game.board.getBoard(),
    );
    if (game.makeMove(move)) {
      game.board.setBoard(piece, destination);
    }
  }

  void pieceClicked(Piece piece) {
    List<List<int>> moves = piece.calculateLegalMove(game.board);
    /*
     * TODO think of how to highlight moves like chess.com does. Maybe this can be done in the GUI
     * game.getBoard().highlightPossibleMoves(moves);
     */
  }
}