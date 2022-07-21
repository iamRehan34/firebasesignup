import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:signup/homepage.dart';
import 'package:signup/signup.dart';
import 'login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          print("Something went Wrong");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return MaterialApp(
              debugShowCheckedModeBanner: false,
              initialRoute: '/login',
              routes: {
                '/login': (context) => loginPage(),
                '/homepage': (context) => HomePage(),
                '/signup': (context) => SignUp(),
                // '/homipage': (context) => homipage(),
              });
        }
        return CircularProgressIndicator();
      },
    );
  }
}
  // runApp(MaterialApp(
  //   debugShowCheckedModeBanner: false,
  //   initialRoute: '/login',
  //   routes: {
  //     '/login': (context) => loginPage(),
  //     '/homepage': (context) => HomePage(),
  //     '/signup': (context) => SignUp(),
  //     // '/homipage': (context) => homipage(),
  //   },
  // ));

