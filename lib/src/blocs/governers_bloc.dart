import 'package:lions/src/models/governer.dart';
import 'package:lions/src/models/governer_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class GovernerBloc {
  final _repository = Repository();
  final _fetcher = PublishSubject<List<Governer>>();

  List<Governer> _memberList = [];
  String _searchTerm = '';

  Observable<List<Governer>> get allPastGoverners => _fetcher.stream;

  fetchAllPastGoverners() async {
    GovernerResponse response = await _repository.fetchPastGoverners();
    _memberList = response.results;
    _fetcher.sink.add(response.results);
  }

search(String term) {
    _searchTerm = term;

    if (_searchTerm.isNotEmpty) {
      List<Governer> filderedList = _memberList
          .where((element) =>
              element.name.toLowerCase().contains(term.toLowerCase()))
          .toList();

      _fetcher.sink.add(filderedList);
    } else {
      clear();
    }
  }

  clear() {
    _fetcher.sink.add(_memberList);
  }

  dispose() {
    _fetcher.close();
  }
}

final bloc = GovernerBloc();
