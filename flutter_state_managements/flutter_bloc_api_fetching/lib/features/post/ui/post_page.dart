import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_api_fetching/features/post/bloc/post_bloc.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostBloc postBloc = PostBloc();
  @override
  void initState() {
    // TODO: implement initState
    postBloc.add(PostInitialFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post Page'),
      ),
      body: BlocConsumer<PostBloc, PostState>(
        bloc: postBloc,
        listenWhen: (previous, current) => current is PostActionState,
        buildWhen: (previous, current) => current is! PostActionState,
        listener: (context, state) {},
        builder: (context, state) {
          switch (state.runtimeType) {
            case PostFetchingLoadingState:
              return Center(
                child: CircularProgressIndicator(),
              );
            case PostFetchingSuccessState:
              final successState = state as PostFetchingSuccessState;
              return Container(
                child: ListView.builder(
                  itemCount: successState.postList.length,
                  itemBuilder: (context, index) {
                    print(successState.postList.length);
                    return Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [Text(successState.postList[index].title)],
                      ),
                    );
                  },
                ),
              );
            default:
              return Center(
                child: Container(
                  child: Text('Data Not Found'),
                ),
              );
          }
        },
      ),
    );
  }
}
