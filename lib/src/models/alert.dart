class Alert {
  int _id;
  String _name;
  String _description;

  Alert(result) {
    _id = result['id'];
    _name = result['name'];
    _description = result['description'];
  }

  int get id => _id;

  String get name => _name;

  String get description => _description;
}
