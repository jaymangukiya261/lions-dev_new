import 'package:flutter/material.dart';
import 'package:lions/src/blocs/dg_team_bloc.dart';
import 'package:lions/src/blocs/generate_pdf/bloc_pdf.dart';
import 'package:lions/src/models/cabinet_member.dart';
import 'package:lions/src/models/dg_team_response.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/ui/widget/dg_team_member_list_item.dart';
import 'package:lions/src/ui/widget/search-bar/app_bar_controller.dart';
import 'package:lions/src/ui/widget/search-bar/search_app_bar.dart';

class DgTeamMemberList extends StatefulWidget {
  LionsCategory category;

  DgTeamMemberList({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  _DgTeamMemberListState createState() => _DgTeamMemberListState();
}

class _DgTeamMemberListState extends State<DgTeamMemberList> {
  final AppBarController appBarController = AppBarController();
  final pdfs = pdfCreation();

  @override
  void initState() {
    super.initState();
    bloc.fetchAllDgTeamMembers();
  }

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
                      pdfs
                          .createDgTeamReport(
                              bloc.membersPrint, 'DG Team Report')
                          .whenComplete(() {
                        setState(() {
                          pdfs.isProcessing = false;
                        });
                      });
                    });
                  },
                  child: Text(
                    'Download DG Team Report',
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
          stream: bloc.allDgTeamMembers,
          builder: (context, AsyncSnapshot<List<CabinetMember>> snapshot) {
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

  Widget buildList(List<CabinetMember> data) {
    return ListView.builder(
        itemCount: data.length,
        /*gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        */
        itemBuilder: (BuildContext context, int index) {
          return DgTeamMemberListItem(
            member: data[index],
          );
        });
  }
}
