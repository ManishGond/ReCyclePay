import 'package:flutter/material.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[800],
      appBar: AppBar(
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove the app bar's shadow
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Go back when the button is pressed
          },
        ),
      ),
      body: const Center(
        child: Text(
          'F  I  R  S  T \t P  A  G  E',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
