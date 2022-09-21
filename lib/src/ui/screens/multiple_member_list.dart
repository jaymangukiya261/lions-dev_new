import 'package:flutter/material.dart';
import 'package:lions/src/blocs/multiple_bloc.dart';
import 'package:lions/src/models/member.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/ui/widget/member_list_item.dart';
import 'package:lions/src/ui/widget/multiple_member_list_item.dart';
import 'package:lions/src/ui/widget/search-bar/app_bar_controller.dart';
import 'package:lions/src/ui/widget/search-bar/search_app_bar.dart';

class MultipleMemberList extends StatefulWidget {
  LionsCategory category;

  MultipleMemberList({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  _MultipleMemberListState createState() => _MultipleMemberListState();
}

class _MultipleMemberListState extends State<MultipleMemberList> {
  final AppBarController appBarController = AppBarController();

  @override
  void initState() {
    super.initState();
    bloc.fetchAllMultipleMembers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        appBarController: appBarController,
        mainAppBar: AppBar(
          title: Text("${widget.category.title}"),
          actions: [
            InkWell(
              child: Padding(
                padding: EdgeInsets.fromLTRB(0.0, 0.0, 16.0, 0.0),
                child: Icon(Icons.search),
              ),
              onTap: () {
                appBarController.stream.add(true);
              },
            ),
          ],
        ),
        primary: Theme.of(context).primaryColor,
        autoSelected: false,
        mainTextColor: Colors.white,
        onChange: (String value) {
          bloc.search(value);
        },
        onTap: () {
          bloc.clear();
        },
      ),
      body: StreamBuilder(
          stream: bloc.allMultipleMembers,
          builder: (context, AsyncSnapshot<List<Member>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Center(
                  child: Text("No Items Available."),
                );
              } else {
                return buildList(snapshot.data);
              }
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

  Widget buildList(List<Member> data) {
    return ListView.builder(
        itemCount: data.length,
        /*gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        */
        itemBuilder: (BuildContext context, int index) {
          return MultipleMemberListItem(
            member: data[index],
          );
        });
  }
}
