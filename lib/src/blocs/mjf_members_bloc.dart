import 'package:lions/src/models/cabinet_member.dart';
import 'package:lions/src/models/mjf_member_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MjfMembersBloc {
  final _repository = Repository();
  final _fetcher = PublishSubject<List<CabinetMember>>();

  List<CabinetMember> _memberList = [];
  String _searchTerm = '';

  Observable<List<CabinetMember>> get allMjfMembers => _fetcher.stream;

  fetchAllMjfMembers() async {
    MjfMemberResponse response = await _repository.fetchMjfMembers();
    _memberList = response.results;
    _fetcher.sink.add(response.results);
  }

  search(String term) {
    _searchTerm = term;

    if (_searchTerm.isNotEmpty) {
      List<CabinetMember> filderedList = _memberList
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

final bloc = MjfMembersBloc();
