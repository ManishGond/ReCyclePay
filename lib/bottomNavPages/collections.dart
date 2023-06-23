import 'package:flutter/material.dart';

class UserCollections extends StatelessWidget {
  const UserCollections({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.0),
        child: Text(
          'PlasticBottle Collections History/ For depositing in the future',
          style: TextStyle(fontSize: 20, color: Colors.red),
        ),
      ),
    );
  }
}
