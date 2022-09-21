import 'package:lions/src/models/city.dart';
import 'package:lions/src/models/city_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class CityBloc {
  final _repository = Repository();
  final _fetcher = PublishSubject<List<City>>();

  List<City> _cityList = [];
  String _searchTerm = '';

  Observable<List<City>> get allCities => _fetcher.stream;

  fetchAllCities() async {
    CityResponse cityResponse = await _repository.fetchCities();
    _cityList = cityResponse.results;
    _fetcher.sink.add(cityResponse.results);
  }

  search(String term) {
    _searchTerm = term;

    if (_searchTerm.isNotEmpty) {
      List<City> filderedList = _cityList
          .where((element) =>
              element.name.toLowerCase().contains(term.toLowerCase()))
          .toList();

      _fetcher.sink.add(filderedList);
    } else {
      clear();
    }
  }

  clear() {
    _fetcher.sink.add(_cityList);
  }

  dispose() {
    _fetcher.close();
  }
}

final bloc = CityBloc();
