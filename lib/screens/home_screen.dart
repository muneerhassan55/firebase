import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/screens/login_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        actions: [
          InkWell(
              onTap: () {
                logOut();
              },
              child: Icon(Icons.logout))
        ],
      ),
    );
  }

  logOut() async {
    FirebaseAuth.instance.signOut().then((value) => Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginScreen())));
  }
}
