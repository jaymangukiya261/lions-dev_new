import 'package:lions/src/models/cabinet_member.dart';
import 'package:lions/src/models/city.dart';
import 'package:lions/src/models/zone.dart';

class Club {
  /*int _id;
  String _regionId;
  String _zoneId;
  String _clubNumber;
  String _name;
  String _dateOfCharter;
  String _totalMembers;
  String _description;
  Zone _zone;
  City _city;
  List<CabinetMember> _members = [];

  Club(result) {
    _id = result['id'];
    _regionId = result['region_id'];
    _zoneId = result['zone_id'];
    _clubNumber = result['club_number'];
    _name = result['name'];
    _dateOfCharter = result['date_of_charter'];
    _totalMembers = result['total_members'];
    _description = result['description'];
    _zone = Zone(result['zone']);
    _city = result['city'] != null ? City(result['city']) : null;
    _members = (result['clubmembers'] as List)
        .map((item) => CabinetMember(item))
        .toList();
  }
  
  int get id => _id;

  String get regionId => _regionId;

  String get zoneId => _zoneId;

  String get clubNumber => _clubNumber;

  String get name => _name;

  String get dateOfCharter => _dateOfCharter;

  String get totalMembers => _totalMembers;

  String get description => _description;

  Zone get zone => _zone;

  City get city => _city;

  List<CabinetMember> get members => _members;

  membersList(List<Map<String, dynamic>> json) {
    List<CabinetMember> temp = [];
    for (int i = 0; i < json.length; i++) {
      CabinetMember cabinetMember = CabinetMember(json[i]);

      temp.add(cabinetMember);
    }
    _members = temp;
  }
  */

  int id;
  String regionId;
  String zoneId;
  String clubNumber;
  String name;
  String dateOfCharter;
  String totalMembers;
  String description;
  Zone zone;
  City city;
  List<CabinetMember> members;

  Club(
      {this.id,
      this.regionId,
      this.zoneId,
      this.clubNumber,
      this.name,
      this.dateOfCharter,
      this.totalMembers,
      this.description,
      this.zone,
      this.city,
      this.members});

  factory Club.fromJson(Map<String, dynamic> result) {
    return Club(
      id: result['id'],
      regionId: result['region_id'],
      zoneId: result['zone_id'],
      clubNumber: result['club_number'],
      name: result['name'],
      dateOfCharter: result['date_of_charter'],
      totalMembers: result['total_members'],
      description: result['description'],
      zone: Zone(result['zone']),
      city: result['city'] != null ? City(result['city']) : null,
      members: result['clubmembers'] != null
          ? result['clubmembers']
              .map<CabinetMember>((item) => CabinetMember(item))
              .toList()
          : null,
    );
  }
}
