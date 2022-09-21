import 'package:flutter/material.dart';
import 'package:lions/src/models/user.dart';

// ignore: must_be_immutable
class UserDetial extends StatelessWidget {
  User user;

  UserDetial({Key key, @required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user.name.first}'),
      ),
      body: Card(
          child: Column(
              //mainAxisSize: MainAxisSize.max,

              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
            Image.network(
              '${user.picture.medium}',
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            Text('${user.name.title} ${user.name.first} ${user.name.last}'),
          ])),
    );
  }
}
