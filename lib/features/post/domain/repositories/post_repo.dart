import 'package:clean_achitecture/core/errors/failures.dart';
import 'package:clean_achitecture/features/post/domain/entites/post.dart';
import 'package:dartz/dartz.dart';

abstract class PostRepository {
  Future<Either<Failure, List<Post>>> getAllPosts();
  Future<Either<Failure, Unit>> deletePost(int postId);
  Future<Either<Failure, Unit>> updatePost(Post post);
  Future<Either<Failure, Unit>> addPost(Post post);
}