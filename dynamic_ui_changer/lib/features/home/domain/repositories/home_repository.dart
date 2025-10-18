import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/user_entity.dart';

abstract class HomeRepository {
  Future<Either<Failure, List<UserEntity>>> getUsers();
  Future<Either<Failure, UserEntity>> getUserById(int id);
  Future<Either<Failure, UserEntity>> createUser(UserEntity user);
  Future<Either<Failure, void>> deleteUser(int id);
}
