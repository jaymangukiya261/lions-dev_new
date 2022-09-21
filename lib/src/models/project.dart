import 'package:lions/src/models/club.dart';

class Project {
  int _id;
  String _name;
  String _description;
  String _date;
  String _image;
  Club _club;

  Project(result) {
    _id = result['id'];
    _name = result['name'];
    _description = result['description'];
    _date = result['date_of_project'];
    _image = result['images'][0]['image'];
    _club = Club.fromJson(result['club']);
  }

  int get id => _id;

  String get name => _name;

  String get description => _description;

  String get date => _date;

  String get image => _image;

  Club get club => _club;
}
