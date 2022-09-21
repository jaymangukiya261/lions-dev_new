class Downloadable {
  int _id;
  String _name;
  String _file;

  Downloadable(result) {
    _id = result['id'];
    _name = result['name'];
    _file = result['image'];
  }

  int get id => _id;

  String get name => _name;

  String get file => _file;
}
