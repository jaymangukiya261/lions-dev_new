import 'package:flutter/material.dart';
import 'package:lions/src/models/user.dart';

class ListItem extends StatelessWidget {
  User user;

  ListItem({Key key, @required this.user}) : super(key: key);

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
                    //Text(sprintf("%s %s %s", [user.name.title, user.name.first, user.name.last]),
                    Text(
                        "${user.name.title} ${user.name.first} ${user.name.last}"),
                    Text(user.email),
                  ],
                )),
          )),
    );
  }
}
