class Post {

  final String title;
  final String body;
  final int id;

  Post({String title, String body, int id}):
      this.title = title,
      this.body = body,
      this.id = id;

  Post.fromJSON(Map<String, dynamic> parsedJson)
  : this.title = parsedJson['title'],
    this.body = parsedJson['body'],
    this.id = parsedJson['id'];
}