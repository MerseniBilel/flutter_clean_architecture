import 'package:clean_achitecture/core/errors/failures.dart';
import 'package:clean_achitecture/features/post/domain/entites/post.dart';
import 'package:clean_achitecture/features/post/domain/repositories/post_repo.dart';
import 'package:dartz/dartz.dart';

class UpdatePostUsecase{
  final PostRepository repository;
  UpdatePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Post post) async {
    return await repository.updatePost(post);
  }
}