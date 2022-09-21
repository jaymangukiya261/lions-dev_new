import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lions/src/models/search_value.dart';
import 'package:lions/src/ui/screens/search_result_profile.dart';
import 'package:lions/src/ui/widget/avatar.dart';
import 'package:lions/src/utils/utils.dart';
import '../../constants.dart';

class SearchResultListItem extends StatelessWidget {
  SearchValue value;

  SearchResultListItem({Key key, @required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
      child: InkWell(
        onTap: () {
          var router = new MaterialPageRoute(builder: (BuildContext context) {
            return SearchResultProfile(member: value);
          });
          Navigator.of(context).push(router);
        },
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Avatar(name: value.name, imageUrl: value.image),
                SizedBox(
                  width: 12.0,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AutoSizeText(
                        value.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: Constants.fontMid),
                        minFontSize: 12.0,
                      ),
                      AutoSizeText(
                        value.post != null ? value.post.name : value.postType,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: Constants.fontMin),
                        minFontSize: 10.0,
                      ),
                      SizedBox(
                        height: 8.0,
                      ),
                      AutoSizeText(
                        value.club.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: Constants.fontMin),
                        minFontSize: 10.0,
                      ),
                      if (value.phoneNumber != null)
                        InkWell(
                          onTap: () {
                            Utils.makePhoneCall('tel://${value.phoneNumber}');
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
                                  value.phoneNumber,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: Constants.fontMid,
                                      fontWeight: FontWeight.normal),
                                ),
                              ),
                            ],
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
