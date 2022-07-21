// import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:signup/homepage.dart';
import 'package:signup/login.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final _formkey = GlobalKey<FormState>();
  String email = "";
  String password = "";
  String name = "";
  String secondname = "";
  final nameController = TextEditingController();
  final secondnameController = TextEditingController();
  userlogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  TextEditingController _name = new TextEditingController();
  TextEditingController _secondname = new TextEditingController();

  CollectionReference emailsignin =
      FirebaseFirestore.instance.collection('emailsignin');

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    secondnameController.dispose();
  }

  Widget build(BuildContext context) {
    return Material(
      child: Form(
        key: _formkey,
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 106.0, horizontal: 32.0),
              child: Column(
                children: [
                  Text(
                    "SignUp",
                    style: TextStyle(
                      fontSize: 42,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Username",
                      labelText: "username",
                    ),
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Name",
                      labelText: "Name",
                    ),
                    controller: nameController,
                    onChanged: (value) {
                      name = value;
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      hintText: "Enter Second Name",
                      labelText: "second Name",
                    ),
                    controller: secondnameController,
                    onChanged: (value) {
                      secondname = value;
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      hintText: "Enter Your  password",
                      labelText: "password",
                    ),
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  SizedBox(
                    height: 25.0,
                  ),
                  ElevatedButton(
                      onPressed: () async {
                        if (_formkey.currentState!.validate()) {
                          setState(() {
                            name = nameController.text;
                            secondname = secondnameController.text;
                          });
                        }
                        userlogin();
                        try {
                          UserCredential userCredential = await FirebaseAuth
                              .instance
                              .createUserWithEmailAndPassword(
                                  email: email, password: password);
                          if (UserCredential != null) {
                            Navigator.pushNamed(context, '/homepage');
                          }
                        } on FirebaseAuthException catch (e) {
                          if (e.code == 'weak-password') {
                            print('The password provided is too weak.');
                          } else if (e.code == 'email-already-in-use') {
                            print('The account already exists for that email.');
                          }
                        } catch (e) {
                          print(e);
                        }
                      },
                      child: Text('Submit'))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
