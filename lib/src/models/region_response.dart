import 'package:lions/src/models/region.dart';

class RegionResponse {
  List<Region> _results = [];

  RegionResponse.fromJson(Map<String, dynamic> json) {
    List<Region> temp = [];
    for (int i = 0; i < json['response']['regions'].length; i++) {
      Region region = Region(json['response']['regions'][i]);
      temp.add(region);
    }
    _results = temp;
  }

  List<Region> get results => _results;
}
