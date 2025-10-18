import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/home/presentation/views/home_view.dart';
import '../../features/posts/presentation/views/posts_view.dart';

class AppRouter {
  static const String home = '/';
  static const String posts = '/posts';

  static final GoRouter router = GoRouter(
    initialLocation: home,
    routes: [
      GoRoute(
        path: home,
        name: 'home',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const HomeView(),
        ),
      ),
      GoRoute(
        path: posts,
        name: 'posts',
        pageBuilder: (context, state) => MaterialPage(
          key: state.pageKey,
          child: const PostsView(),
        ),
      ),
      // Add more routes here
    ],
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Page not found: ${state.uri.path}'),
      ),
    ),
  );
}
