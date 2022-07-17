import 'package:clean_achitecture/core/utils/snaksbar.dart';
import 'package:clean_achitecture/features/post/domain/entites/post.dart';
import 'package:clean_achitecture/features/post/presentation/bloc/cud/add_delete_update_post_bloc.dart';
import 'package:clean_achitecture/features/post/presentation/pages/post_page.dart';
import 'package:clean_achitecture/features/post/presentation/widgets/custom_indicator.dart';
import 'package:clean_achitecture/features/post/presentation/widgets/form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostAddUpdatePage extends StatelessWidget {
  final Post? post;
  final bool isUpdate;
  const PostAddUpdatePage({Key? key, this.post, required this.isUpdate})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(isUpdate ? "Edit Post" : "Add post"),
          centerTitle: true,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child:
                BlocConsumer<AddDeleteUpdatePostBloc, AddDeleteUpdatePostState>(
              listener: (context, state) {
                if (state is ErrorAddDeleteUpdatePostState) {
                  SnakBarMessages()
                      .showSnackBar(context, state.errorMessage, Colors.red);
                } else if (state is LoadedAddDeleteUpdatePostState) {
                  SnakBarMessages()
                      .showSnackBar(context, state.msg, Colors.green);
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (_) => const PostPage()),
                      (route) => false);
                }
              },
              builder: (context, state) {
                if (state is LoadingAddDeleteUpdatePostState) {
                  return const CustomIndicator();
                }
                return FormWidget(
                  isUpdate: isUpdate,
                  post: post,
                );
              },
            ),
          ),
        ));
  }
}
