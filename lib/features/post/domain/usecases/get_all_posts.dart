import 'package:clean_achitecture/core/errors/failures.dart';
import 'package:clean_achitecture/features/post/domain/entites/post.dart';
import 'package:clean_achitecture/features/post/domain/repositories/post_repo.dart';
import 'package:dartz/dartz.dart';

class GetAllPostsUseCase{
  final PostRepository repository;
  GetAllPostsUseCase(this.repository);

  Future<Either<Failure, List<Post>>> call() async {
    return await repository.getAllPosts();
  }
}