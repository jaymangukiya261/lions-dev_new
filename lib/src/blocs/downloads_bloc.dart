import 'package:lions/src/models/downloadable.dart';
import 'package:lions/src/models/dowonload_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class DownloadsBloc {
  final _repository = Repository();
  final _fetcher = PublishSubject<List<Downloadable>>();

  List<Downloadable> _downloadList = [];
  String _searchTerm = '';

  Observable<List<Downloadable>> get allDownloadable => _fetcher.stream;

  fetchAllDownloadable() async {
    DownloadResponse regionResponse = await _repository.fetchDownloadable();
    _downloadList = regionResponse.results;
    _fetcher.sink.add(regionResponse.results);
  }

  search(String term) {
    _searchTerm = term;

    if (_searchTerm.isNotEmpty) {
      List<Downloadable> filderedList = _downloadList
          .where((element) =>
              element.name.toLowerCase().contains(term.toLowerCase()))
          .toList();

      _fetcher.sink.add(filderedList);
    } else {
      clear();
    }
  }

  clear() {
    _fetcher.sink.add(_downloadList);
  }

  dispose() {
    _fetcher.close();
  }
}

final bloc = DownloadsBloc();
