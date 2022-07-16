import 'package:clean_achitecture/core/app_theme.dart';
import 'package:clean_achitecture/features/post/presentation/bloc/cud/add_delete_update_post_bloc.dart';
import 'package:clean_achitecture/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_achitecture/features/post/presentation/pages/post_page.dart';
import 'package:flutter/material.dart';
import 'package:clean_achitecture/injection_container.dart' as di;
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (_) => di.sl<PostsBloc>()..add(GetAllPostsEvent())),
        BlocProvider(create: (_) => di.sl<AddDeleteUpdatePostBloc>())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Clean Archtecture',
        theme: appTheme,
        home: const PostPage(),
      ),
    );
  }
}
