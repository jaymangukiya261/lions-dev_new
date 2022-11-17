import 'package:flutter/material.dart';
import 'package:lions/src/blocs/cabinet_bloc.dart';
import 'package:lions/src/blocs/generate_pdf/bloc_pdf.dart';
import 'package:lions/src/models/cabinet_member.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/ui/widget/cabinet_member_list_item.dart';
import 'package:lions/src/ui/widget/search-bar/app_bar_controller.dart';
import 'package:lions/src/ui/widget/search-bar/search_app_bar.dart';

class CabinetMemberList extends StatefulWidget {
  LionsCategory category;

  CabinetMemberList({
    Key key,
    @required this.category,
  }) : super(key: key);

  @override
  _CabinetMemberListState createState() => _CabinetMemberListState();
}

class _CabinetMemberListState extends State<CabinetMemberList> {
  final AppBarController appBarController = AppBarController();

  @override
  void initState() {
    super.initState();
    bloc.fetchAllCabinetMembers();
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
                        pdfs
                            .createDgTeamReport(
                                bloc.membersPrint, 'Cabinet Members Report')
                            .whenComplete(() {
                          setState(() {
                            pdfs.isProcessing = false;
                          });
                        });
                      });
                    },
                    child: Text(
                      'Download Cabinet Report',
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
            bloc.setSearchTerm(value);
          },
          onTap: () {
            bloc.setSearchTerm('');
          },
        ),
        body: StreamBuilder(
          stream: bloc.allCabinetMembers,
          builder: (context, AsyncSnapshot<List<CabinetMember>> snapshot) {
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
          },
        ));
    //throw UnimplementedError();
  }

  Widget buildList(List<CabinetMember> data) {
    return ListView.builder(
        itemCount: data.length,
        /*gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        */
        itemBuilder: (BuildContext context, int index) {
          return CabinetMemberListItem(
            cabinetMember: data[index],
          );
        });
  }
}
