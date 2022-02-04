// ignore_for_file: non_constant_identifier_names

import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class StorageMethods{
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> UploadImageToStorage(String childName, Uint8List file,bool isPost) async {
    Reference reference = _storage.ref().child(childName).child(_auth.currentUser!.uid);
    UploadTask uploadTask = reference.putData(file);
    TaskSnapshot snap = await uploadTask;
    String downloadUrl = await snap.ref.getDownloadURL();
    return downloadUrl;
  }
}