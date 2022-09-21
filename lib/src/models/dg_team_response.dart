import 'package:lions/src/models/cabinet_member.dart';

class DgTeamResponse {
  List<CabinetMember> _results = [];

  DgTeamResponse.fromJson(Map<String, dynamic> json) {
    List<CabinetMember> temp = [];
    for (int i = 0; i < json['response']['dgteam'].length; i++) {
      CabinetMember dgTeamMember = CabinetMember(json['response']['dgteam'][i]);
      temp.add(dgTeamMember);
    }
    _results = temp;
  }

  List<CabinetMember> get results => _results;
}
