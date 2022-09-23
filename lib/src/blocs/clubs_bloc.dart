import 'package:lions/src/models/club.dart';
import 'package:lions/src/models/club_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

import 'generate_pdf/bloc_pdf.dart';

class ClubBloc {
  final _repository = Repository();
  final _fetcher = PublishSubject<List<Club>>();

  List<Club> _clubList = [];
  List<Club> clubListPrint = [];
  String _searchTerm = '';
  String _filter = '';

  Observable<List<Club>> get allClubs => _fetcher.stream;

  fetchAllClubs(int regionId, int zoneId) async {
    ClubResponse clubResponse = await _repository.fetchClubs(regionId, zoneId);
    _clubList = clubResponse.results;
    _fetcher.sink.add(clubResponse.results);
    clubListPrint = clubResponse.results;
  }

  searchReport(String term) {
    clubListPrint = _clubList.where((element) {
      return element.name.toLowerCase().contains(term.toLowerCase()) &&
          element.city.name.toLowerCase() == _filter.toLowerCase();
    }).toList();
  }

  search(String term) {
    _searchTerm = term;

    _filterClubs();
  }

  filterReport(String filter) {
    clubListPrint = _clubList.where((element) {
      return element.name.toLowerCase().contains(_searchTerm.toLowerCase()) &&
          element.city.name.toLowerCase() == filter.toLowerCase();
    }).toList();
  }

  filter(String filter) {
    _filter = filter;

    _filterClubs();
  }

  _filterClubs() {
    if (_searchTerm.isEmpty && _filter.isEmpty) {
      clear();
      return;
    }
    List<Club> filderedList = _clubList.where((element) {
      return element.name.toLowerCase().contains(_searchTerm.toLowerCase()) &&
          element.city.name.toLowerCase() == _filter.toLowerCase();
    }).toList();
    _fetcher.sink.add(filderedList);
  }

  clear() {
    _fetcher.sink.add(_clubList);
  }

  dispose() {
    _searchTerm = '';
    _filter = '';
    _fetcher.close();
  }
}

final bloc = ClubBloc();
final pdfs = pdfCreation();
