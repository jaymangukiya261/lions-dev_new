import 'package:lions/src/models/search_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class SearchBloc {
  final _repository = Repository();
  final _fetcher = PublishSubject<SearchResponse>();

  Observable<SearchResponse> get allSearchResults => _fetcher.stream;

  fetchAllSearchResults(String searchTerm) async {
    SearchResponse response = await _repository.search(searchTerm);
    _fetcher.sink.add(response);
  }

  dispose() {
    _fetcher.close();
  }
}

final bloc = SearchBloc();
