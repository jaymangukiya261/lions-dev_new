import 'package:lions/src/models/newsletter.dart';

class NewsletterResponse {
  List<Newsletter> _results = [];

  NewsletterResponse.fromJson(Map<String, dynamic> json) {
    List<Newsletter> temp = [];
    for (int i = 0; i < json['response']['newsletter'].length; i++) {
      Newsletter newsletter = Newsletter(json['response']['newsletter'][i]);
      temp.add(newsletter);
    }
    _results = temp;
  }

  List<Newsletter> get results => _results;
}
