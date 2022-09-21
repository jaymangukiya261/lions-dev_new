
import 'package:flutter/material.dart';
import 'package:lions/src/models/user.dart';
import 'package:lions/src/ui/screens/user_detail.dart';

class UserListItem extends StatelessWidget {
  User user;

  UserListItem({
    Key key,
    @required this.user
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        var router = new MaterialPageRoute(builder: (BuildContext context) {
          return UserDetial(user: this.user,);
        });
        Navigator.of(context).push(router);
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Text(sprintf("%s %s %s", [user.name.title, user.name.first, user.name.last]),
              Text("${user.name.title} ${user.name.first} ${user.name.last}"),
              Text(user.email),
            ],
          )
        )
      ),
    );
  }
  
}