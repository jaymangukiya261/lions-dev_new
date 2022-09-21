import 'package:lions/src/models/cabinet_member.dart';
import 'package:lions/src/models/region.dart';

class Zone {
  int _id;
  String _name;
  String _description;
  Region _region;
  CabinetMember _chairperson;

  Zone(result) {
    _id = result['id'];
    _name = result['name'];
    _description = result['description'];
    _region = Region(result['region']);
    _chairperson = result['zonechairperson'] != null
        ? CabinetMember(result['zonechairperson'])
        : null;
  }

  int get id => _id;

  String get name => _name;

  String get description => _description;

  Region get region => _region;

  CabinetMember get chairperson => _chairperson;
}
