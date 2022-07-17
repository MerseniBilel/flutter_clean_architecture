import 'package:clean_achitecture/core/errors/exceptions.dart';
import 'package:clean_achitecture/core/errors/failures.dart';
import 'package:clean_achitecture/core/network/network_info.dart';
import 'package:clean_achitecture/features/post/data/dataresources/post_local_source.dart';
import 'package:clean_achitecture/features/post/data/dataresources/post_remote_source.dart';
import 'package:clean_achitecture/features/post/data/models/post_model.dart';
import 'package:clean_achitecture/features/post/domain/entites/post.dart';
import 'package:clean_achitecture/features/post/domain/repositories/post_repo.dart';
import 'package:dartz/dartz.dart';

class PostRepoImpl implements PostRepository {
  final PostRemoteDataSource postRemoteds;
  final PostLocalDataSoutce postLocalds;
  final NetworkInfo network;
  PostRepoImpl(
      {required this.postRemoteds,
      required this.postLocalds,
      required this.network});

  @override
  Future<Either<Failure, List<Post>>> getAllPosts() async {
    if (await network.isConnected) {
      try {
        final remotePosts = await postRemoteds.getAllPosts();
        postLocalds.cashPosts(remotePosts);
        return Right(remotePosts);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPosts = await postLocalds.getCashedPosts();
        return Right(localPosts);
      } on NoDataCashException {
        return Left(NoDataCashFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addPost(Post post) async {
    final PostModel postModel =
        PostModel(title: post.title, body: post.body);

    return await _getMessage(() => postRemoteds.addPost(postModel));
  }

  @override
  Future<Either<Failure, Unit>> deletePost(int postId) async {
    return await _getMessage(() => postRemoteds.deletePost(postId));
  }

  @override
  Future<Either<Failure, Unit>> updatePost(Post post) async {
    final PostModel postmodel =
        PostModel(id: post.id, title: post.title, body: post.title);
    return await _getMessage(() => postRemoteds.updatePost(postmodel));
  }

  // this function contains the dublicated code implements in the update delete and add
  Future<Either<Failure, Unit>> _getMessage(
      Future<Unit> Function() addUpdateOrDelete) async {
    if (await network.isConnected) {
      try {
        await addUpdateOrDelete();
        return const Right(unit);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
