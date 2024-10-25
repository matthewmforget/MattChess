import 'package:flutter/material.dart';
import 'board.dart';
import 'package:flutter/services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  String? selectedColor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Matt Chess Home'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Matt Chess',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            // Display the selected color
            if (selectedColor != null)
              Text(
                'Selected Colour: $selectedColor', // Display the selected color
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
              ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _showColorSelectionDialog(context);
              },
              child: const Text('Select Team'),
            ),
            const SizedBox(height: 20),
            if (selectedColor != null)
              ElevatedButton(
              onPressed: () => _startGame(context),
                child: const Text('Start Game'),
              ),
          ],
        ),
      ),
    );
  }

  // Function to show the dialog to choose the color
  void _showColorSelectionDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Choose Your Color'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                title: const Text('White'),
                onTap: () {
                  setState(() {
                    selectedColor = 'White';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Black'),
                onTap: () {
                  setState(() {
                    selectedColor = 'Black';
                  });
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: const Text('Random'),
                onTap: () {
                  setState(() {
                    selectedColor = (['White', 'Black']..shuffle()).first;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  // Function to start the game and navigate to the chessboard
  void _startGame(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChessBoardScreen(
          playerColor: selectedColor,  // Pass the selected color
        ),
        
      ),
    );
  }
}