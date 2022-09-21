import 'package:flutter/material.dart';
import 'package:lions/src/models/alert.dart';

class AlertListItem extends StatelessWidget {
  Alert alert;

  AlertListItem({Key key, @required this.alert}) : super(key: key);

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
                alert.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 4.0,
              ),
              Text(alert.description),
            ],
          ),
        ),
      ),
    );
  }
}
