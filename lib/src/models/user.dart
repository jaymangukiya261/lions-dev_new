class User {
  _Name _name;
  String _email;
  String _username;
  String _phone;
  String _gender;
  _Picture _picture;

  User(result) {
    _name = _Name(result['name']);
    _email = result['email'];
    _username = result['username'];
    _phone = result['phone'];
    _gender = result['gender'];
    _picture = _Picture(result['picture']);
  }

  _Name get name => _name;

  String get email => _email;

  String get username => _username;

  String get phone => _phone;

  String get gender => _gender;

  _Picture get picture => _picture;
}

class _Name {
  String _title;
  String _first;
  String _last;

  _Name(json) {
    _title = json['title'];
    _first = json['first'];
    _last = json['last'];
  }

  String get title => _title;
  String get first => _first;
  String get last => _last;
}

class _Picture {
  String _large;
  String _medium;
  String _thumbnail;

  _Picture(json) {
    _large = json['large'];
    _medium = json['medium'];
    _thumbnail = json['thumbnail'];
  }

  String get large => _large;
  String get medium => _medium;
  String get thumbnail => _thumbnail;
}
