import 'package:lions/src/models/region.dart';
import 'package:lions/src/models/region_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class RegionBloc {
  final _repository = Repository();
  final _fetcher = PublishSubject<List<Region>>();

  List<Region> _regionList = [];
  List<Region> regionPrint = [];
  String _searchTerm = '';

  Observable<List<Region>> get allRegions => _fetcher.stream;

  fetchAllRegions() async {
    RegionResponse response = await _repository.fetchRegions();
    _regionList = response.results;
    _fetcher.sink.add(response.results);
    regionPrint = response.results;
  }

  search(String term) {
    _searchTerm = term;

    if (_searchTerm.isNotEmpty) {
      List<Region> filderedList = _regionList
          .where((element) =>
              element.name.toLowerCase().contains(term.toLowerCase()))
          .toList();

      _fetcher.sink.add(filderedList);
    } else {
      clear();
    }
  }

  searchRegionReport(String term) {
    regionPrint = _regionList
        .where((element) =>
            element.name.toLowerCase().contains(term.toLowerCase()))
        .toList();
  }

  clear() {
    _fetcher.sink.add(_regionList);
  }

  dispose() {
    _fetcher.close();
  }
}

final bloc = RegionBloc();
