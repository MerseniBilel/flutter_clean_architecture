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

const baseUrl = "https://jsonplaceholder.typicode.com";
const endPont = "/posts";

class RemoteDataSourceImpl implements PostRemoteDataSource {
  final http.Client client;

  RemoteDataSourceImpl({required this.client});

  @override
  Future<List<PostModel>> getAllPosts() async {
    final response = await client.get(
      Uri.parse(baseUrl + endPont),
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
      Uri.parse(baseUrl + endPont),
      body: json.encode(body),
      // headers: {"Content-Type": "application/json"},
    );

    return _checkResponse(response);
  }

  @override
  Future<Unit> deletePost(int postId) async {
    final response =
        await client.delete(Uri.parse('$baseUrl$endPont/$postId'));
    return _checkResponse(response);
  }

  @override
  Future<Unit> updatePost(PostModel post) async {
    final postId = post.id.toString();
    final body = {
      "title": post.title,
      "body": post.body,
    };

    final response = await client.patch(
      Uri.parse("$baseUrl$endPont/$postId"),
      body: body
    );

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
