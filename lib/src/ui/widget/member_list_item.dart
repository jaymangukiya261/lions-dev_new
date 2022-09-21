import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lions/src/models/member.dart';
import 'package:lions/src/ui/screens/profile_detail.dart';
import 'package:lions/src/ui/widget/avatar.dart';
import 'package:lions/src/utils/utils.dart';
import '../../constants.dart';

class MemberListItem extends StatelessWidget {
  Member member;

  MemberListItem({Key key, @required this.member}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
      child: InkWell(
        onTap: () {
          var router = new MaterialPageRoute(builder: (BuildContext context) {
            return ProfileDetail(member: member);
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
                            fontWeight: FontWeight.bold, fontSize: Constants.fontMid),
                        minFontSize: 12.0,
                      ),
                      AutoSizeText(
                        member.post != null
                            ? member.post.name
                            : member.postType,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: Constants.fontMin),
                        minFontSize: 10.0,
                      ),
                      AutoSizeText(
                        member.club,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: Constants.fontMin),
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
                                    fontSize: Constants.fontMid,
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
                            return ProfileDetail(member: member);
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
