import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/screens/home_screen.dart';
import 'package:firebase_tutorial/screens/login_screen.dart';
import 'package:flutter/material.dart';

class CheckUser extends StatelessWidget {
  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<User?>(
      future: _checkUser(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        // Show loading indicator while the future is being resolved
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data != null) {
          // If the user is logged in, navigate to HomeScreen
          return HomeScreen();
        } else {
          // If the user is not logged in, navigate to LoginScreen
          return LoginScreen();
        }
      },
    );
  }

  Future<User?> _checkUser() async {
    return FirebaseAuth.instance.currentUser;
  }
}
