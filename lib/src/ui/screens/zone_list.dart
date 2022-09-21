import 'package:flutter/material.dart';
import 'package:lions/src/blocs/zones_bloc.dart';
import 'package:lions/src/models/zone.dart';
import 'package:lions/src/models/zone_response.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/ui/widget/search-bar/app_bar_controller.dart';
import 'package:lions/src/ui/widget/search-bar/search_app_bar.dart';
import 'package:lions/src/ui/widget/zone_list_item.dart';

class ZoneList extends StatefulWidget {
  LionsCategory category;
  int regionId = 0;

  ZoneList({Key key, @required this.category, this.regionId}) : super(key: key);

  @override
  _ZoneList createState() => _ZoneList();
}

class _ZoneList extends State<ZoneList> {
  final AppBarController appBarController = AppBarController();

  @override
  void initState() {
    super.initState();
    bloc.fetchAllZones(widget.regionId);
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
          stream: bloc.allZones,
          builder: (context, AsyncSnapshot<List<Zone>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.isEmpty) {
                return Center(
                  child: Text("No Items Available"),
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

  Widget buildList(List<Zone> data) {
    return ListView.builder(
        itemCount: data.length,
        /*gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        */
        itemBuilder: (BuildContext context, int index) {
          return ZoneListItem(
            zone: data[index],
          );
        });
  }
}
