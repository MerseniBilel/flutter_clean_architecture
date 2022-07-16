import 'package:clean_achitecture/features/post/domain/entites/post.dart';
import 'package:flutter/material.dart';

class LoadedPosts extends StatelessWidget {
  final List<Post> posts;
  const LoadedPosts({Key? key, required this.posts}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        itemCount: posts.length,
        itemBuilder: (BuildContext context, int index) {
          final onePost = posts[index];
          return ListTile(
            leading: Text(onePost.id.toString()),
            title: Text(
              onePost.title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            subtitle: Text(
              onePost.body,
              style: const TextStyle(fontSize: 16.0),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 10.0),
            onTap: () {},
          );
        },
        separatorBuilder: (_, index) => const Divider(thickness: 1));
  }
}
