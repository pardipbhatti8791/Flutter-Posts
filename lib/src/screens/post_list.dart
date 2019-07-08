import 'package:flutter/material.dart';
import 'package:flutter_app/src/models/Post.dart';

class Post_List extends StatelessWidget {
  List<Post> _posts;


  Post_List({@required List<Post> posts}) : _posts = posts;

  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    //    return ListView(
    //      children: this._posts
    //          .map((post) => ListTile(
    //        title: Text(post['title']),
    //        subtitle: Text(post['body']),
    //      ))
    //          .toList(),
    //    );

    return ListView.builder(
      itemCount: _posts.length,
      itemBuilder: (BuildContext context, int i) {
        if (i.isOdd) {
          return Divider();
        }
        return ListTile(
          title: Text(_posts[i].title),
          subtitle: Text(_posts[i].body),
        );
      },
    );
  }
}
