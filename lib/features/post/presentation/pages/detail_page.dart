import 'package:clean_achitecture/features/post/domain/entites/post.dart';
import 'package:clean_achitecture/features/post/presentation/pages/post_add_update_page.dart';
import 'package:clean_achitecture/features/post/presentation/widgets/custom_button.dart';
import 'package:flutter/material.dart';

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
