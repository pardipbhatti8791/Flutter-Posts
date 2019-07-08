import 'package:flutter/material.dart';
import 'package:flutter_app/src/scoped_model/post_model.dart';
import 'package:flutter_app/src/widgets/bottom_navigation.dart';
import 'package:scoped_model/scoped_model.dart';

class Post_List extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    return ScopedModelDescendant<PostModel>(
      builder: (context, _, model) {
        return Scaffold(
            body:ListView.builder(
              itemCount: model.posts.length,
              itemBuilder: (BuildContext context, int i) {
                if (i.isOdd) {
                  return Divider();
                }
                return ListTile(
                  title: Text(model.posts[i].title),
                  subtitle: Text(model.posts[i].body),
                );
              },
            ),
            appBar: AppBar(
              title: Text("Meetup app"),
            ),
            floatingActionButton: _PostButton(addPost: model.addPost,),
            bottomNavigationBar: BottomNavigation());
      },
    );
  }
}


/**
 * @addPostButton
 */
class _PostButton extends StatelessWidget {
  final Function addPost;

  _PostButton({@required this.addPost });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return FloatingActionButton(
      onPressed: addPost,
      tooltip: 'Add Post',
      child: Icon(Icons.add),
    );
  }
}

//class Post_List extends StatelessWidget {
//  List<Post> _posts;
//
//
//  Post_List({@required List<Post> posts}) : _posts = posts;
//
//  @override
//  Widget build(BuildContext context) {
//
//    // TODO: implement build
//    //    return ListView(
//    //      children: this._posts
//    //          .map((post) => ListTile(
//    //        title: Text(post['title']),
//    //        subtitle: Text(post['body']),
//    //      ))
//    //          .toList(),
//    //    );
//
//    return ListView.builder(
//      itemCount: _posts.length,
//      itemBuilder: (BuildContext context, int i) {
//        if (i.isOdd) {
//          return Divider();
//        }
//        return ListTile(
//          title: Text(_posts[i].title),
//          subtitle: Text(_posts[i].body),
//        );
//      },
//    );
//  }
//}
