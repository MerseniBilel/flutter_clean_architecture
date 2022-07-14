import 'dart:convert';
import 'package:clean_achitecture/core/errors/exceptions.dart';
import 'package:clean_achitecture/features/post/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import "package:http/http.dart" as http;
import 'package:http/http.dart';

abstract class PostRemoteDataSource {
  Future<List<PostModel>> getAllPosts();
  Future<Unit> deletePost(int postId);
  Future<Unit> updatePost(PostModel post);
  Future<Unit> addPost(PostModel post);
}

const BASE_URL = "https://jsonplaceholder.typicode.com";

class RemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse("$BASE_URL/posts/"),
      headers: {"Content-Type": "application/json"},
    );
    if (response.statusCode == 200) {
      final List decodedPostList = json.decode(response.body) as List;
      final List<PostModel> postModelList = decodedPostList
          .map<PostModel>((jsonPost) => PostModel.fromJson(jsonPost))
          .toList();
      return postModelList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addPost(PostModel post) async {
    final body = {
      'title': post.title,
      'body': post.body,
    };

    final response = await client.post(
      Uri.parse("$BASE_URL/post"),
      body: body,
      headers: {"Content-Type": "application/json"},
    );

    return _checkResponse(response);
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response =
        await client.delete(Uri.parse("$BASE_URL/posts/${postId.toString()}"));
    return _checkResponse(response);
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final postId = post.id.toString();
    final body = {
      "title": post.title,
      "body": post.body,
    };

    final response = await client.patch(Uri.parse("$BASE_URL/posts/$postId"));

    return _checkResponse(response);
  }

  Future<Unit> _checkResponse(Response response) {
    if (response.statusCode == 200 || response.statusCode == 201) {
      return Future.value(unit);
    } else {
      throw ServerException();
    }
  }
}
