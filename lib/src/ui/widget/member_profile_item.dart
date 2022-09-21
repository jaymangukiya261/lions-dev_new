import '../../constants.dart';
import 'package:flutter/material.dart';

class MemberProfileItem extends StatelessWidget {
  String title;
  String value;

  MemberProfileItem({Key key, @required this.title, this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 8.0, 16.0, 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
                color: Colors.black54,
                fontSize: Constants.fontMax,
                fontWeight: FontWeight.normal),
          ),
          SizedBox(
            height: 4.0,
          ),
          Text(
            value ?? '',
            style: TextStyle(
                color: Colors.black87, fontSize: Constants.fontMax, fontWeight: FontWeight.bold),
          ),
          Divider(
            color: Colors.black54,
          )
        ],
      ),
    );
  }
}
