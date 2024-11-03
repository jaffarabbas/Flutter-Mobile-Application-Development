part of 'post_bloc.dart';

@immutable
sealed class PostState {}

abstract class PostActionState extends PostState {}

class PostInitial extends PostState {}

class PostFetchingLoadingState extends PostState {}

class PostFetchingErrorState extends PostState {}

class PostFetchingSuccessState extends PostState {
  final List<PostDataUiModal> postList;

  PostFetchingSuccessState({required this.postList});
}
