import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //signup user
  Future<String> SignUpUser({
    required String email,
    required String password,
    required String username,
    required String bio,
    required Uint8List file,
  }) async {
    String response = "Some Error Occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty ||
          username.isNotEmpty ||
          bio.isNotEmpty ||
          file != null) {
            UserCredential userCredential = await _auth.createUserWithEmailAndPassword(email: email, password: password);
            //add user to firestore
            _firestore.collection('users').doc(userCredential.user!.uid).set({
              'username': username,
              'email': email,
              'password': password,
              'bio': bio,
              'followers': [],
              'following': [],
            });
            response = "Success";
          }
    } catch (err) {
      response = err.toString();
    }
    return response;
  }
}
