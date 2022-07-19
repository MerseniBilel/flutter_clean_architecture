import 'package:clean_achitecture/core/utils/snaksbar.dart';
import 'package:clean_achitecture/features/post/domain/entites/post.dart';
import 'package:clean_achitecture/features/post/presentation/bloc/cud/add_delete_update_post_bloc.dart';
import 'package:clean_achitecture/features/post/presentation/pages/post_add_update_page.dart';
import 'package:clean_achitecture/features/post/presentation/pages/post_page.dart';
import 'package:clean_achitecture/features/post/presentation/widgets/custom_button.dart';
import 'package:clean_achitecture/features/post/presentation/widgets/custom_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailsPage extends StatelessWidget {
  final Post post;

  const DetailsPage({Key? key, required this.post}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Post Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Text(
              post.title,
              style:
                  const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
            const Divider(
              height: 50.0,
            ),
            Text(
              post.body,
              style: const TextStyle(fontSize: 16.0),
            ),
            const Divider(
              height: 50.0,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CusomButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            PostAddUpdatePage(isUpdate: true, post: post),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                  label: const Text('Update'),
                ),
                CusomButton(
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) {
                          return BlocConsumer<AddDeleteUpdatePostBloc,
                              AddDeleteUpdatePostState>(
                            listener: (context, state) {
                              if (state is LoadedAddDeleteUpdatePostState) {
                                SnakBarMessages().showSnackBar(
                                    context, state.msg, Colors.green);
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (_) => const PostPage()),
                                    (route) => false);
                              } else if (state
                                  is ErrorAddDeleteUpdatePostState) {
                                Navigator.of(context).pop();
                                SnakBarMessages().showSnackBar(
                                    context, state.errorMessage, Colors.red);
                              }
                            },
                            builder: (context, state) {
                              if (state is LoadingAddDeleteUpdatePostState) {
                                return const AlertDialog(
                                  title: CustomIndicator(),
                                );
                              }
                              return DeleteDialogWidget(postId: post.id);
                            },
                          );
                        });
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  ),
                  label: const Text('delete'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class DeleteDialogWidget extends StatelessWidget {
  final int postId;
  const DeleteDialogWidget({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('are you sure ?'),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text('no'),
        ),
        TextButton(
          onPressed: () {
            BlocProvider.of<AddDeleteUpdatePostBloc>(context).add(
              DeletePostEvent(postId: postId),
            );
          },
          child: const Text('yes'),
        ),
      ],
    );
  }
}
