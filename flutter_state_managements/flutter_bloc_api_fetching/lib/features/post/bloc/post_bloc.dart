import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter_bloc_api_fetching/features/post/mappers/PostDataUiModal.dart';
import 'package:flutter_bloc_api_fetching/features/post/repos/post_repo.dart';
import 'package:meta/meta.dart';
import 'package:http/http.dart' as http;

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostInitialFetchEvent>(postInitialFetchEvent);
  }

  FutureOr<void> postInitialFetchEvent(
      PostInitialFetchEvent event, Emitter<PostState> emit) async {
    try {
      emit(PostFetchingLoadingState());
      var posts = await PostRepo.getPosts();
      emit(PostFetchingSuccessState(postList: posts));
    } catch (e) {
      print(e.toString());
      emit(PostFetchingErrorState());
    }
  }
}
