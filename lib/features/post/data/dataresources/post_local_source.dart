import 'package:clean_achitecture/features/post/data/models/post_model.dart';
import 'package:dartz/dartz.dart';

abstract class PostLocalDataSoutce {
  Future<List<PostModel>> getCashedPosts();
  Future<Unit> cashPosts(List<PostModel> posts);
}


class PostLocalDataSoutceImpl implements PostLocalDataSoutce{
  @override
  Future<Unit> cashPosts(List<PostModel> posts) {
    // TODO: implement cashPosts
    throw UnimplementedError();
  }

  @override
  Future<List<PostModel>> getCashedPosts() {
    // TODO: implement getCashedPosts
    throw UnimplementedError();
  }

}