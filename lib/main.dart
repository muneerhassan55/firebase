import 'package:firebase_tutorial/firestore/firestore_list_screen.dart';
import 'package:firebase_tutorial/firestore/upload_image.dart';
import 'package:firebase_tutorial/screens/check_user.dart';
import 'package:firebase_tutorial/screens/login_screen.dart';
import 'package:firebase_tutorial/screens/post/show_data.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          appBarTheme: const AppBarTheme(
            backgroundColor:
                Colors.deepPurple, // Set the app bar background color
            foregroundColor: Colors.white, // Set the app bar text/icon color
            elevation: 4, // Optionally set the elevation of the app bar
          ),
          useMaterial3: true,
        ),
        home: const UploadImage());
  }
}
