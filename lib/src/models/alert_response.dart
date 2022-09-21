import 'package:lions/src/models/alert.dart';

class AlertResponse {
  List<Alert> _results = [];

  AlertResponse.fromJson(Map<String, dynamic> json) {
    List<Alert> temp = [];
    for (int i = 0; i < json['response']['notification'].length; i++) {
      Alert city = Alert(json['response']['notification'][i]);
      temp.add(city);
    }
    _results = temp;
  }

  List<Alert> get results => _results;
}
