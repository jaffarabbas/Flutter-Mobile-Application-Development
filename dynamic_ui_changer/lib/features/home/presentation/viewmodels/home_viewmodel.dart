import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_state.dart';

class HomeViewModel extends StateNotifier<HomeState> {
  final HomeRepository repository;

  HomeViewModel({required this.repository}) : super(const HomeState());

  // Example: Counter functionality
  void incrementCounter() {
    state = state.copyWith(counter: state.counter + 1);
  }

  void decrementCounter() {
    state = state.copyWith(counter: state.counter - 1);
  }

  void resetCounter() {
    state = state.copyWith(counter: 0);
  }

  // Fetch users from API
  Future<void> fetchUsers() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await repository.getUsers();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.map(
            server: (f) => f.message ?? 'Server error',
            cache: (f) => f.message ?? 'Cache error',
            network: (f) => f.message ?? 'Network error',
            validation: (f) => f.message ?? 'Validation error',
            unknown: (f) => f.message ?? 'Unknown error',
          ),
        );
      },
      (users) {
        state = state.copyWith(
          isLoading: false,
          users: users,
          errorMessage: null,
        );
      },
    );
  }

  // Delete user
  Future<void> deleteUser(int id) async {
    final result = await repository.deleteUser(id);

    result.fold(
      (failure) {
        state = state.copyWith(
          errorMessage: failure.map(
            server: (f) => f.message ?? 'Server error',
            cache: (f) => f.message ?? 'Cache error',
            network: (f) => f.message ?? 'Network error',
            validation: (f) => f.message ?? 'Validation error',
            unknown: (f) => f.message ?? 'Unknown error',
          ),
        );
      },
      (_) {
        // Remove user from state
        state = state.copyWith(
          users: state.users.where((user) => user.id != id).toList(),
        );
      },
    );
  }
}
