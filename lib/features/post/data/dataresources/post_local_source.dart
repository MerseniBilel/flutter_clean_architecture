import 'dart:convert';

import 'package:clean_achitecture/core/errors/exceptions.dart';
import 'package:clean_achitecture/features/post/data/models/post_model.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PostLocalDataSoutce {
  Future<List<PostModel>> getCashedPosts();
  Future<Unit> cashPosts(List<PostModel> posts);
}

class PostLocalDataSoutceImpl implements PostLocalDataSoutce {

  final SharedPreferences sharedpref;

  PostLocalDataSoutceImpl({ required this.sharedpref});

  @override
  Future<Unit> cashPosts(List<PostModel> posts) {
    List postModelsToJson = posts
        .map<Map<String, dynamic>>((pm) => pm.toJson())
        .toList();
    sharedpref.setString("cashedPosts", json.encode(postModelsToJson));
    return Future.value(unit);
  }

  @override
  Future<List<PostModel>> getCashedPosts() {
    final String? cashedPosts = sharedpref.getString("cashedPosts"); 
    if(cashedPosts != null){
      List decodedJson = json.decode(cashedPosts);
      List<PostModel> listOfPosts = decodedJson.map<PostModel>((jsonPost) => PostModel.fromJson(jsonPost)).toList();
      return Future.value(listOfPosts);
    }else {
      throw NoDataCashException();
    }
  }
}
