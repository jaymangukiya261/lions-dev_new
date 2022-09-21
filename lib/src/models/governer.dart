import 'package:lions/src/models/club.dart';

class Governer {
  int _id;
  String _name;
  String _membershipNumber;
  String _postType;
  String _phoneNumber;
  String _alternetPhoneNumber;
  String _email;
  String _bloodGroup;
  String _spouseName;
  String _dateOfBirth;
  String _dateOfAnniversary;
  String _image;
  String _address;
  String _apartment;
  String _landmark;
  String _city;
  String _state;
  String _pinCode;
  String _year;
  Club _club;

  Governer(result) {
    _id = result['id'];
    _name = result['name'];
    _membershipNumber = result['membership_number'];
    _postType = result['post_type'];
    _phoneNumber = result['phone_number'];
    _alternetPhoneNumber = result['alternate_phone_number'];
    _email = result['email'];
    _bloodGroup = result['blood_group'];
    _spouseName = result['spouse_name'];
    _dateOfBirth = result['date_of_birth'];
    _dateOfAnniversary = result['date_of_anniversary'];
    _image = result['image'];
    _address = result['address'];
    _apartment = result['apartment'];
    _landmark = result['landmark'];
    _city = result['city'];
    _state = result['state'];
    _pinCode = result['postal'];
    _year = result['year']['year'];
    _club = Club.fromJson(result['club']);
  }

  int get id => _id;

  String get name => _name;

  String get membershipNumber => _membershipNumber;

  String get postType => _postType;

  String get phoneNumber => _phoneNumber;

  String get alternetPhoneNumber => _alternetPhoneNumber;

  String get email => _email;

  String get bloodGroup => _bloodGroup;

  String get spouseName => _spouseName;

  String get dateOfBirth => _dateOfBirth;

  String get dateOfAnniversary => _dateOfAnniversary;

  String get image => _image;

  String get address => _address;

  String get apartment => _apartment;

  String get landmark => _landmark;

  String get city => _city;

  String get state => _state;

  String get pinCode => _pinCode;

  String get year => _year;

  Club get club => _club;
}
