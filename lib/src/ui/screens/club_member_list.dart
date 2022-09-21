import 'package:flutter/material.dart';
import 'package:lions/src/models/cabinet_member.dart';
import 'package:lions/src/ui/widget/cabinet_member_list_item.dart';
import 'package:lions/src/ui/widget/search-bar/app_bar_controller.dart';
import 'package:lions/src/ui/widget/search-bar/search_app_bar.dart';

class ClubMemberList extends StatefulWidget {
  String clubName;
  List<CabinetMember> membersList;

  ClubMemberList({
    Key key,
    @required this.clubName,
    @required this.membersList,
  }) : super(key: key);

  @override
  _ClubMemberListState createState() => _ClubMemberListState();
}

class _ClubMemberListState extends State<ClubMemberList> {
  final AppBarController appBarController = AppBarController();

  bool _isSearching = false;
  String _searchTerm = '';

  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchAppBar(
        appBarController: appBarController,
        mainAppBar: AppBar(
          title: Text("${widget.clubName}"),
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
          //search(value);
          setState(() {
            _isSearching = true;
            _searchTerm = value;
          });
        },
        onTap: () {
          setState(() {
            _isSearching = false;
            _searchTerm = '';
          });
        },
      ),
      body: _isSearching
          ? _buildList(_filterList(widget.membersList, _searchTerm))
          : _buildList(widget.membersList),
    );
  }

  Widget _buildList(List<CabinetMember> _memberList) {
    return _memberList.length > 0
        ? ListView.builder(
            itemCount: _memberList.length,
            /*gridDelegate:
            new SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        */
            itemBuilder: (BuildContext context, int index) {
              return CabinetMemberListItem(
                cabinetMember: _memberList[index],
              );
            },
          )
        : Center(
            child: Text("No Items Available"),
          );
  }

  _filterList(List<CabinetMember> _memberList, String _searchTerm) {
    return _memberList
        .where((element) =>
            element.name.toLowerCase().contains(_searchTerm.toLowerCase()))
        .toList();
  }
}
