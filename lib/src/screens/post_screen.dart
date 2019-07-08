import 'package:flutter/material.dart';
import 'package:flutter_app/src/scoped_model/post_model.dart';
import 'package:flutter_app/src/screens/post_list.dart';
import 'package:flutter_app/src/widgets/bottom_navigation.dart';
import 'package:flutter_app/src/models/Post.dart';
import 'package:scoped_model/scoped_model.dart';

class PostScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {

  Widget build(BuildContext context) {

    return ScopedModel<PostModel>(
      model: PostModel(),
      child: Post_List(),
    );
  }
}

