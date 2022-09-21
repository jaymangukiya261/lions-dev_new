import 'package:lions/src/models/cabinet_member.dart';

class CabinetResponse {
  List<CabinetMember> _results = [];

  CabinetResponse.fromJson(Map<String, dynamic> json) {
    List<CabinetMember> temp = [];
    for (int i = 0; i < json['response']['cabinetmembers'].length; i++) {
      CabinetMember cabinetMember =
          CabinetMember(json['response']['cabinetmembers'][i]);
      temp.add(cabinetMember);
    }
    _results = temp;
  }

  List<CabinetMember> get results => _results;
}
