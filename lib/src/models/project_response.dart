import 'package:lions/src/models/project.dart';

class ProjectResponse {
  List<Project> _results = [];

  ProjectResponse.fromJson(Map<String, dynamic> json) {
    List<Project> temp = [];
    for (int i = 0; i < json['response']['projects'].length; i++) {
      Project project = Project(json['response']['projects'][i]);
      temp.add(project);
    }
    _results = temp;
  }

  List<Project> get results => _results;
}
