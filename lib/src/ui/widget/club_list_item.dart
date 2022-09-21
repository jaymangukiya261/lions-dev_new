import 'package:flutter/material.dart';
import 'package:lions/src/models/club.dart';
import 'package:lions/src/ui/screens/club_member_list.dart';

class ClubListItem extends StatelessWidget {
  Club club;

  ClubListItem({Key key, @required this.club}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                club.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Club Number: ${club.clubNumber}"),
              SizedBox(
                height: 4.0,
              ),
              Text(club.zone.region.name ?? ''),
              Text((club.zone.name ?? '')),
              Text(club.city.name ?? ''),
              SizedBox(
                height: 12.0,
              ),
              club.members.length > 0
                  ? InkWell(
                      onTap: () {
                        var router = new MaterialPageRoute(
                            builder: (BuildContext context) {
                          return ClubMemberList(
                              clubName: club.name, membersList: club.members);
                        });
                        Navigator.of(context).push(router);
                      },
                      child: Text(
                        'View Club Officers',
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          //color: Color.fromRGBO(19, 34, 144, 1),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
    );
  }
}
