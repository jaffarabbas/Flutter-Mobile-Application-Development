import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    return StreamBuilder<QuerySnapshot>(
      stream: users.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        return ListView(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> user = document.data()! as Map<String, dynamic>;

            return ListTile(
              title: Text(user['full_name']),
              subtitle: Text('Company: ${user['company']}, Age: ${user['age']}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () => _editUser(context, document),
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () => _deleteUser(document.id),
                  ),
                ],
              ),
            );
          }).toList(),
        );
      },
    );
  }

  // Function to delete a user
  Future<void> _deleteUser(String userId) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(userId).delete();
      print("User deleted");
    } catch (error) {
      print("Failed to delete user: $error");
    }
  }

  // Function to edit a user
  void _editUser(BuildContext context, DocumentSnapshot document) {
    Map<String, dynamic> user = document.data()! as Map<String, dynamic>;
    TextEditingController fullNameController = TextEditingController(text: user['full_name']);
    TextEditingController companyController = TextEditingController(text: user['company']);
    TextEditingController ageController = TextEditingController(text: user['age'].toString());

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Edit User'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: fullNameController,
                decoration: InputDecoration(labelText: "Full Name"),
              ),
              TextField(
                controller: companyController,
                decoration: InputDecoration(labelText: "Company"),
              ),
              TextField(
                controller: ageController,
                decoration: InputDecoration(labelText: "Age"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () async {
                // Update user data in Firestore
                await _updateUser(document.id, fullNameController.text, companyController.text, int.parse(ageController.text));
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Function to update user data
  Future<void> _updateUser(String userId, String fullName, String company, int age) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    try {
      await users.doc(userId).update({
        'full_name': fullName,
        'company': company,
        'age': age,
      });
      print("User updated");
    } catch (error) {
      print("Failed to update user: $error");
    }
  }
}
