import 'package:lions/src/models/city.dart';

class CityResponse {
  List<City> _results = [];

  CityResponse.fromJson(Map<String, dynamic> json) {
    List<City> temp = [];
    for (int i = 0; i < json['response']['cities'].length; i++) {
      City city = City(json['response']['cities'][i]);
      temp.add(city);
    }
    _results = temp;
  }

  List<City> get results => _results;
}
