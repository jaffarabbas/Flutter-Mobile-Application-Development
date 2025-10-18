import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/network/api_client.dart';
import '../../data/datasources/posts_remote_datasource.dart';
import '../../data/repositories/posts_repository_impl.dart';
import '../../domain/repositories/posts_repository.dart';
import 'posts_state.dart';
import 'posts_viewmodel.dart';

// Data Source Provider
final postsRemoteDataSourceProvider = Provider<PostsRemoteDataSource>((ref) {
  return PostsRemoteDataSourceImpl(apiClient: getIt<ApiClient>());
});

// Repository Provider
final postsRepositoryProvider = Provider<PostsRepository>((ref) {
  return PostsRepositoryImpl(
    remoteDataSource: ref.watch(postsRemoteDataSourceProvider),
  );
});

// ViewModel Provider
final postsViewModelProvider =
    StateNotifierProvider<PostsViewModel, PostsState>((ref) {
  return PostsViewModel(
    repository: ref.watch(postsRepositoryProvider),
  );
});

// Computed/Derived State Providers
final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(postsViewModelProvider).isLoading;
});

final postsListProvider = Provider((ref) {
  return ref.watch(postsViewModelProvider).posts;
});

final errorMessageProvider = Provider<String?>((ref) {
  return ref.watch(postsViewModelProvider).errorMessage;
});
