import 'package:lions/src/models/user_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class UserBloc {
  final _repository = Repository();
  final _usersFetcher = PublishSubject<UserResponse>();

  Observable<UserResponse> get allUsers => _usersFetcher.stream;

  fetchAllUsers() async {
    //UserResponse userResponse = await _repository.fetchUsers();
    //_usersFetcher.sink.add(userResponse);
  }

  dispose() {
    _usersFetcher.close();
  }
}

final bloc = UserBloc();
