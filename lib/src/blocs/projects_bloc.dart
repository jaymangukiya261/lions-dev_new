import 'package:lions/src/models/project_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';

class ProjectsBloc {
  final _repository = Repository();
  final _zoneFetcher = PublishSubject<ProjectResponse>();

  Observable<ProjectResponse> get allProjeccts => _zoneFetcher.stream;

  fetchAllProjeccts() async {
    ProjectResponse regionResponse = await _repository.fetchProjects();
    _zoneFetcher.sink.add(regionResponse);
  }

  dispose() {
    _zoneFetcher.close();
  }
}

final bloc = ProjectsBloc();
