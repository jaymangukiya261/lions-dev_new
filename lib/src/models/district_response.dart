import 'package:lions/src/models/district.dart';

class DistrictResponse {
  List<District> _results = [];

  DistrictResponse.fromJson(Map<String, dynamic> json) {
    List<District> temp = [];
    for (int i = 0; i < json['response']['districts'].length; i++) {
      District district = District(json['response']['districts'][i]);
      temp.add(district);
    }
    _results = temp;
  }

  List<District> get results => _results;
}
