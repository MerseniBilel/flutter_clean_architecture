import 'package:bloc/bloc.dart';
import 'package:clean_achitecture/core/errors/failures.dart';
import 'package:clean_achitecture/core/strings/failure.dart';
import 'package:clean_achitecture/core/strings/success.dart';
import 'package:clean_achitecture/features/post/domain/entites/post.dart';
import 'package:clean_achitecture/features/post/domain/usecases/add_post.dart';
import 'package:clean_achitecture/features/post/domain/usecases/delete_post.dart';
import 'package:clean_achitecture/features/post/domain/usecases/update_post.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

part 'add_delete_update_post_event.dart';
part 'add_delete_update_post_state.dart';

// this bloc gonna handle the add, delete, update events
class AddDeleteUpdatePostBloc
    extends Bloc<AddDeleteUpdatePostEvent, AddDeleteUpdatePostState> {
  final AddPostUseCase addpost;
  final DeletePostUsecase deletepost;
  final UpdatePostUsecase updatepost;

  AddDeleteUpdatePostBloc(
      {required this.addpost,
      required this.deletepost,
      required this.updatepost})
      : super(AddDeleteUpdatePostInitial()) {
    on<AddDeleteUpdatePostEvent>((event, emit) async {
      if (event is AddPostEvent) {
        // ? 1 -> send event to show loading indicator
        emit(LoadingAddDeleteUpdatePostState());
        // ? 2 -> get the post info we gonna update from the event
        final Post post = event.post;
        // ? 3 -> take the return which is a fail or a unit
        final failOrUnit = await addpost(post);
        // ? 4 -> call the function to check what state we gonna return
        emit(_mapResultFailOrUnit(failOrUnit, postAddedMsg));
      } else if (event is DeletePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final postid = event.postId;
        final failOrUnit = await deletepost(postid);
        emit(_mapResultFailOrUnit(failOrUnit, postDeletedMsg));
      } else if (event is UpdatePostEvent) {
        emit(LoadingAddDeleteUpdatePostState());
        final Post post = event.post;
        final failOrUnit = await updatepost(post);
        emit(_mapResultFailOrUnit(failOrUnit, postUpdatedMsg));
      }
    });
  }

  // this function takes the result of delete, update, add
  // which is a failure or a unit(nothing)
  // if failure so we return error state with the error msg
  // else we return the loaded state with the successful msg
  // both error and successful msg will show up on a snak bar
  AddDeleteUpdatePostState _mapResultFailOrUnit(
      Either<Failure, Unit> result, String successful) {
    return result.fold(
      (fail) => ErrorAddDeleteUpdatePostState(
          errorMessage: _mapFailuerToMessage(fail)),
      (unit) => LoadedAddDeleteUpdatePostState(msg: successful),
    );
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
