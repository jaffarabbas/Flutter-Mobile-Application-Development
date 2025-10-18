import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/network/api_client.dart';
import '../../data/datasources/home_remote_datasource.dart';
import '../../data/repositories/home_repository_impl.dart';
import '../../domain/repositories/home_repository.dart';
import 'home_state.dart';
import 'home_viewmodel.dart';

// Data Source Provider
final homeRemoteDataSourceProvider = Provider<HomeRemoteDataSource>((ref) {
  return HomeRemoteDataSourceImpl(apiClient: getIt<ApiClient>());
});

// Repository Provider
final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepositoryImpl(
    remoteDataSource: ref.watch(homeRemoteDataSourceProvider),
  );
});

// ViewModel Provider
final homeViewModelProvider =
    StateNotifierProvider<HomeViewModel, HomeState>((ref) {
  return HomeViewModel(
    repository: ref.watch(homeRepositoryProvider),
  );
});

// Computed/Derived State Providers (optional but useful)
final isLoadingProvider = Provider<bool>((ref) {
  return ref.watch(homeViewModelProvider).isLoading;
});

final usersProvider = Provider((ref) {
  return ref.watch(homeViewModelProvider).users;
});

final counterProvider = Provider<int>((ref) {
  return ref.watch(homeViewModelProvider).counter;
});
