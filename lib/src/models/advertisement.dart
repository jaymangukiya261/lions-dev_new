class Advertisement {
  int _id;
  String _name;
  String _add;
  String _description;
  String _image;

  Advertisement(result) {
    _id = result['id'];
    _name = result['name'];
    _add = result['add'];
    _description = result['description'];
    _image = result['image'];
  }

  int get id => _id;

  String get name => _name;

  String get add => _add;

  String get description => _description;

  String get image => _image;
}
