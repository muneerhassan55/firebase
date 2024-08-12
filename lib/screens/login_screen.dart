import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_tutorial/components/ui_helper.dart';
import 'package:firebase_tutorial/screens/forgat_passsword.dart';
import 'package:firebase_tutorial/screens/phone_authentication.dart';
import 'package:firebase_tutorial/screens/signup_Screen.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  logIn(String email, String pass) async {
    if (email.isEmpty || pass.isEmpty) {
      UiHelper.CustomAlertBox(context, 'Please Enter the Required fields');
    } else {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: pass);

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
            message = 'An unexpected error occurred: ${e.code.toString()}';
        }
        UiHelper.CustomAlertBox(context, message);
      } catch (e) {
        // Handle any other errors
        UiHelper.CustomAlertBox(context, '${e.toString()}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login Page"),
        centerTitle: true,
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
              logIn(_emailController.text.toString(),
                  _passwordController.text.toString());
            }, 'Login'),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ForgetPassword()));
                    },
                    child: Text(
                      textAlign: TextAlign.end,
                      "Forget Password",
                      style: TextStyle(color: Colors.purple),
                    )),
              ],
            ),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have an account"),
                TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Text("Sign up"))
              ],
            ),
            UiHelper.CustomButton(() {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PhoneAuthenticationScreen()));
            }, 'Login with Phone')
          ],
        ),
      ),
    );
  }
}
