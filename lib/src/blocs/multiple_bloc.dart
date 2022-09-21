import 'package:lions/src/models/member.dart';
import 'package:lions/src/models/member_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class MultipleBloc {
  final _repository = Repository();
  final _fetcher = PublishSubject<List<Member>>();

  List<Member> _memberList = [];
  String _searchTerm = '';

  Observable<List<Member>> get allMultipleMembers => _fetcher.stream;

  fetchAllMultipleMembers() async {
    MemberResponse response = await _repository.fetchMultipleMembers();
    _memberList = response.results;
    _fetcher.sink.add(response.results);
  }

  search(String term) {
    _searchTerm = term;

    if (_searchTerm.isNotEmpty) {
      List<Member> filderedList = _memberList
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

final bloc = MultipleBloc();
