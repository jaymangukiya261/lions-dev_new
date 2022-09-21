import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lions/src/models/search_value.dart';
import 'package:lions/src/ui/widget/avatar.dart';
import 'package:lions/src/ui/widget/member_profile_item.dart';
import 'package:lions/src/utils/utils.dart';
import '../../constants.dart';

class SearchResultProfile extends StatelessWidget {
  SearchValue member;

  SearchResultProfile({
    Key key,
    @required this.member,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          member.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(color: Color.fromRGBO(19, 34, 144, 1)),
                color: Color.fromRGBO(19, 34, 144, 1),
              ),
              child: Padding(
                padding: EdgeInsets.fromLTRB(16.0, 32.0, 16.0, 32.0),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Avatar(
                        name: member.name,
                        imageUrl: member.image,
                        radius: 48.0),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.fromLTRB(16.0, 0.0, 0.0, 0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            AutoSizeText(
                              member.name,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Constants.fontMid,
                                  fontWeight: FontWeight.bold),
                              minFontSize: Constants.fontMin,
                            ),
                            AutoSizeText(
                              member.post != null
                                  ? member.post.name
                                  : member.postType,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: Constants.fontMid,
                                  fontWeight: FontWeight.normal),
                              minFontSize: Constants.fontMin,
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            InkWell(
                              onTap: () {
                                Utils.makePhoneCall('mailto://${member.email}');
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.mail,
                                    color: Colors.white,
                                    size: Constants.fontMid,
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Expanded(
                                    child: AutoSizeText(
                                      member.email,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Constants.fontMid,
                                          fontWeight: FontWeight.normal),
                                      minFontSize: Constants.fontMin,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            InkWell(
                              onTap: () {
                                Utils.makePhoneCall(
                                    'tel://${member.phoneNumber}');
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.phone_android,
                                    color: Colors.white,
                                    size: 14.0,
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  Expanded(
                                    child: Text(
                                      member.phoneNumber,
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: Constants.fontMid,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (member.alternatePhoneNumber != null)
                              InkWell(
                                onTap: () {
                                   Utils.makePhoneCall('tel://${member.alternatePhoneNumber}');
                                },
                                child: Row(
                                  children: [
                                    Icon(
                                      Icons.phone_android,
                                      color: Colors.white,
                                      size: 14.0,
                                    ),
                                    SizedBox(
                                      width: 4.0,
                                    ),
                                    Expanded(
                                      child: Text(
                                        member.alternatePhoneNumber,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: Constants.fontMid,
                                            fontWeight: FontWeight.normal),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  MemberProfileItem(title: "Club", value: member.club.name),
                  MemberProfileItem(
                      title: "Membership Number",
                      value: member.membershipNumber),
                  MemberProfileItem(
                      title: "Blood Group", value: member.bloodGroup),
                  MemberProfileItem(
                      title: "Date Of Birth",
                      value: Utils.formatDate(member.dateOfBirth, "d MMMM")),
                  MemberProfileItem(title: "Spouse", value: member.spouseName),
                  MemberProfileItem(
                      title: "Date of Anniversary",
                      value:
                          Utils.formatDate(member.dateOfAnniversary, "d MMMM")),
                  MemberProfileItem(title: "Address", value: member.address),
                  MemberProfileItem(
                      title: "Apartment", value: member.apartment),
                  MemberProfileItem(title: "Landmark", value: member.landmark),
                  MemberProfileItem(title: "city", value: member.city),
                  MemberProfileItem(title: "State", value: member.state),
                  MemberProfileItem(title: "Postal", value: member.postal),
                ],
              ),
            ),
          ],
        ),
      ),
    );
    //throw UnimplementedError();
  }
}
