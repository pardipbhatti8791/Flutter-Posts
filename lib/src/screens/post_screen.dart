import 'package:flutter/material.dart';
import 'package:faker/faker.dart';

import 'package:flutter_app/src/screens/post_list.dart';
import 'package:flutter_app/src/services/post_api_provider.dart';

import 'package:flutter_app/src/widgets/bottom_navigation.dart';
import 'package:flutter_app/src/models/Post.dart';

class PostScreen extends StatefulWidget {
  final PostApiProvider _api = new PostApiProvider();

  @override
  State<StatefulWidget> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  List<Post> _posts = [];

  void initState() {
    super.initState();

    _fetchPosts();
  }

  _fetchPosts() async {
    List<Post> posts = await widget._api.fetchPosts();
    setState(() => _posts = posts);
  }

  _addPost() {
    final id = faker.randomGenerator.integer(9999);
    final title = faker.food.dish();
    final body = faker.food.cuisine();

    final newPost = Post(title: title, body: body, id: id);

    setState(() => _posts.add(newPost));
  }

  Widget build(BuildContext context) {
    return Scaffold(
        body: Post_List(
          posts: _posts,
        ),
        appBar: AppBar(
          title: Text('Post Screen'),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _addPost,
          tooltip: 'Add Post',
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomNavigation());
  }
}
