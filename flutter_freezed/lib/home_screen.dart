import 'package:flutter/material.dart';
import 'package:flutter_freezed/model/person_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // Sample data using the freezed PersonModel
  List<PersonModel> get people => [
    PersonModel(name: 'John Doe', age: 30, email: 'john.doe@example.com'),
    PersonModel(name: 'Jane Smith', age: 25, email: 'jane.smith@example.com'),
    PersonModel(name: 'Bob Johnson', age: 35, email: 'bob.johnson@example.com'),
    PersonModel(
      name: 'Alice Williams',
      age: 28,
      email: 'alice.williams@example.com',
    ),
    PersonModel(name: 'Charlie Brown', age: 42),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('People List'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: ListView.builder(
        itemCount: people.length,
        padding: const EdgeInsets.all(8.0),
        itemBuilder: (context, index) {
          final person = people[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
            elevation: 2,
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: Text(
                  person.name?.substring(0, 1).toUpperCase() ?? '?',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              title: Text(
                person.name ?? 'Unknown',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Age: ${person.age ?? 'N/A'}'),
                  if (person.email != null)
                    Text(
                      person.email!,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary,
                        fontSize: 12,
                      ),
                    ),
                ],
              ),
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Colors.grey[400],
              ),
              onTap: () {
                // Show person details in a dialog
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(person.name ?? 'Unknown'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Age: ${person.age ?? 'N/A'}'),
                        const SizedBox(height: 8),
                        Text('Email: ${person.email ?? 'N/A'}'),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Example: Create a new person using copyWith (freezed feature)
          final newPerson = people[0].copyWith(name: 'New Person', age: 20);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Created: ${newPerson.name}, Age: ${newPerson.age}',
              ),
            ),
          );
        },
        tooltip: 'Demo copyWith',
        child: const Icon(Icons.add),
      ),
    );
  }
}
