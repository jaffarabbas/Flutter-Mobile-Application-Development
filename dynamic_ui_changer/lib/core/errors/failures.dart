import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class Failure with _$Failure {
  const factory Failure.server({String? message}) = ServerFailure;
  const factory Failure.cache({String? message}) = CacheFailure;
  const factory Failure.network({String? message}) = NetworkFailure;
  const factory Failure.validation({String? message}) = ValidationFailure;
  const factory Failure.unknown({String? message}) = UnknownFailure;
}
