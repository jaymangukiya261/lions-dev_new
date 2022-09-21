import 'package:flutter/material.dart';
import 'package:lions/src/models/district.dart';

class DistrictListItem extends StatelessWidget {
  District district;

  DistrictListItem({Key key, @required this.district}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Padding(
        padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(district.name),
                Text(district.description ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
