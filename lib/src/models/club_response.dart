import 'package:lions/src/models/club.dart';

class ClubResponse {
  List<Club> _results = [];

  ClubResponse.fromJson(Map<String, dynamic> json) {
    List<Club> temp = [];
    for (int i = 0; i < json['response']['clubs'].length; i++) {
      Club club = Club.fromJson(json['response']['clubs'][i]);
      temp.add(club);
    }
    _results = temp;
  }

  List<Club> get results => _results;
}
