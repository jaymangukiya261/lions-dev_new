import 'package:lions/src/models/downloadable.dart';

class DownloadResponse {
  List<Downloadable> _results = [];

  DownloadResponse.fromJson(Map<String, dynamic> json) {
    List<Downloadable> temp = [];
    for (int i = 0; i < json['response']['downloads'].length; i++) {
      Downloadable download = Downloadable(json['response']['downloads'][i]);
      temp.add(download);
    }
    _results = temp;
  }

  List<Downloadable> get results => _results;
}
