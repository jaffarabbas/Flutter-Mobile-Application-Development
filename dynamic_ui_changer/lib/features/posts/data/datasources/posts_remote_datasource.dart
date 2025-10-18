import '../../../../core/network/api_client.dart';
import '../models/post_model.dart';

abstract class PostsRemoteDataSource {
  Future<List<PostModel>> getPosts();
  Future<PostModel> getPostById(int id);
}

class PostsRemoteDataSourceImpl implements PostsRemoteDataSource {
  final ApiClient apiClient;

  PostsRemoteDataSourceImpl({required this.apiClient});

  @override
  Future<List<PostModel>> getPosts() async {
    final response = await apiClient.get<List<dynamic>>('/posts');
    return response.map((json) => PostModel.fromJson(json as Map<String, dynamic>)).toList();
  }

  @override
  Future<PostModel> getPostById(int id) async {
    final response = await apiClient.get<Map<String, dynamic>>('/posts/$id');
    return PostModel.fromJson(response);
  }
}
