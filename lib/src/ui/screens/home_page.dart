import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/ui/widget/lions_category_item.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = new TextEditingController();

  List<String> _searchResult = [];
  //List<Location> _userDetails = [];
  List<LionsCategory> lionsSection1 = <LionsCategory>[];
  List<LionsCategory> lionsSection2 = <LionsCategory>[];

  @override
  void initState() {
    super.initState();

    for (var i = 0; i < lionsCategory.length - 4; i++) {
      lionsSection1.add(lionsCategory.elementAt(i));
    }

    for (var i = 4; i < lionsCategory.length; i++) {
      lionsSection2.add(lionsCategory.elementAt(i));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            "Demo"), /*Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "MyLi",
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Image.asset(
              'assets/images/lions_logo.png',
              fit: BoxFit.cover,
              width: 15,
              height: 15,
              //width: MediaQuery.of(context).size.width,
            ),
            Text(
              "n",
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),*/
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(child: Text("Drawer Header")),
            ListTile(
              title: Text("Item 1"),
              leading: Icon(Icons.language),
              onTap: () {},
            ),
            ListTile(
              title: Text("Item 2"),
              leading: Icon(Icons.language),
              onTap: () {},
            )
          ],
        ),
      ),
      body: Container(
        //color: Color.fromRGBO(18, 46, 86, 1),
        child: CustomScrollView(
          slivers: [
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Card(
                      elevation: 5,
                      child: ListTile(
                        leading: Icon(Icons.search),
                        title: TextField(
                          decoration: InputDecoration(
                              hintText: 'Search', border: InputBorder.none),
                          controller: controller,
                          onChanged: onSearchTextChanged,
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.cancel),
                          onPressed: () {
                            controller.clear();
                            onSearchTextChanged('');
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints.expand(height: 180),
                    padding: EdgeInsets.all(8),
                    child: PageView(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 208, 60, 1),
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          //margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'assets/images/sample-ad-1.png',
                              fit: BoxFit.fitWidth,
                              //width: MediaQuery.of(context).size.width,
                            ),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 208, 60, 1),
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Center(
                            child: Text("Event Page 2"),
                          ),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            color: Color.fromRGBO(255, 208, 60, 1),
                            border: Border.all(color: Colors.transparent),
                            borderRadius: BorderRadius.all(
                              Radius.circular(20),
                            ),
                          ),
                          margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                          child: Center(
                            child: Text("Event Page 3"),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
              sliver: SliverGrid(
                delegate: SliverChildListDelegate(
                  List.generate(lionsSection1.length, (index) {
                    return Center(
                      child: LionsCategoryItem(category: lionsSection1[index]),
                    );
                  }),
                ),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
              ),
            ),
            /*Expanded(r
              flex: 4,
              child: GridView.count(
                padding: EdgeInsets.all(16),
                crossAxisCount: 3,
                children: List.generate(lionsSection1.length, (index) {
                  return Center(
                    child: LionsCategoryItem(category: lionsSection1[index]),
                  );
                }),
              ),
            ),*/
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  constraints: BoxConstraints.expand(height: 180),
                  padding: EdgeInsets.all(10),
                  child: PageView(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 208, 60, 1),
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        //margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(
                            'assets/images/sample-ad-2.png',
                            fit: BoxFit.fitWidth,
                            //width: MediaQuery.of(context).size.width,
                          ),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 208, 60, 1),
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Center(
                          child: Text("Event Page 2"),
                        ),
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(255, 208, 60, 1),
                          border: Border.all(color: Colors.transparent),
                          borderRadius: BorderRadius.all(
                            Radius.circular(20),
                          ),
                        ),
                        margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
                        child: Center(
                          child: Text("Event Page 3"),
                        ),
                      )
                    ],
                  ),
                ),
              ]),
            ),
            SliverPadding(
              padding: EdgeInsets.fromLTRB(10, 4, 10, 4),
              sliver: SliverGrid(
                delegate: SliverChildListDelegate(
                    List.generate(lionsSection2.length, (index) {
                  return Center(
                    child: LionsCategoryItem(category: lionsSection2[index]),
                  );
                })),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
              ),
            ),

            /*Expanded(
              flex: 4,
              child: GridView.count(
                padding: EdgeInsets.all(16),
                crossAxisCount: 3,
                children: List.generate(lionsSection2.length, (index) {
                  return Center(
                    child: LionsCategoryItem(category: lionsSection2[index]),
                  );
                }),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(16, 8, 16, 0),
              color: Color.fromRGBO(255, 208, 60, 1),
              height: 50,
              width: 320,
              child: Text("Section for Advertisement"),
            )*/
          ],
        ),
      ),
    );
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    setState(() {});
  }
}

const List<LionsCategory> lionsCategory = const <LionsCategory>[
  const LionsCategory(
      id: LionsCategory.CATEGORY_DISTRICTS,
      title: 'Districts',
      icon: 'assets/images/international.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_REGION,
      title: 'Region',
      icon: 'assets/images/international.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_ZONE,
      title: 'Zone',
      icon: 'assets/images/international.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_CITY,
      title: 'City',
      icon: 'assets/images/international.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_CLUBS,
      title: 'Clubs',
      icon: 'assets/images/international.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_CABINET,
      title: 'Cabinet',
      icon: 'assets/images/international.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_DG_TEAM,
      title: 'DG Team',
      icon: 'assets/images/international.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_PAST_GOVERNERS,
      title: 'Past Governers',
      icon: 'assets/images/international.png'),
  // const LionsCategory(
  //     id: LionsCategory.CATEGORY_PROJECTS,
  //     title: 'Projects',
  //     icon: Icons.settings),

  // const LionsCategory(
  //     title: 'Past District Governers', icon: Icons.photo_album),
  // const LionsCategory(title: 'Multiple Districts', icon: Icons.wifi),
  // const LionsCategory(title: 'Lions Clubs International', icon: Icons.wifi),
];
