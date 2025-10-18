import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/post_entity.dart';

part 'posts_state.freezed.dart';

@freezed
class PostsState with _$PostsState {
  const factory PostsState({
    @Default([]) List<PostEntity> posts,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _PostsState;
}
