import 'package:lions/src/models/cabinet_member.dart';

class MjfMemberResponse {
  List<CabinetMember> _results = [];

  MjfMemberResponse.fromJson(Map<String, dynamic> json) {
    List<CabinetMember> temp = [];
    for (int i = 0; i < json['response']['mjfmember'].length; i++) {
      CabinetMember dgTeamMember =
          CabinetMember(json['response']['mjfmember'][i]);
      temp.add(dgTeamMember);
    }
    _results = temp;
  }

  List<CabinetMember> get results => _results;
}
