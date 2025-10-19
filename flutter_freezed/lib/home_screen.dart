import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_freezed/model/person_model.dart';
import 'package:flutter_freezed/providers/person_provider.dart';
import 'package:flutter_freezed/widgets/person_form_dialog.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  /// Show dialog to create a new person
  void _showCreateDialog(BuildContext context, WidgetRef ref) async {
    final person = await showDialog<PersonModel>(
      context: context,
      builder: (context) => const PersonFormDialog(title: 'Add New Person'),
    );

    if (person != null && context.mounted) {
      ref.read(personProvider.notifier).addPerson(person);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Added ${person.name}'),
          backgroundColor: Colors.green,
          action: SnackBarAction(
            label: 'Undo',
            textColor: Colors.white,
            onPressed: () {
              // Find and remove the last added person (this one)
              final people = ref.read(personProvider);
              final index = people.indexOf(person);
              if (index != -1) {
                ref.read(personProvider.notifier).deletePerson(index);
              }
            },
          ),
        ),
      );
    }
  }

  /// Show dialog to edit an existing person
  void _showEditDialog(
    BuildContext context,
    WidgetRef ref,
    int index,
    PersonModel person,
  ) async {
    final updatedPerson = await showDialog<PersonModel>(
      context: context,
      builder: (context) =>
          PersonFormDialog(title: 'Edit Person', person: person),
    );

    if (updatedPerson != null && context.mounted) {
      ref.read(personProvider.notifier).updatePerson(index, updatedPerson);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Updated ${updatedPerson.name}'),
          backgroundColor: Colors.blue,
        ),
      );
    }
  }

  /// Show confirmation dialog and delete person
  void _showDeleteDialog(
    BuildContext context,
    WidgetRef ref,
    int index,
    PersonModel person,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Person'),
        content: Text('Are you sure you want to delete ${person.name}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              ref.read(personProvider.notifier).deletePerson(index);
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Deleted ${person.name}'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            style: FilledButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final people = ref.watch(personProvider);
    final personCount = ref.watch(personCountProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('People List ($personCount)'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          if (people.isNotEmpty)
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == 'clear') {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Clear All'),
                      content: const Text(
                        'Are you sure you want to delete all people?',
                      ),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('Cancel'),
                        ),
                        FilledButton(
                          onPressed: () {
                            ref.read(personProvider.notifier).clearAll();
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('All people cleared'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          },
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text('Clear All'),
                        ),
                      ],
                    ),
                  );
                } else if (value == 'reset') {
                  ref.read(personProvider.notifier).resetToInitial();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Reset to initial data'),
                      backgroundColor: Colors.blue,
                    ),
                  );
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(
                  value: 'reset',
                  child: Row(
                    children: [
                      Icon(Icons.refresh),
                      SizedBox(width: 8),
                      Text('Reset to Initial'),
                    ],
                  ),
                ),
                const PopupMenuItem(
                  value: 'clear',
                  child: Row(
                    children: [
                      Icon(Icons.delete_sweep, color: Colors.red),
                      SizedBox(width: 8),
                      Text('Clear All', style: TextStyle(color: Colors.red)),
                    ],
                  ),
                ),
              ],
            ),
        ],
      ),
      body: people.isEmpty
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.people_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'No people yet',
                    style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Tap the + button to add someone',
                    style: TextStyle(fontSize: 14, color: Colors.grey[500]),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: people.length,
              padding: const EdgeInsets.all(8.0),
              itemBuilder: (context, index) {
                final person = people[index];
                return Card(
                  margin: const EdgeInsets.symmetric(
                    vertical: 8.0,
                    horizontal: 4.0,
                  ),
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
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, size: 20),
                          onPressed: () =>
                              _showEditDialog(context, ref, index, person),
                          tooltip: 'Edit',
                          color: Colors.blue,
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, size: 20),
                          onPressed: () =>
                              _showDeleteDialog(context, ref, index, person),
                          tooltip: 'Delete',
                          color: Colors.red,
                        ),
                      ],
                    ),
                    onTap: () {
                      // Show person details in a dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: Theme.of(
                                  context,
                                ).colorScheme.primary,
                                child: Text(
                                  person.name?.substring(0, 1).toUpperCase() ??
                                      '?',
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(child: Text(person.name ?? 'Unknown')),
                            ],
                          ),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDetailRow(
                                Icons.calendar_today,
                                'Age',
                                '${person.age ?? 'N/A'}',
                              ),
                              const SizedBox(height: 12),
                              _buildDetailRow(
                                Icons.email,
                                'Email',
                                person.email ?? 'Not provided',
                              ),
                            ],
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('Close'),
                            ),
                            FilledButton.icon(
                              onPressed: () {
                                Navigator.pop(context);
                                _showEditDialog(context, ref, index, person);
                              },
                              icon: const Icon(Icons.edit, size: 18),
                              label: const Text('Edit'),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateDialog(context, ref),
        tooltip: 'Add Person',
        icon: const Icon(Icons.person_add),
        label: const Text('Add Person'),
      ),
    );
  }

  Widget _buildDetailRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 20, color: Colors.grey[600]),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
