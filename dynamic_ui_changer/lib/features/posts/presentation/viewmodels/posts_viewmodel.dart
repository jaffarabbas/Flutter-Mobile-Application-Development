import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/repositories/posts_repository.dart';
import 'posts_state.dart';

class PostsViewModel extends StateNotifier<PostsState> {
  final PostsRepository repository;

  PostsViewModel({required this.repository}) : super(const PostsState());

  Future<void> fetchPosts() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final result = await repository.getPosts();

    result.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          errorMessage: failure.map(
            server: (f) => f.message ?? 'Server error occurred',
            cache: (f) => f.message ?? 'Cache error occurred',
            network: (f) => f.message ?? 'Network error. Please check your connection',
            validation: (f) => f.message ?? 'Validation error occurred',
            unknown: (f) => f.message ?? 'Unknown error occurred',
          ),
        );
      },
      (posts) {
        state = state.copyWith(
          isLoading: false,
          posts: posts,
          errorMessage: null,
        );
      },
    );
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}
