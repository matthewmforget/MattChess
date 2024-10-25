import 'package:flutter/material.dart';
import '../GUI/homescreen.dart'; // Import your HomeScreen
// import 'board.dart'; // Import your ChessBoardScreen if needed

void main() {
  runApp(const mattchess());
}

class mattchess extends StatelessWidget {
  const mattchess({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Matt Chess',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(), // Set HomeScreen as the home widget
    );
  }
}