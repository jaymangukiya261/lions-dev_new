import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/models/zone.dart';
import 'package:lions/src/ui/screens/club_list.dart';
import 'package:lions/src/ui/screens/zone_chairperson_profile.dart';
import 'package:lions/src/ui/widget/avatar.dart';
import 'package:lions/src/utils/utils.dart';
import '../../constants.dart';

class ZoneListItem extends StatelessWidget {
  Zone zone;

  ZoneListItem({Key key, @required this.zone}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            children: [
              Avatar(
                  name: zone.chairperson != null
                      ? zone.chairperson.name
                      : zone.name,
                  imageUrl:
                      zone.chairperson != null ? zone.chairperson.image : null),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      "${zone.name} (${zone.region.name})",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: Constants.fontMid),
                      minFontSize: 12.0,
                    ),
                    /*Text(
                      zone.region.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),*/
                    if (zone.chairperson != null)
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            zone.chairperson != null
                                ? zone.chairperson.name
                                : '',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Text(
                            zone.chairperson.club.name,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          InkWell(
                            onTap: () {
                              Utils.makePhoneCall('tel://${zone.chairperson.phoneNumber}');
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.phone_android,
                                  color: Colors.black,
                                  size: 16.0,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                Expanded(
                                  child: Text(
                                    zone.chairperson.phoneNumber,
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
                        ],
                      ),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: zone.chairperson != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                      children: [
                        if (zone.chairperson != null)
                          InkWell(
                            onTap: () {
                              var router = new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return ZoneChairpersonProfile(
                                    member: zone.chairperson);
                              });
                              Navigator.of(context).push(router);
                            },
                            child: Text(
                              "Chairperson",
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                                //color: Color.fromRGBO(19, 34, 144, 1),
                              ),
                            ),
                          ),
                        InkWell(
                          onTap: () {
                            var router = new MaterialPageRoute(
                                builder: (BuildContext context) {
                              return ClubList(
                                  category: LionsCategory(
                                      id: LionsCategory.CATEGORY_CLUBS,
                                      title: 'Clubs',
                                      icon: 'assets/images/clubs.png'),
                                  parentClass: this.runtimeType,
                                  regionId: zone.region.id,
                                  zoneId: zone.id);
                            });
                            Navigator.of(context).push(router);
                          },
                          child: Text(
                            'Clubs',
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
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
