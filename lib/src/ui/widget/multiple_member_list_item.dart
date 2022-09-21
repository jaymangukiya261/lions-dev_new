import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lions/src/models/member.dart';
import 'package:lions/src/ui/screens/multiple_member_profile.dart';
import 'package:lions/src/ui/screens/profile_detail.dart';
import 'package:lions/src/ui/widget/avatar.dart';
import 'package:lions/src/utils/utils.dart';

class MultipleMemberListItem extends StatelessWidget {
  Member member;

  MultipleMemberListItem({Key key, @required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
      child: InkWell(
        onTap: () {
          var router = new MaterialPageRoute(builder: (BuildContext context) {
            return MultipleMemberProfile(member: member);
          });
          Navigator.of(context).push(router);
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Avatar(name: member.name, imageUrl: member.image),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        member.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14.0),
                        minFontSize: 12.0,
                      ),
                      AutoSizeText(
                        member.post != null
                            ? member.post.name
                            : member.postType,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 12.0),
                        minFontSize: 10.0,
                      ),
                      if (member.district != null)
                        AutoSizeText(
                          member.district.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 12.0),
                          minFontSize: 10.0,
                        ),
                      SizedBox(
                        height: 8.0,
                      ),
                      InkWell(
                        onTap: () {
                          Utils.makePhoneCall('tel://${member.phoneNumber}');
                        },
                        child: Row(
                          children: [
                            Icon(
                              Icons.phone_android,
                              color: Colors.black,
                              size: 14.0,
                            ),
                            SizedBox(
                              width: 4.0,
                            ),
                            Expanded(
                              child: Text(
                                member.phoneNumber,
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.normal),
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
                          var router = new MaterialPageRoute(
                              builder: (BuildContext context) {
                            return MultipleMemberProfile(member: member);
                          });
                          Navigator.of(context).push(router);
                        },
                        child: Text(
                          'View',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            //color: Color.fromRGBO(19, 34, 144, 1),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
