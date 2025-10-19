import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_freezed/model/person_model.dart';

/// StateNotifier for managing the list of people with CRUD operations
class PersonNotifier extends StateNotifier<List<PersonModel>> {
  PersonNotifier() : super(_initialPeople);

  // Initial sample data
  static final List<PersonModel> _initialPeople = [
    PersonModel(
      name: 'John Doe',
      age: 30,
      email: 'john.doe@example.com',
    ),
    PersonModel(
      name: 'Jane Smith',
      age: 25,
      email: 'jane.smith@example.com',
    ),
    PersonModel(
      name: 'Bob Johnson',
      age: 35,
      email: 'bob.johnson@example.com',
    ),
    PersonModel(
      name: 'Alice Williams',
      age: 28,
      email: 'alice.williams@example.com',
    ),
    PersonModel(
      name: 'Charlie Brown',
      age: 42,
    ),
  ];

  /// Create - Add a new person to the list
  void addPerson(PersonModel person) {
    state = [...state, person];
  }

  /// Read - Get a person by index (already handled by state)
  PersonModel? getPersonAt(int index) {
    if (index >= 0 && index < state.length) {
      return state[index];
    }
    return null;
  }

  /// Update - Update a person at a specific index
  void updatePerson(int index, PersonModel updatedPerson) {
    if (index >= 0 && index < state.length) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i == index) updatedPerson else state[i]
      ];
    }
  }

  /// Delete - Remove a person at a specific index
  void deletePerson(int index) {
    if (index >= 0 && index < state.length) {
      state = [
        for (int i = 0; i < state.length; i++)
          if (i != index) state[i]
      ];
    }
  }

  /// Clear all people
  void clearAll() {
    state = [];
  }

  /// Reset to initial data
  void resetToInitial() {
    state = _initialPeople;
  }
}

/// Provider for the PersonNotifier
final personProvider =
    StateNotifierProvider<PersonNotifier, List<PersonModel>>((ref) {
  return PersonNotifier();
});

/// Provider to get the count of people
final personCountProvider = Provider<int>((ref) {
  final people = ref.watch(personProvider);
  return people.length;
});
