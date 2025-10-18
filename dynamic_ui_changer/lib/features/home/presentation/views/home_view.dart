import 'package:dynamic_ui_changer/features/home/presentation/viewmodels/home_state.dart';
import 'package:dynamic_ui_changer/features/home/presentation/viewmodels/home_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/router/app_router.dart';
import '../../../../core/utils/extensions.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../viewmodels/providers.dart';
import '../widgets/user_card.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  ConsumerState<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    // Fetch users when view loads (optional - can be triggered by button)
    // Future.microtask(() => ref.read(homeViewModelProvider.notifier).fetchUsers());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(homeViewModelProvider);
    final viewModel = ref.read(homeViewModelProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Dynamic Layout Changer',
        showBackButton: false, // No back button on home screen
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => viewModel.fetchUsers(),
            tooltip: 'Refresh Users',
          ),
        ],
      ),
      body: Column(
        children: [
          // Counter Section
          _buildCounterSection(state.counter, viewModel),

          const Divider(height: 1),

          // Users List Section
          Expanded(child: _buildUsersList(state, viewModel)),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => viewModel.fetchUsers(),
        child: const Icon(Icons.download),
      ),
    );
  }

  Widget _buildCounterSection(int counter, HomeViewModel viewModel) {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.amber.shade50,
      child: Column(
        children: [
          const Text(
            'Counter Example',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Text(
            '$counter',
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Flexible(
                child: ElevatedButton.icon(
                  onPressed: viewModel.decrementCounter,
                  icon: const Icon(Icons.remove, size: 18),
                  label: const Text('Dec'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: ElevatedButton.icon(
                  onPressed: viewModel.resetCounter,
                  icon: const Icon(Icons.refresh, size: 18),
                  label: const Text('Reset'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: ElevatedButton.icon(
                  onPressed: viewModel.incrementCounter,
                  icon: const Icon(Icons.add, size: 18),
                  label: const Text('Inc'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const Divider(),
          const SizedBox(height: 8),
          ElevatedButton.icon(
            onPressed: () => context.go(AppRouter.posts),
            icon: const Icon(Icons.article),
            label: const Text('View Posts (JSONPlaceholder API)'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUsersList(HomeState state, HomeViewModel viewModel) {
    if (state.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              state.errorMessage!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => viewModel.fetchUsers(),
              child: const Text('Retry'),
            ),
          ],
        ),
      );
    }

    if (state.users.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.people_outline, size: 64, color: Colors.grey),
            const SizedBox(height: 16),
            const Text(
              'No users found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => viewModel.fetchUsers(),
              icon: const Icon(Icons.download),
              label: const Text('Fetch Users'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      itemCount: state.users.length,
      itemBuilder: (context, index) {
        final user = state.users[index];
        return UserCard(
          user: user,
          onDelete: () {
            viewModel.deleteUser(user.id);
            context.showSnackBar('User ${user.name} deleted');
          },
        );
      },
    );
  }
}
