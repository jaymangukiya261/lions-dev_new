import 'package:flutter/material.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/models/region.dart';
import 'package:lions/src/ui/screens/club_list.dart';
import 'package:lions/src/ui/screens/member_profile.dart';
import 'package:lions/src/ui/screens/zone_list.dart';
import 'package:lions/src/ui/widget/avatar.dart';
import 'package:lions/src/utils/utils.dart';
import '../../constants.dart';

class RegionListItem extends StatelessWidget {
  Region region;

  RegionListItem({Key key, @required this.region}) : super(key: key);

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
                  name: region.chairperson.name,
                  imageUrl: region.chairperson.image),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      region.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(
                      region.chairperson != null ? region.chairperson.name : '',
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(
                      height: 8.0,
                    ),
                    Text(
                      region.chairperson.club.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    InkWell(
                      onTap: () {
                        Utils.makePhoneCall('tel://${region.chairperson.phoneNumber}');
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
                              region.chairperson.phoneNumber,
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
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: region.chairperson != null
                          ? MainAxisAlignment.spaceBetween
                          : MainAxisAlignment.end,
                      children: [
                        if (region.chairperson != null)
                          InkWell(
                            onTap: () {
                              var router = new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                return MemberProfile(
                                    member: region.chairperson);
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
                              return ZoneList(
                                  category: LionsCategory(
                                      id: LionsCategory.CATEGORY_ZONE,
                                      title: 'Zone',
                                      icon: 'assets/images/zone.png'),
                                  regionId: region.id);
                            });
                            Navigator.of(context).push(router);
                          },
                          child: Text(
                            'Zones',
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
                                regionId: region.id,
                                zoneId: 0,
                              );
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
