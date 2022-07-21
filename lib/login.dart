// import 'dart:js';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:signup/homepage.dart';
import 'package:signup/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';

class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  // String name = "";
  String email = "";
  String password = "";
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  userlogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  TextEditingController _email = new TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
  }

  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 196.0, horizontal: 32.0),
              child: Column(
                children: [
                  Text(
                    "Wellcome",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    // controller: _email,
                    decoration: InputDecoration(
                      hintText: "Enter Username",
                      labelText: "username",
                    ),
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please Enter Email';
                      } else if (!value.contains('@')) {
                        return 'Please Enter Valid Email';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: " Enter password",
                      labelText: "password",
                    ),
                    controller: passwordController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "password cannot be empty";
                      } else if (value.length < 6) {
                        return "password should be atleat 6 character";
                      }
                      return null;
                    },
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  Container(
                    height: 50,
                    padding: const EdgeInsets.all(0),
                    child: ElevatedButton(
                        child: const Text('Login'),
                        onPressed: () async {
                          if (_formkey.currentState!.validate()) {
                            setState(() {
                              email = emailController.text;
                              password = passwordController.text;
                            });
                            // userlogin();
                          }
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .signInWithEmailAndPassword(
                                    email: email, password: password);
                            if (UserCredential != null) {
                              Navigator.pushNamed(context, '/homepage');
                            }
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'user-not-found') {
                              print('No user found for that email.');
                            } else if (e.code == 'wrong-password') {
                              print('Wrong password provided for that user.');
                            }
                          }
                        }),
                  ),
                  Row(
                    children: <Widget>[
                      const Text('Does not have account?'),
                      TextButton(
                          child: const Text(
                            'Sign in',
                            style: TextStyle(fontSize: 20),
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SignUp(),
                              ),
                            );
                          })
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
