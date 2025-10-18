import '../../../../core/network/api_client.dart';
import '../models/user_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<UserModel>> getUsers();
  Future<UserModel> getUserById(int id);
  Future<UserModel> createUser(UserModel user);
  Future<void> deleteUser(int id);
}

class HomeRemoteDataSourceImpl implements HomeRemoteDataSource {
  final ApiClient apiClient;

  HomeRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<UserModel>> getUsers() async {
    final response = await apiClient.get<List<dynamic>>('/users');
    return response.map((json) => UserModel.fromJson(json)).toList();
  }

  @override
  Future<UserModel> getUserById(int id) async {
    final response = await apiClient.get<Map<String, dynamic>>('/users/$id');
    return UserModel.fromJson(response);
  }

  @override
  Future<UserModel> createUser(UserModel user) async {
    final response = await apiClient.post<Map<String, dynamic>>(
      '/users',
      data: user.toJson(),
    );
    return UserModel.fromJson(response);
  }

  @override
  Future<void> deleteUser(int id) async {
    await apiClient.delete('/users/$id');
  }
}
