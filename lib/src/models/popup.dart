class Popup {
  String _name;
  String _image;

  Popup.fromJson(Map<String, dynamic> json) {
    _name = json['response']['popup']['name'];
    _image = json['response']['popup']['image'];
  }

  String get name => _name;

  String get image => _image;
}
