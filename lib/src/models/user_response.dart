import 'package:lions/src/models/user.dart';

class UserResponse {
  List<User> _results = [];

  UserResponse.fromJson(Map<String, dynamic> json) {
    List<User> temp = [];
    for (int i = 0; i < json['results'].length; i++) {
      User user = User(json['results'][i]['user']);
      temp.add(user);
    }
    _results = temp;
  }

  List<User> get results => _results;
}