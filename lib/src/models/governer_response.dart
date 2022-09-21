import 'package:lions/src/models/governer.dart';

class GovernerResponse {
  List<Governer> _results = [];

  GovernerResponse.fromJson(Map<String, dynamic> json) {
    List<Governer> temp = [];
    for (int i = 0; i < json['response']['governers'].length; i++) {
      Governer governer = Governer(json['response']['governers'][i]);
      temp.add(governer);
    }
    _results = temp;
  }

  List<Governer> get results => _results;
}
