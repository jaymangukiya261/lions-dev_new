import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:lions/src/models/cabinet_member.dart';
import 'package:lions/src/ui/widget/avatar.dart';
import 'package:lions/src/utils/utils.dart';
import '../../constants.dart';

class MjfMemberListItem extends StatelessWidget {
  CabinetMember cabinetMember;

  MjfMemberListItem({Key key, @required this.cabinetMember}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Avatar(name: cabinetMember.name, imageUrl: cabinetMember.image),
              SizedBox(
                width: 12.0,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AutoSizeText(
                      cabinetMember.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: Constants.fontMid),
                      minFontSize: 12.0,
                    ),
                    AutoSizeText(
                      "Membership Number: ${cabinetMember.membershipNumber}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: Constants.fontMin),
                      minFontSize: 10.0,
                    ),
                    AutoSizeText(
                      "Date of MJF: ${Utils.formatDate(cabinetMember.dateOfMjf, "d MMMM, y")}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: Constants.fontMin),
                      minFontSize: 10.0,
                    ),
                    /*AutoSizeText(
                      cabinetMember.post != null
                          ? cabinetMember.post.name
                          : cabinetMember.postType,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 12.0),
                      minFontSize: 10.0,
                    ),*/
                    SizedBox(
                      height: 4.0,
                    ),
                    AutoSizeText(
                      cabinetMember.club.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w500, fontSize: Constants.fontMin),
                      minFontSize: 10.0,
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
