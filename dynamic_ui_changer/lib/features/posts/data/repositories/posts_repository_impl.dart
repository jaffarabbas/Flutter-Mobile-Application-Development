import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/post_entity.dart';
import '../../domain/repositories/posts_repository.dart';
import '../datasources/posts_remote_datasource.dart';

class PostsRepositoryImpl implements PostsRepository {
  final PostsRemoteDataSource remoteDataSource;

  PostsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PostEntity>>> getPosts() async {
    try {
      final posts = await remoteDataSource.getPosts();
      return Right(posts.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, PostEntity>> getPostById(int id) async {
    try {
      final post = await remoteDataSource.getPostById(id);
      return Right(post.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }
}
