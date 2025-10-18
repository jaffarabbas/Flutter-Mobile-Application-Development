import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user_entity.dart';

part 'home_state.freezed.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState({
    @Default([]) List<UserEntity> users,
    @Default(false) bool isLoading,
    String? errorMessage,
    @Default(0) int counter,
  }) = _HomeState;
}
