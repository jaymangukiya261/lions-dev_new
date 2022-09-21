import 'package:lions/src/models/alert.dart';
import 'package:lions/src/models/alert_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class AlertsBloc {
  final _repository = Repository();
  final _fetcher = PublishSubject<List<Alert>>();

  List<Alert> _alertList = [];
  String _searchTerm = '';

  Observable<List<Alert>> get allNotifications => _fetcher.stream;

  fetchAllNotifications() async {
    AlertResponse response = await _repository.fetchNotifications();
    _alertList = response.results;
    _fetcher.sink.add(response.results);
  }

  search(String term) {
    _searchTerm = term;

    if (_searchTerm.isNotEmpty) {
      List<Alert> filderedList = _alertList
          .where((element) =>
              element.name.toLowerCase().contains(term.toLowerCase()))
          .toList();

      _fetcher.sink.add(filderedList);
    } else {
      clear();
    }
  }

  clear() {
    _fetcher.sink.add(_alertList);
  }

  dispose() {
    _fetcher.close();
  }
}

final bloc = AlertsBloc();
