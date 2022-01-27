// ignore_for_file: prefer_const_constructors, unnecessary_new, deprecated_member_use
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_10/pages/login_page.dart';
import 'package:flutter_gravatar/flutter_gravatar.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = new TextEditingController();
  TextEditingController nameController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();
  Gravatar? _gravatar;
  bool visibalePassword = false;

  addData(String userId) async {
    await FirebaseFirestore.instance.collection('users').add({
      'userId': userId,
      'userEmail': emailController.value.text,
      'username': nameController.value.text,
      'userImage': _gravatar!.imageUrl(),
    });
  }

  void updateUser(User? user) async {
    user!.updateDisplayName(nameController.text);
    _gravatar = Gravatar(emailController.text);
    user.updatePhotoURL(_gravatar!.imageUrl());
    print(user);
  }

  Future Register() async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: emailController.value.text,
              password: passwordController.value.text);
      _showMyDialog('User Inserted Succesfully', false);
      updateUser(userCredential.user!);
      addData(userCredential.user!.uid);
      emailController.clear();
      nameController.clear();
      passwordController.clear();
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => LoginPage(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        _showMyDialog('The password provided is too weak.', true);
      } else if (e.code == 'email-already-in-use') {
        _showMyDialog('The account already exists for that email.', true);
      }
    } catch (e) {
      print(e);
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
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Register",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.green),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.green, width: 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.green, width: 0),
                        ),
                        hintText: "Enter Username"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20),
                  padding: EdgeInsets.all(10),
                  child: TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.green, width: 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.green, width: 0),
                        ),
                        hintText: "Enter Name"),
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
                          borderSide: BorderSide(color: Colors.green, width: 0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(color: Colors.green, width: 0),
                        ),
                        suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                visibalePassword
                                    ? visibalePassword = false
                                    : visibalePassword = true;
                              });
                            },
                            icon: Icon(Icons.remove_red_eye,color: Colors.green,))),
                  ),
                ),
                InkWell(
                  onTap: () {
                    Register();
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 60, vertical: 17),
                    child: Text(
                      "Resgister",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
