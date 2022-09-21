import 'package:flutter/material.dart';
import 'package:lions/src/blocs/governers_bloc.dart';
import 'package:lions/src/models/governer.dart';
import 'package:lions/src/models/governer_response.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/ui/widget/past_governer_list_item.dart';
import 'package:lions/src/ui/widget/search-bar/app_bar_controller.dart';
import 'package:lions/src/ui/widget/search-bar/search_app_bar.dart';

class PastGovernerList extends StatefulWidget {
  LionsCategory category;

  PastGovernerList({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  _PastGovernerListState createState() => _PastGovernerListState();
}

class _PastGovernerListState extends State<PastGovernerList> {
  final AppBarController appBarController = AppBarController();

  @override
  void initState() {
    super.initState();
    bloc.fetchAllPastGoverners();
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
          stream: bloc.allPastGoverners,
          builder: (context, AsyncSnapshot<List<Governer>> snapshot) {
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

  Widget buildList(List<Governer> data) {
    return ListView.builder(
        itemCount: data.length,
        /*gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        */
        itemBuilder: (BuildContext context, int index) {
          return PastGovernerListItem(
            governer: data[index],
          );
        });
  }
}
