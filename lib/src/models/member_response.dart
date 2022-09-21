import 'package:lions/src/models/member.dart';

class MemberResponse {
  List<Member> _results = [];

  MemberResponse.fromJson(Map<String, dynamic> json) {
    List<Member> temp = [];
    for (int i = 0; i < json['response']['members'].length; i++) {
      Member member = Member(json['response']['members'][i]);
      temp.add(member);
    }
    _results = temp;
  }

  List<Member> get results => _results;
}
