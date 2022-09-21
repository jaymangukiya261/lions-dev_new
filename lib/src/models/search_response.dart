import 'package:lions/src/models/search_value.dart';

class SearchResponse {
  List<SearchValue> _results = [];

  SearchResponse.fromJson(Map<String, dynamic> json) {
    List<SearchValue> temp = [];
    for (int i = 0; i < json['result'].length; i++) {
      SearchValue advertisement = SearchValue(json['result'][i]);
      temp.add(advertisement);
    }
    _results = temp;
  }

  List<SearchValue> get results => _results;
}
