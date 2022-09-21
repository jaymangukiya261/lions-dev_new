import 'package:lions/src/models/cabinet_member.dart';

class Region {
  int _id;
  String _name;
  String _description;
  CabinetMember _chairperson;

  Region(result) {
    _id = result['id'];
    _name = result['name'];
    _description = result['description'];
    _chairperson = result['regionchairperson'] != null
        ? CabinetMember(result['regionchairperson'])
        : null;
  }

  int get id => _id;

  String get name => _name;

  String get description => _description;

  CabinetMember get chairperson => _chairperson;
}
