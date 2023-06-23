import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../mainpage.dart';
import 'login_or_register.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});
//main
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        //is user logged in
        if (snapshot.hasData) {
          return const MainPage();
        } else {
          return const MainPage();
        }
      },
    ));
  }
}
