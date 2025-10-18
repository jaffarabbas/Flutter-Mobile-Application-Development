import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../shared/widgets/custom_app_bar.dart';
import '../viewmodels/providers.dart';
import '../widgets/post_card.dart';

class PostsView extends ConsumerStatefulWidget {
  const PostsView({super.key});

  @override
  ConsumerState<PostsView> createState() => _PostsViewState();
}

class _PostsViewState extends ConsumerState<PostsView> {
  @override
  void initState() {
    super.initState();
    // Fetch posts when the view loads
    Future.microtask(() => ref.read(postsViewModelProvider.notifier).fetchPosts());
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(postsViewModelProvider);
    final viewModel = ref.read(postsViewModelProvider.notifier);

    return Scaffold(
      appBar: CustomAppBar(
        title: 'Posts from JSONPlaceholder',
        showBackButton: true, // Show back button to return to home
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => viewModel.fetchPosts(),
            tooltip: 'Refresh',
          ),
        ],
      ),
      body: _buildBody(state, viewModel),
    );
  }

  Widget _buildBody(state, viewModel) {
    // Loading State
    if (state.isLoading && state.posts.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Loading posts...'),
          ],
        ),
      );
    }

    // Error State
    if (state.errorMessage != null && state.posts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.error_outline,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 16),
              Text(
                'Error',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              Text(
                state.errorMessage!,
                style: const TextStyle(color: Colors.red),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: () => viewModel.fetchPosts(),
                icon: const Icon(Icons.refresh),
                label: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    // Empty State
    if (state.posts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.article_outlined,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            const Text(
              'No posts found',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            const SizedBox(height: 16),
            ElevatedButton.icon(
              onPressed: () => viewModel.fetchPosts(),
              icon: const Icon(Icons.download),
              label: const Text('Load Posts'),
            ),
          ],
        ),
      );
    }

    // Success State - Display Posts
    return Column(
      children: [
        // Show loading indicator at top if refreshing
        if (state.isLoading)
          const LinearProgressIndicator(),

        // Posts count header
        Container(
          padding: const EdgeInsets.all(16),
          color: Colors.amber.shade50,
          child: Row(
            children: [
              const Icon(Icons.article, color: Colors.amber),
              const SizedBox(width: 8),
              Text(
                '${state.posts.length} Posts Loaded',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),

        // Posts List
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => viewModel.fetchPosts(),
            child: ListView.builder(
              itemCount: state.posts.length,
              itemBuilder: (context, index) {
                final post = state.posts[index];
                return PostCard(post: post);
              },
            ),
          ),
        ),
      ],
    );
  }
}
