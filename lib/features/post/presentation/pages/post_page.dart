import 'package:clean_achitecture/features/post/presentation/bloc/posts/posts_bloc.dart';
import 'package:clean_achitecture/features/post/presentation/pages/post_add_update_page.dart';
import 'package:clean_achitecture/features/post/presentation/widgets/custom_indicator.dart';
import 'package:clean_achitecture/features/post/presentation/widgets/error_display.dart';
import 'package:clean_achitecture/features/post/presentation/widgets/loaded_posts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostPage extends StatelessWidget {
  const PostPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Posts'),
      ),
      body: const PostBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (_) => const PostAddUpdatePage(isUpdate: false)));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class PostBody extends StatelessWidget {
  const PostBody({
    Key? key,
  }) : super(key: key);

  Future<void> _onrefresh(BuildContext context) async {
    BlocProvider.of<PostsBloc>(context).add(RefreshPostsEvent());
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () => _onrefresh(context),
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<PostsBloc, PostsState>(
            builder: (context, state) {
              if (state is LoadingPostsState) {
                return const CustomIndicator();
              } else if (state is LoadedPostsState) {
                return LoadedPosts(
                  posts: state.posts,
                );
              } else if (state is ErrorPostsState) {
                return DisplayError(msg: state.errorMsg);
              }
              return const CustomIndicator();
            },
          )),
    );
  }
}
