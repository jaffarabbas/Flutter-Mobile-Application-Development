import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddUser extends StatefulWidget {
  @override
  _AddUserState createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController companyController = TextEditingController();
  final TextEditingController ageController = TextEditingController();

  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> addUser() {
    final String fullName = fullNameController.text;
    final String company = companyController.text;
    final int age = int.parse(ageController.text);

    return users
        .add({
      'full_name': fullName,
      'company': company,
      'age': age,
    })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: fullNameController,
          decoration: InputDecoration(
            labelText: "Full Name",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: companyController,
          decoration: InputDecoration(
            labelText: "Company",
            border: OutlineInputBorder(),
          ),
        ),
        SizedBox(height: 10),
        TextField(
          controller: ageController,
          decoration: InputDecoration(
            labelText: "Age",
            border: OutlineInputBorder(),
          ),
          keyboardType: TextInputType.number,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            addUser();
            fullNameController.clear();
            companyController.clear();
            ageController.clear();
            setState(() {}); // Refresh the user list
          },
          child: Text("Add User"),
        ),
      ],
    );
  }

  @override
  void dispose() {
    fullNameController.dispose();
    companyController.dispose();
    ageController.dispose();
    super.dispose();
  }
}
