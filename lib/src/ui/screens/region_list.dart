import 'package:flutter/material.dart';
import 'package:lions/src/blocs/regions_bloc.dart';
import 'package:lions/src/models/region.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/ui/widget/region_list_item.dart';
import 'package:lions/src/ui/widget/search-bar/app_bar_controller.dart';
import 'package:lions/src/ui/widget/search-bar/search_app_bar.dart';

import '../../blocs/generate_pdf/bloc_pdf.dart';
import '../../models/zone_response.dart';
import '../../resources/repository.dart';

class RegionList extends StatefulWidget {
  LionsCategory category;

  RegionList({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  _RegionListState createState() => _RegionListState();
}

class _RegionListState extends State<RegionList> {
  final AppBarController appBarController = AppBarController();

  final _repository = Repository();
  @override
  void initState() {
    super.initState();
    bloc.fetchAllRegions();
  }

  final pdfs = pdfCreation();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        appBarController: appBarController,
        mainAppBar: AppBar(
          title: Text("${widget.category.title}"),
          actions: [
            if (!pdfs.isProcessing)
              TextButton(
                  onPressed: () {
                    setState(() {
                      pdfs.createRegionPdf(bloc.regionPrint).whenComplete(() {
                        setState(() {
                          pdfs.isProcessing = false;
                        });
                      });
                    });
                  },
                  child: Text(
                    'Download Region Report',
                    style: TextStyle(color: Colors.white),
                  ))
            else
              SizedBox(
                  height: 5,
                  width: 50,
                  child: Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
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
          bloc.clear();
        },
      ),
      body: StreamBuilder(
          stream: bloc.allRegions,
          builder: (context, AsyncSnapshot<List<Region>> snapshot) {
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

  Widget buildList(List<Region> data) {
    return ListView.builder(
        itemCount: data.length,
        /*gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        */
        itemBuilder: (BuildContext context, int index) {
          return RegionListItem(
            region: data[index],
          );
        });
  }
}
