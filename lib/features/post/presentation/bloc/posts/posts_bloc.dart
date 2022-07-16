import 'package:bloc/bloc.dart';
import 'package:clean_achitecture/core/errors/failures.dart';
import 'package:clean_achitecture/core/strings/failure.dart';
import 'package:clean_achitecture/features/post/domain/entites/post.dart';
import 'package:clean_achitecture/features/post/domain/usecases/get_all_posts.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'posts_event.dart';
part 'posts_state.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  final GetAllPostsUseCase getAllposts;
  PostsBloc({required this.getAllposts}) : super(PostsInitial()) {
    on<PostsEvent>((event, emit) async {
      if (event is GetAllPostsEvent) {
        emit(LoadingPostsState());
        final posts = await getAllposts();
        emit(_mapFailureOfPostsToState(posts));
      } else if (event is RefreshPostsEvent) {
        emit(LoadingPostsState());
        final posts = await getAllposts();
        emit(_mapFailureOfPostsToState(posts));
      }
    });
  }

  // observe and print the state 
  // todo : delete in the production mode
  @override
  void onTransition(Transition<PostsEvent, PostsState> transition) {
    super.onTransition(transition);
    print(transition);
  }

  // this function get the return of the getallposts()
  // which is a failure or a list of posts
  // the function check the return and based on it it return the state we gonna emit
  PostsState _mapFailureOfPostsToState(Either<Failure, List<Post>> either) {
    return either.fold(
        (failure) => ErrorPostsState(errorMsg: _mapFailuerToMessage(failure)),
        (posts) => LoadedPostsState(posts: posts));
  }

  // this function get the failure and check it's type
  // then return the error string based on the failure type
  String _mapFailuerToMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return serverErrorFailureMsg;
      case OfflineFailure:
        return noInternetConnectionFailureMsg;
      case NoDataCashFailure:
        return noCashedDataFailureMsg;
      default:
        return unKownFailureMsg;
    }
  }
}
