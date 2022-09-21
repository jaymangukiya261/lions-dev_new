class Post {
  int _id;
  String _name;
  String _description;

  Post(result) {
    _id = result['id'];
    _name = result['name'];
    _description = result['description'];
  }

  int get id => _id;

  String get name => _name;

  String get description => _description;
}
