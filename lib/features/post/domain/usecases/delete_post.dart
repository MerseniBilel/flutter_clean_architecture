import 'package:clean_achitecture/core/errors/failures.dart';
import 'package:clean_achitecture/features/post/domain/repositories/post_repo.dart';
import 'package:dartz/dartz.dart';

class DeletePostUsecase{
  final PostRepository repository;
  DeletePostUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int postId) async { 
    return await repository.deletePost(postId);
  }
}