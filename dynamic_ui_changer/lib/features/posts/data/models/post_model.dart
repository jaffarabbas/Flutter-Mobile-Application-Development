import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/post_entity.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
class PostModel with _$PostModel {
  const PostModel._();

  const factory PostModel({
    required int id,
    required int userId,
    required String title,
    required String body,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);

  // Convert to Entity
  PostEntity toEntity() => PostEntity(
        id: id,
        userId: userId,
        title: title,
        body: body,
      );

  // Create from Entity
  factory PostModel.fromEntity(PostEntity entity) => PostModel(
        id: entity.id,
        userId: entity.userId,
        title: entity.title,
        body: entity.body,
      );
}
