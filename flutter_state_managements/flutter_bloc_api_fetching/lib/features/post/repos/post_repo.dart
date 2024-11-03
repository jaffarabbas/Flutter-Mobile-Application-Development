import 'dart:convert';

import 'package:flutter_bloc_api_fetching/features/post/mappers/PostDataUiModal.dart';
import 'package:http/http.dart' as http;

class PostRepo {
  static Future<List<PostDataUiModal>> getPosts() async {
    var client = http.Client();
    List<PostDataUiModal> posts = [];
    try {
      var response = await client.get(
        Uri.parse('https://jsonplaceholder.typicode.com/posts'),
      );
      List result = jsonDecode(response.body);
      for (int i = 0; i < result.length; i++) {
        PostDataUiModal post =
            PostDataUiModal.fromJson(result[i] as Map<String, dynamic>);
        posts.add(post);
      }
      return posts;
    } catch (e) {
      print(e.toString());
      return [];
    } finally {
      client.close();
    }
  }
}
