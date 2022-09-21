import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:lions/src/blocs/clubs_bloc.dart';
import 'package:lions/src/models/club.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/ui/widget/club_list_item.dart';
import 'package:lions/src/ui/widget/search-bar/app_bar_controller.dart';
import 'package:lions/src/ui/widget/search-bar/search_app_bar.dart';
import 'package:lions/src/ui/widget/zone_list_item.dart';

class ClubList extends StatefulWidget {
  LionsCategory category;
  int regionId;
  int zoneId;
  Type parentClass;

  ClubList(
      {Key key,
      @required this.category,
      this.parentClass,
      this.regionId,
      this.zoneId})
      : super(key: key);

  @override
  _ClubListState createState() => _ClubListState();
}

class _ClubListState extends State<ClubList> {
  final AppBarController appBarController = AppBarController();

  void initState() {
    super.initState();
    bloc.fetchAllClubs(widget.parentClass == ZoneListItem ? 0 : widget.regionId,
        widget.zoneId);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        appBarController: appBarController,
        mainAppBar: AppBar(
          title: Text("${widget.category.title}"),
          actions: [
            TextButton(
                onPressed: () {
                  bloc.clubListPrint.forEach((element) {
                    print('Hello final data ${element.name}');
                  });

                  pdfs.createPdf(bloc.clubListPrint);
                },
                child: Text(
                  'Club Report',
                  style: TextStyle(color: Colors.white),
                )),
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
          bloc.search('');
        },
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(0.0, 8.0, 0.0, 16.0),
            child: ToggleSwitch(
              minWidth: 90.0,
              initialLabelIndex: -1,
              //activeBgColor: Color.fromRGBO(19, 34, 144, 1),
              activeBgColor: Colors.amber,
              activeFgColor: Colors.black,
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.grey[900],
              labels: ['Delhi', 'HR', 'HP'],
              onToggle: (index) {
                String filter = '';
                switch (index) {
                  case 0:
                    filter = "Delhi";
                    break;
                  case 1:
                    filter = "Haryana";
                    break;
                  case 2:
                    filter = "Himachal";
                    break;
                  default:
                    filter = "";
                }
                bloc.filter(filter);
              },
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: bloc.allClubs,
              builder: (context, AsyncSnapshot<List<Club>> snapshot) {
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
              },
            ),
          ),
        ],
      ),
    );
    //throw UnimplementedError();
  }

  Widget buildList(List<Club> data) {
    return ListView.builder(
        itemCount: data.length,
        /*gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        */
        itemBuilder: (BuildContext context, int index) {
          return ClubListItem(
            club: data[index],
          );
        });
  }
}
