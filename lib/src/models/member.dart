import 'package:lions/src/models/district.dart';
import 'package:lions/src/models/post.dart';

class Member {
  int _id;
  String _membershipNumber;
  String _postType;
  String _name;
  String _email;
  String _phoneNumber;
  String _alternatePhoneNumber;
  String _bloodGroup;
  String _spouseName;
  String _dateOfBirth;
  String _dateOfAnniversary;
  String _address;
  String _apartment;
  String _landmark;
  String _city;
  String _state;
  String _postal;
  String _image;
  String _description;
  String _club;
  Post _post;
  District _district;

  Member(result) {
    _id = result['id'];
    _membershipNumber = result['membership_number'];
    _postType = result['post_type'];
    _name = result['name'];
    _email = result['email'];
    _phoneNumber = result['phone_number'];
    _alternatePhoneNumber = result['alternate_phone_number'];
    _bloodGroup = result['blood_group'];
    _spouseName = result['spouse_name'];
    _dateOfBirth = result['date_of_birth'];
    _dateOfAnniversary = result['date_of_anniversary'];
    _address = result['address'];
    _apartment = result['apartment'];
    _landmark = result['landmark'];
    _city = result['city'];
    _state = result['state'];
    _postal = result['postal'];
    _image = result['image'];
    _description = result['description'];
    _club = result['club'];
    _post = result['post'] != null ? Post(result['post']) : null;
    _district =
        result['district'] != null ? District(result['district']) : null;
  }

  int get id => _id;

  String get membershipNumber => _membershipNumber;

  String get postType => _postType;

  String get name => _name;

  String get email => _email;

  String get phoneNumber => _phoneNumber;

  String get alternatePhoneNumber => _alternatePhoneNumber;

  String get bloodGroup => _bloodGroup;

  String get spouseName => _spouseName;

  String get dateOfBirth => _dateOfBirth;

  String get dateOfAnniversary => _dateOfAnniversary;

  String get address => _address;

  String get apartment => _apartment;

  String get landmark => _landmark;

  String get city => _city;

  String get state => _state;

  String get postal => _postal;

  String get image => _image;

  String get description => _description;

  String get club => _club;

  Post get post => _post;

  District get district => _district;
}
