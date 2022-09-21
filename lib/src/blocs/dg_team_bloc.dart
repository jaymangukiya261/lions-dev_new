import 'package:lions/src/models/cabinet_member.dart';
import 'package:lions/src/models/dg_team_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class DgTeamBloc {
  final _repository = Repository();
  final _zoneFetcher = PublishSubject<List<CabinetMember>>();

  List<CabinetMember> _membersList = [];
  String _searchTerm = '';

  Observable<List<CabinetMember>> get allDgTeamMembers => _zoneFetcher.stream;

  fetchAllDgTeamMembers() async {
    DgTeamResponse regionResponse = await _repository.fetchDgTeamMembers();
    _membersList = regionResponse.results;
    _zoneFetcher.sink.add(regionResponse.results);
  }

  search(String term) {
    _searchTerm = term;

    if (_searchTerm.isNotEmpty) {
      List<CabinetMember> filderedMembers = _membersList
          .where((element) =>
              element.name.toLowerCase().contains(term.toLowerCase()))
          .toList();

      _zoneFetcher.sink.add(filderedMembers);
    } else {
      clear();
    }
  }

  clear() {
    _zoneFetcher.sink.add(_membersList);
  }

  dispose() {
    _zoneFetcher.close();
  }
}

final bloc = DgTeamBloc();
