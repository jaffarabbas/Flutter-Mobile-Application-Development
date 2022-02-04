// ignore_for_file: unused_local_variable

import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:jz_instagram_app/resources/storage_methods.dart';

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
        UserCredential userCredential = await _auth
            .createUserWithEmailAndPassword(email: email, password: password);
        String photoUrl = await StorageMethods()
            .UploadImageToStorage('profilePics', file, false);
        print(photoUrl);
        //add user to firestore
        _firestore.collection('users').doc(userCredential.user!.uid).set({
          'username': username,
          'email': email,
          'password': password,
          'bio': bio,
          'followers': [],
          'following': [],
          'photoUrl': photoUrl,
        });
        response = "Success";
      }else{
        response = "Please Enter All Feilds";
      }
    }catch (err) {
      response = err.toString();
    }
    return response;
  }


  
//login method

Future<String> LoginInUser({
    required String email,
    required String password,
  }) async {
    String response = "Some Error Occured";
    try {
      if (email.isNotEmpty ||
          password.isNotEmpty 
          ) {
        await _auth.signInWithEmailAndPassword(email: email, password: password);
        response = "Success";
      }else{
        response = "Please Enter All Feilds";
      }
    }catch (err) {
      response = err.toString();
    }
    return response;
  }
}

