import 'package:lions/src/models/advertisement.dart';

class AdvertisementResponse {
  List<Advertisement> _results = [];

  AdvertisementResponse.fromJson(Map<String, dynamic> json) {
    List<Advertisement> temp = [];
    for (int i = 0; i < json['response']['advertisements'].length; i++) {
      Advertisement advertisement =
          Advertisement(json['response']['advertisements'][i]);
      temp.add(advertisement);
    }
    _results = temp;
  }

  List<Advertisement> get results => _results;
}
