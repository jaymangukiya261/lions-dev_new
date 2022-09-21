import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lions/src/models/governer.dart';
import 'package:lions/src/ui/screens/governer_profile.dart';
import 'package:lions/src/ui/widget/avatar.dart';
import 'package:lions/src/utils/utils.dart';
import '../../constants.dart';

class PastGovernerListItem extends StatelessWidget {
  Governer governer;

  PastGovernerListItem({Key key, @required this.governer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var router = new MaterialPageRoute(builder: (BuildContext context) {
          return GovernerProfile(member: governer);
        });
        Navigator.of(context).push(router);
      },
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Avatar(name: governer.name, imageUrl: governer.image),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        governer.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: Constants.fontMid),
                        minFontSize: 12.0,
                      ),
                      AutoSizeText(
                        "${governer.postType} (${governer.year})",
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: Constants.fontMin),
                        minFontSize: 10.0,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      AutoSizeText(
                        governer.club.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: Constants.fontMin),
                        minFontSize: 10.0,
                      ),
                      InkWell(
                        onTap: () {
                          Utils.makePhoneCall('tel://${governer.phoneNumber}');
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
                                governer.phoneNumber,
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
                            return GovernerProfile(member: governer);
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
