class Newsletter {
  int _id;
  String _name;
  String _image;
  String _description;

  Newsletter(result) {
    _id = result['id'];
    _name = result['name'];
    _image = result['image'];
    _description = result['description'];
  }

  int get id => _id;

  String get name => _name;

  String get image => _image;

  String get description => _description;
}
