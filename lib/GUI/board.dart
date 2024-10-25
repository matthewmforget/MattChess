import 'package:flutter/material.dart';
import '../Game/Game.dart';

// import 'homescreen.dart';

class GDChess extends StatelessWidget {
  const GDChess({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matt Chess',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ChessBoardScreen(playerColor: 'White',),
    );
  }
}

class ChessBoardScreen extends StatelessWidget {
  final String? playerColor;
  const ChessBoardScreen({super.key, required this.playerColor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matt Chess'),
      ),
      body: Center(
        child: ChessBoard(playerColor: playerColor),
      ),
    );
  }
}

class ChessBoard extends StatefulWidget {
  final String? playerColor;
  const ChessBoard({super.key, required this.playerColor});

  @override
  _ChessBoardState createState() => _ChessBoardState();
}

class _ChessBoardState extends State<ChessBoard> {
  // Initialize the board state

  // Game variable
  late Game game;

  List<List<int>>? legalMoves = []; // Store legal moves
  String originalPosition = "";

  // Assume you have a method to calculate legal moves for a piece
  void calculateLegalMoves(String piecePosition) {

      originalPosition = piecePosition;
      // Logic to calculate legal moves based on the piece type and position
      int row = int.parse(piecePosition[0]);  
      int col = int.parse(piecePosition[1]);
      legalMoves = game.getBoard.getBoard()[row][col]?.calculateLegalMove(game.getBoard);

  }

  void updateBoard(int row, int col, int targetRow, int targetCol) {
    game.updateBoard(row, col, targetRow,targetCol, currentBoard);
  }
  
  // Board for if the player is white
  Map<String, String> currentBoard = {
    '00': 'b_rook',
    '01': 'b_knight',
    '02': 'b_bishop',
    '03': 'b_queen',
    '04': 'b_king',
    '05': 'b_bishop',
    '06': 'b_knight',
    '07': 'b_rook',
    '10': 'b_pawn', '11': 'b_pawn', '12': 'b_pawn', '13': 'b_pawn',
    '14': 'b_pawn', '15': 'b_pawn', '16': 'b_pawn', '17': 'b_pawn',
    '70': 'w_rook', '71': 'w_knight', '72': 'w_bishop', '73': 'w_queen',
    '74': 'w_king', '75': 'w_bishop', '76': 'w_knight', '77': 'w_rook',
    '60': 'w_pawn', '61': 'w_pawn', '62': 'w_pawn', '63': 'w_pawn',
    '64': 'w_pawn', '65': 'w_pawn', '66': 'w_pawn', '67': 'w_pawn',
  };

  // Board for if the player is black
  Map<String, String> flippedBoard = {
  '00': 'w_rook', '01': 'w_knight', '02': 'w_bishop', '03': 'w_king',
  '04': 'w_queen', '05': 'w_bishop', '06': 'w_knight', '07': 'w_rook',
  '10': 'w_pawn', '11': 'w_pawn', '12': 'w_pawn', '13': 'w_pawn',
  '14': 'w_pawn', '15': 'w_pawn', '16': 'w_pawn', '17': 'w_pawn',
  '70': 'b_rook', '71': 'b_knight', '72': 'b_bishop', '73': 'b_king',
  '74': 'b_queen', '75': 'b_bishop', '76': 'b_knight', '77': 'b_rook',
  '60': 'b_pawn', '61': 'b_pawn', '62': 'b_pawn', '63': 'b_pawn',
  '64': 'b_pawn', '65': 'b_pawn', '66': 'b_pawn', '67': 'b_pawn',
  };


  @override
  void initState() {
    super.initState();
    if (widget.playerColor == 'White') {
      game = Game(true); // Instantiate the Game object
    }
    else {
      game = Game(false); // Instantiate the Game object
      currentBoard = flippedBoard;
    }
  }

  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double chessBoardSize = screenWidth - 20; // Padding of 20

    return SizedBox(
      width: chessBoardSize,
      height: chessBoardSize,
      child: GridView.builder(
        physics: const NeverScrollableScrollPhysics(), // Disable scrolling
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 8,
        ),
        itemBuilder: (context, index) {
          int row = index ~/ 8; // Calculate row number
          int col = index % 8; // Calculate column number

          /* Flip the board if the player is black
          if (widget.playerColor == 'Black') {
            row = 7 - row;
            col = 7 - col;
          }*/

          bool isWhiteSquare = (row + col) % 2 == 0;

          return DragTarget<String>(
            onAcceptWithDetails: (details) {
              setState(() {
                String data = details.data; // Get the data (position key) from drag details
                int targetRow = row; // The row you're trying to move to
                int targetCol = col; // The column you're trying to move to

                int rowOfPiece = int.parse(originalPosition[0]); // First character for row
                int colOfPiece = int.parse(originalPosition[1]); // Second character for column

                // Check if the target position is in legalMoves
                bool isLegalMove = legalMoves?.any((move) => move[0] == targetRow && move[1] == targetCol) ?? false;

                if ('$targetRow$targetCol' != data && isLegalMove) {
                  // Only move the piece if it's being dropped on a different square and it's a legal move
                  currentBoard['$targetRow$targetCol'] = currentBoard[data]!; // Move piece to new position
                  currentBoard[data] = ''; // Clear previous position
                  updateBoard(rowOfPiece, colOfPiece, targetRow, targetCol);
                }
              });
            },
            builder: (context, candidateData, rejectedData) {
              return Container(
                color: isWhiteSquare ? Colors.white : Colors.grey,
                child: Center(
                  child: _buildPiece(row, col, chessBoardSize),
                ),
              );
            },
          );
        },
        itemCount: 64, // 8x8 board
      ),
    );
  }

  Widget? _buildPiece(int row, int col, double chessBoardSize) {
    // Combine row and col as a string key for easier lookup
    String key = '$row$col';

    if (currentBoard.containsKey(key) && currentBoard[key]!.isNotEmpty) {
      // Calculate the size of each square based on the chessBoardSize
      double squareSize = chessBoardSize / 8;

      return Draggable<String>(
        data: key, // Pass the position key as data
        feedback: Image.asset(
          'images/${currentBoard[key]}.png',
          width: squareSize,
          height: squareSize,
        ),
        childWhenDragging: Container(), // Empty container when dragging
        // Using 'onDragStarted' to calculate legal moves when the drag begins
        onDragStarted: () {
          setState(() {
            // When the drag starts, calculate legal moves for the selected piece
            originalPosition = key;
            if (game.whitesTurn){
                if (currentBoard[key] != null && currentBoard[key]!.contains('w_')){
                    calculateLegalMoves(key);
                }
            }
            else {
                if (currentBoard[key] != null && currentBoard[key]!.contains('b_')){
                    calculateLegalMoves(key);
                }
            }
          });
        },
        child: Image.asset(
          'images/${currentBoard[key]}.png',
          width: squareSize,
          height: squareSize,
        ),
      );
    }
    return null;
  }
}