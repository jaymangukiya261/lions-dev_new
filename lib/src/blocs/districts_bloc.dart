import 'package:lions/src/models/district.dart';
import 'package:lions/src/models/district_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class DistrictBloc {
  final _repository = Repository();
  final _fetcher = PublishSubject<List<District>>();

  List<District> _districtList = [];
  String _searchTerm = '';

  Observable<List<District>> get allDistricts => _fetcher.stream;

  fetchAllDistricts() async {
    DistrictResponse districtResponse = await _repository.fetchDistricts();
    _districtList = districtResponse.results;
    _fetcher.sink.add(districtResponse.results);
  }

  search(String term) {
    _searchTerm = term;

    if (_searchTerm.isNotEmpty) {
      List<District> filderedList = _districtList
          .where((element) =>
              element.name.toLowerCase().contains(term.toLowerCase()))
          .toList();

      _fetcher.sink.add(filderedList);
    } else {
      clear();
    }
  }

  clear() {
    _fetcher.sink.add(_districtList);
  }

  dispose() {
    _fetcher.close();
  }
}

final bloc = DistrictBloc();
