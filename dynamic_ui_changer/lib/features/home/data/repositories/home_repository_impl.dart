import 'package:dartz/dartz.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/home_repository.dart';
import '../datasources/home_remote_datasource.dart';
import '../models/user_model.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDataSource remoteDataSource;

  HomeRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final users = await remoteDataSource.getUsers();
      return Right(users.map((model) => model.toEntity()).toList());
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> getUserById(int id) async {
    try {
      final user = await remoteDataSource.getUserById(id);
      return Right(user.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserEntity>> createUser(UserEntity user) async {
    try {
      final userModel = UserModel.fromEntity(user);
      final createdUser = await remoteDataSource.createUser(userModel);
      return Right(createdUser.toEntity());
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(int id) async {
    try {
      await remoteDataSource.deleteUser(id);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } on NetworkException catch (e) {
      return Left(Failure.network(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }
}
