import 'package:lions/src/models/zone.dart';
import 'package:lions/src/models/zone_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ZoneBloc {
  final _repository = Repository();
  final _fetcher = PublishSubject<List<Zone>>();

  List<Zone> _zoneList = [];
  String _searchTerm = '';

  Observable<List<Zone>> get allZones => _fetcher.stream;

  fetchAllZones(int regionId) async {
    ZoneResponse response = await _repository.fetchZones(regionId);
    _zoneList = response.results;
    _fetcher.sink.add(response.results);
  }

  search(String term) {
    _searchTerm = term;

    if (_searchTerm.isNotEmpty) {
      List<Zone> filderedList = _zoneList
          .where((element) =>
              element.name.toLowerCase().contains(term.toLowerCase()))
          .toList();

      _fetcher.sink.add(filderedList);
    } else {
      clear();
    }
  }

  clear() {
    _fetcher.sink.add(_zoneList);
  }

  dispose() {
    _fetcher.close();
  }
}

final bloc = ZoneBloc();
