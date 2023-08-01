/// >>>>>>  Author: Berke Gürel <<<<<
/// Explanation:
/// The code below is a Flutter app that initializes
/// Firebase and checks if the user is logged in. If the user is logged in,
/// it navigates to the HomePage, otherwise, it navigates to the LoginPage.
/// The app uses a StreamBuilder to listen for changes in the user's authentication state.
/// The app also sets the app bar color to a custom blue color.

import 'package:demo_app/screens/home_page.dart';
import 'package:demo_app/screens/login_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); //firebase_core

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          // primarySwatch: Colors.red,
          appBarTheme:
              const AppBarTheme(color: Color.fromARGB(255, 16, 99, 166))),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          //if statement in the bellow check if user loged in
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            if (snapshot.hasData && snapshot.data != null) {
              // User is logged in
              return HomePage();
            } else {
              // User is not logged in
              return LoginPage();
            }
          }
        },
      ),
    );
  }
}
