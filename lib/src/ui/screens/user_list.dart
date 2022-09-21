import 'package:flutter/material.dart';
import 'package:lions/src/blocs/users_bloc.dart';
import 'package:lions/src/models/user_response.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/ui/widget/list_item.dart';

class UserList extends StatelessWidget {
  LionsCategory category;

  UserList({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllUsers();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: StreamBuilder(
          stream: bloc.allUsers,
          builder: (context, AsyncSnapshot<UserResponse> snapshot) {
            if (snapshot.hasData) {
              return buildList(snapshot);
            } else if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
    //throw UnimplementedError();
  }

  Widget buildContainerUI(AsyncSnapshot<UserResponse> snapshot) {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: buildList(snapshot),
    );
  }

  Widget buildList(AsyncSnapshot<UserResponse> snapshot) {
    return ListView.builder(
        itemCount: snapshot.data.results.length,
        /*gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        */
        itemBuilder: (BuildContext context, int index) {
          return ListItem(
            user: snapshot.data.results[index],
          );
        });
  }
}
