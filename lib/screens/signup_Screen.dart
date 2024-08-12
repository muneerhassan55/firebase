import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/screens/home_screen.dart';
import 'package:firebase_tutorial/screens/login_screen.dart';
import 'package:flutter/material.dart';

import '../components/ui_helper.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  // signUp(String email, String Pass) async {
  //   if (email == "" && Pass == "") {
  //     UiHelper.CustomAlertBox(context, 'Please Enter Required field');
  //   } else {
  //     UserCredential? userCredential;
  //     try {
  //       userCredential = await FirebaseAuth.instance
  //           .createUserWithEmailAndPassword(email: email, password: Pass)
  //           .then((value) {
  //         Navigator.push(
  //             context, MaterialPageRoute(builder: (context) => HomeScreen()));
  //       });
  //     } on FirebaseAuthException catch (e) {
  //       UiHelper.CustomAlertBox(context, e.code.toString());
  //     }
  //   }
  // }
  signUp(String email, String pass) async {
    if (email.isEmpty || pass.isEmpty) {
      UiHelper.CustomAlertBox(context, 'Please enter the required fields');
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: pass);

        // Navigate to HomeScreen only if sign up is successful
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
      } on FirebaseAuthException catch (e) {
        // Handle specific Firebase Auth errors
        String message;
        switch (e.code) {
          case 'email-already-in-use':
            message = 'The email is already in use. Please try logging in.';
            break;
          case 'weak-password':
            message = 'The password provided is too weak.';
            break;
          case 'invalid-email':
            message = 'The email address is not valid.';
            break;
          default:
            message = 'An unexpected error occurred: ${e.message}';
        }
        UiHelper.CustomAlertBox(context, message);
      } catch (e) {
        // Handle any other errors
        UiHelper.CustomAlertBox(context, 'An error occurred: ${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sign Up"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UiHelper.CustomTextField(
                _emailController, 'Email', Icons.email, false),
            SizedBox(
              height: 10,
            ),
            UiHelper.CustomTextField(
                _passwordController, 'Password', Icons.password, true),
            SizedBox(
              height: 30,
            ),
            UiHelper.CustomButton(() {
              signUp(_emailController.text.toString(),
                  _passwordController.text.toString());
            }, 'Sign Up'),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    child: Text("Login"))
              ],
            )
          ],
        ),
      ),
    );
  }
}
