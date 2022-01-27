// ignore_for_file: prefer_const_constructors, unnecessary_new, unused_local_variable, unnecessary_string_interpolations, non_constant_identifier_names, avoid_types_as_parameter_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_10/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  bool visibalePassword = false;
  void LoginIn() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(
              email: emailController.value.text,
              password: passwordController.value.text);
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => HomePage(user: userCredential.user!),
        ),
      );
      emailController.clear();
      passwordController.clear();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        _showMyDialog('No user found for that email.', true);
      } else if (e.code == 'wrong-password') {
        _showMyDialog('Wrong password provided for that user.', true);
      } else if (e.code == '') {
        _showMyDialog('Empty Feilds.', true);
      }
    }
  }

  Future<void> _showMyDialog(String value, bool state) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(state ? 'Error Message' : 'Success Messages'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('$value'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        elevation: 0,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold,color: Colors.green),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(color: Colors.green, width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(color: Colors.green, width: 0),
                          ),
                          hintText: "Enter Username"),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.all(10),
                    child: TextField(
                      controller: passwordController,
                      obscureText: visibalePassword ? false : true,
                      decoration: InputDecoration(
                          hintText: "Enter Password",
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(color: Colors.green, width: 0),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(25.0),
                            borderSide:
                                BorderSide(color: Colors.green, width: 0),
                          ),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  visibalePassword
                                      ? visibalePassword = false
                                      : visibalePassword = true;
                                });
                              },
                              icon: Icon(Icons.remove_red_eye,color: Colors.green))),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      LoginIn();
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 20),
                      decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(horizontal:60,vertical:17),
                      child: Text(
                        "Login",
                        style: TextStyle(color: Colors.white,fontSize: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
