import 'package:lions/src/models/zone.dart';

class ZoneResponse {
  List<Zone> _results = [];

  ZoneResponse.fromJson(Map<String, dynamic> json) {
    List<Zone> temp = [];
    for (int i = 0; i < json['response']['zones'].length; i++) {
      Zone zone = Zone(json['response']['zones'][i]);
      temp.add(zone);
    }
    _results = temp;
  }

  List<Zone> get results => _results;
}
