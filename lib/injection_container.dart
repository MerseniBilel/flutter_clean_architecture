import 'package:clean_achitecture/core/network/network_info.dart';
import 'package:clean_achitecture/features/post/data/dataresources/post_local_source.dart';
import 'package:clean_achitecture/features/post/data/dataresources/post_remote_source.dart';
import 'package:clean_achitecture/features/post/data/repositories/post_repo_impl.dart';
import 'package:clean_achitecture/features/post/domain/repositories/post_repo.dart';
import 'package:clean_achitecture/features/post/domain/usecases/add_post.dart';
import 'package:clean_achitecture/features/post/domain/usecases/delete_post.dart';
import 'package:clean_achitecture/features/post/domain/usecases/get_all_posts.dart';
import 'package:clean_achitecture/features/post/domain/usecases/update_post.dart';
import 'package:clean_achitecture/features/post/presentation/bloc/cud/add_delete_update_post_bloc.dart';
import 'package:clean_achitecture/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> postFuture() async {
  // ! Post future
  // bloc
  sl.registerFactory(() => PostsBloc(getAllposts: sl()));
  sl.registerFactory(() => AddDeleteUpdatePostBloc(
      addpost: sl(), deletepost: sl(), updatepost: sl()));

  // use cases
  sl.registerLazySingleton(() => GetAllPostsUseCase(sl()));
  sl.registerLazySingleton(() => AddPostUseCase(sl()));
  sl.registerLazySingleton(() => UpdatePostUsecase(sl()));
  sl.registerLazySingleton(() => DeletePostUsecase(sl()));

  // repository
  sl.registerLazySingleton<PostRepository>(
      () => PostRepoImpl(postRemoteds: sl(), postLocalds: sl(), network: sl()));

  // datasources
  sl.registerLazySingleton<PostRemoteDataSource>(
      () => RemoteDataSourceImpl(client: sl()));
  sl.registerLazySingleton<PostLocalDataSoutce>(
      () => PostLocalDataSoutceImpl(sharedpref: sl()));
}

Future<void> init() async {
  // ! post future
  await postFuture();

  // ! core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  // ! External
  //shared pref
  final sharefPref = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharefPref);
  // client http
  sl.registerLazySingleton(() => http.Client());
  // internet connection checker
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
