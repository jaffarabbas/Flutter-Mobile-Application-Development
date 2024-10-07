
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/pages/add-user.dart';
import 'package:flutter_firebase/pages/user-list.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Firebase User Add'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Text(
              "Add a User to Firebase Firestore",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            // AddUser widget for user input form
            AddUser(),
            SizedBox(height: 20),
            // Display the list of users
            Expanded(child: UserList()),
          ],
        ),
      ),
    );
  }
}