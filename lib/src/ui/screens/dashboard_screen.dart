import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lions/src/common_methods.dart';
import 'package:lions/src/constants.dart';
import 'package:lions/src/models/advertisement_response.dart';
import 'package:lions/src/models/lions_category.dart';
import 'package:lions/src/models/popup.dart';
import 'package:lions/src/models/project_response.dart';
import 'package:lions/src/resources/user_api_provider.dart';
import 'package:lions/src/ui/screens/alert_list.dart';
import 'package:lions/src/ui/screens/authentication_page.dart';
import 'package:lions/src/ui/screens/custom_popup.dart';
import 'package:lions/src/ui/screens/project_detail.dart';
import 'package:lions/src/ui/screens/search_screen.dart';
import 'package:lions/src/ui/widget/arc_widget.dart';
import 'package:lions/src/ui/widget/lions_category_item.dart';
import 'package:lions/src/blocs/projects_bloc.dart';
import 'package:lions/src/blocs/advertisement_bloc.dart' as adBloc;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreen createState() => _DashboardScreen();
}

class _DashboardScreen extends State<DashboardScreen> {
  TextEditingController controller = new TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  bool _isAuthenticated = false;

  List<String> _searchResult = [];

  int _currentProjectPage = 0;
  int _totalProjectPages = 0;
  PageController _projectPageController = PageController(
    initialPage: 0,
  );

  int _currentAdsPage = 0;
  int _totalAdsPages = 0;
  PageController _adsPageController = PageController(
    initialPage: 0,
  );

  @override
  void initState() {
    super.initState();

    toggleFCMSubscription('subscribe');

    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage message) {
      if (message != null) {
        // print(message);
        var router = new MaterialPageRoute(builder: (BuildContext context) {
          return AlertList();
        });
        Navigator.of(context).push(router);
      }
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification notification = message.notification;
      AndroidNotification android = message.notification?.android;
      if (notification != null && android != null) {
        /*flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              channel.description,
              // TODO add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: 'launch_background',
            ),
          ),
        );*/
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      var router = new MaterialPageRoute(builder: (BuildContext context) {
        return AlertList();
      });
      Navigator.of(context).push(router);
    });

    _fetchPopup();

    _prefs.then((SharedPreferences prefs) {
      _isAuthenticated = prefs.getBool("is_authenticated") ?? false;
    });

    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentProjectPage < _totalProjectPages) {
        _currentProjectPage++;
      } else {
        _currentProjectPage = 0;
      }

      _projectPageController.animateToPage(
        _currentProjectPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );

      if (_currentAdsPage < _totalAdsPages) {
        _currentAdsPage++;
      } else {
        _currentAdsPage = 0;
      }

      _adsPageController.animateToPage(
        _currentAdsPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    bloc.fetchAllProjeccts();
    adBloc.bloc.fetchAllAdvertisements();

    return Scaffold(
      /*appBar: AppBar(
        title: Text(''),
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
      ),*/
      body: SingleChildScrollView(
        child: Container(
          color: Color.fromRGBO(19, 34, 144, 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    height: 200,
                    child: CustomPaint(painter: ArcWidget()),
                  ),
                  Positioned(
                      right: 8.0,
                      top: 32.0,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(
                              Icons.notifications,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              var router = new MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return AlertList();
                                  },
                                  fullscreenDialog: true);
                              Navigator.of(context).push(router);
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.logout,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              _doSignout();
                            },
                          ),
                        ],
                      )),
                  Image.asset(
                    'assets/images/international_logo2.png',
                    width: 120,
                    height: 120,
                  ),
                ],
              ),
              _buildHeaderSection(),
              Container(
                constraints: BoxConstraints.expand(height: 200),
                padding: EdgeInsets.all(8),
                child: StreamBuilder(
                  stream: bloc.allProjeccts,
                  builder: (context, AsyncSnapshot<ProjectResponse> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.results.isEmpty) {
                        _totalProjectPages = 0;
                        return SizedBox(
                          height: 16.0,
                        );
                      } else {
                        _totalProjectPages = snapshot.data.results.length;
                        return _buildProjectPager(snapshot);
                      }
                    } else if (snapshot.hasError) {
                      _totalProjectPages = 0;
                      return Text(snapshot.error.toString());
                    }
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
              _buildFooterSection(),
              Container(
                constraints: BoxConstraints.expand(height: 200),
                padding: EdgeInsets.all(8),
                child: StreamBuilder(
                  stream: adBloc.bloc.allAdvertisements,
                  builder:
                      (context, AsyncSnapshot<AdvertisementResponse> snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.data.results.isEmpty) {
                        _totalAdsPages = 0;
                        return SizedBox(
                          height: 16.0,
                        );
                      } else {
                        _totalAdsPages = snapshot.data.results.length;
                        return _buildAdvertisementPager(snapshot);
                      }
                    } else if (snapshot.hasError) {
                      _totalAdsPages = 0;
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
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!_isAuthenticated) {
            CommonMethods.displayAlertToAuthenticate(
                context, Constants.ALERT_LOGIN);
            return;
          }

          var router = new MaterialPageRoute(
              builder: (BuildContext context) {
                return SearchScreen();
              },
              fullscreenDialog: true);
          Navigator.of(context).push(router);
        },
        child: const Icon(Icons.search),
        backgroundColor: Colors.amber,
      ),
    );
  }

  Widget _buildHeaderSection() {
    return FittedBox(
      child: Center(
        child: Container(
          //color: Colors.red,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + 100,
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildSquare(lionsCategory.elementAt(0)),
                    ),
                    //SizedBox(width: 12.0),
                    VerticalDivider(
                      width: 2.0,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildSquare(lionsCategory.elementAt(1)),
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 12.0),
              _columnSeparator(),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildSquare(lionsCategory.elementAt(2)),
                    ),
                    //SizedBox(width: 12.0),
                    VerticalDivider(
                      width: 2.0,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildSquare(lionsCategory.elementAt(3)),
                    ),
                  ],
                ),
              ),
              _columnSeparator(),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildSquare(lionsCategory.elementAt(4)),
                    ),
                    //SizedBox(width: 12.0),
                    VerticalDivider(
                      width: 2.0,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildSquare(lionsCategory.elementAt(5)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFooterSection() {
    return FittedBox(
      child: Center(
        child: Container(
          //color: Colors.red,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width + 100,
          padding: EdgeInsets.symmetric(vertical: 24.0, horizontal: 12.0),
          child: Column(
            children: <Widget>[
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildSquare(lionsCategory.elementAt(6)),
                    ),
                    //SizedBox(width: 12.0),
                    VerticalDivider(
                      width: 2.0,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildSquare(lionsCategory.elementAt(7)),
                    ),
                  ],
                ),
              ),
              //SizedBox(height: 12.0),
              _columnSeparator(),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildSquare(lionsCategory.elementAt(8)),
                    ),
                    //SizedBox(width: 12.0),
                    VerticalDivider(
                      width: 2.0,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildSquare(lionsCategory.elementAt(9)),
                    ),
                  ],
                ),
              ),
              _columnSeparator(),
              Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: _buildSquare(lionsCategory.elementAt(10)),
                    ),
                    //SizedBox(width: 12.0),
                    VerticalDivider(
                      width: 2.0,
                      color: Colors.white,
                    ),
                    Expanded(
                      flex: 1,
                      child: _buildSquare(lionsCategory.elementAt(11)),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _columnSeparator() {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Container(
            height: 0.5,
            color: Colors.white,
          ),
        ),
        Container(
          height: 80,
          width: 80,
          //color: Colors.amber,
        ),
        Expanded(
          flex: 1,
          child: Container(
            height: 0.5,
            color: Colors.white,
          ),
        ),
      ],
    );
  }

  Widget _buildSquare(LionsCategory category) {
    return Center(
      child: AspectRatio(
        aspectRatio: 1.0,
        /*child: Container(
          decoration: BoxDecoration(
              color: Colors.transparent,
              border: Border.all(color: Colors.transparent, width: 1.0)),
        ),*/
        child: LionsCategoryItem(
          category: category,
        ),
      ),
    );
  }

  Widget _buildProjectPager(AsyncSnapshot<ProjectResponse> snapshot) {
    return PageView.builder(
      controller: _projectPageController,
      itemCount: snapshot.data.results.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {
            var router = new MaterialPageRoute(builder: (BuildContext context) {
              return ProjectDetail(project: snapshot.data.results[index]);
            });
            Navigator.of(context).push(router);
          },
          child: Container(
            //margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
            child: Stack(
              fit: StackFit.expand,
              alignment: AlignmentDirectional.topCenter,
              children: [
                Image(
                  image: NetworkImage(
                    snapshot.data.results[index].image,
                    //"https://zvelo.com/wp-content/uploads/2018/11/anatomy-of-a-full-path-url-hostname-tld-path-protocol.jpg",
                  ),
                  fit: BoxFit.contain,
                ),
                Positioned(
                  left: 0.0,
                  right: 0.0,
                  bottom: 0.0,
                  child: ColoredBox(
                    color: Colors.black38,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        children: [
                          Column(
                            mainAxisSize: MainAxisSize.max,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                snapshot.data.results[index].name,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.amber),
                              ),
                              // Text(
                              //   snapshot.data.results[index].date,
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   textAlign: TextAlign.center,
                              //   style: TextStyle(
                              //       fontWeight: FontWeight.w400,
                              //       color: Colors.amber),
                              // ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAdvertisementPager(
      AsyncSnapshot<AdvertisementResponse> snapshot) {
    return PageView.builder(
      controller: _adsPageController,
      itemCount: snapshot.data.results.length,
      itemBuilder: (BuildContext context, int index) {
        return Container(
          //margin: EdgeInsets.fromLTRB(16, 0, 16, 0),
          child: Stack(
            fit: StackFit.expand,
            alignment: AlignmentDirectional.topCenter,
            children: [
              Image(
                image: NetworkImage(
                  snapshot.data.results[index].image,
                ),
                fit: BoxFit.contain,
              ),
              // Positioned(
              //   left: 0.0,
              //   right: 0.0,
              //   bottom: 0.0,
              //   child: ColoredBox(
              //     color: Colors.black38,
              //     child: Padding(
              //       padding: EdgeInsets.all(8.0),
              //       child: Wrap(
              //         alignment: WrapAlignment.center,
              //         children: [
              //           Column(
              //             mainAxisSize: MainAxisSize.max,
              //             crossAxisAlignment: CrossAxisAlignment.center,
              //             mainAxisAlignment: MainAxisAlignment.center,
              //             children: [
              //               Text(
              //                 snapshot.data.results[index].name,
              //                 maxLines: 2,
              //                 overflow: TextOverflow.ellipsis,
              //                 textAlign: TextAlign.center,
              //                 style: TextStyle(
              //                     fontSize: 18.0,
              //                     fontWeight: FontWeight.bold,
              //                     color: Colors.amber),
              //               ),
              //               Text(''),
              //             ],
              //           ),
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
            ],
          ),
        );
      },
    );
  }

  BoxDecoration gridDecoration(int index) {
    if (index % 2 == 0) {
      return BoxDecoration(
        border: Border(
          right: BorderSide(color: Colors.white, width: 1.0),
          bottom: BorderSide(color: Colors.white, width: 1.0),
        ),
      );
    } else {
      return BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white, width: 1.0),
          left: BorderSide(color: Colors.white, width: 1.0),
        ),
      );
    }
  }

  onSearchTextChanged(String text) async {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    setState(() {});
  }

  void _doSignout() async {
    toggleFCMSubscription('unsubscribe');

    final SharedPreferences prefs = await _prefs;
    prefs.setBool("is_authenticated", false);
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => AuthenticationPage()));
  }

  _fetchPopup() {
    UserApiProvider().fetchPopup().then((Popup value) {
      /*  Image _image = new Image.network(value.image);
      final Completer<void> completer = Completer<void>();

      _image.image
          .resolve(ImageConfiguration())
          .addListener(ImageStreamListener((ImageInfo info, bool syncCall) {
        _showPopup(value.name, _image);
        completer.complete();
      }));
      if (mounted) {
        //do sth
      }*/
      _showPopup(value.name, value.image);
    }).onError((error, stackTrace) {
      print("Error: " + error.toString());
    });
  }

  void _showPopup(String name, String image) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CustomPopup(
          title: name,
          image: image,
        );
      },
    );
  }

  Future<void> toggleFCMSubscription(String value) async {
    switch (value) {
      case 'subscribe':
        {
          await FirebaseMessaging.instance
              .subscribeToTopic('high_importance_channel');
        }
        break;
      case 'unsubscribe':
        {
          await FirebaseMessaging.instance
              .unsubscribeFromTopic('high_importance_channel');
        }
        break;
      default:
        break;
    }
  }
}

const List<LionsCategory> lionsCategory = const <LionsCategory>[
  const LionsCategory(
      id: LionsCategory.CATEGORY_INTERNATIONAL,
      title: 'International',
      icon: 'assets/images/international.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_MULTIPLE,
      title: 'Multiple',
      icon: 'assets/images/multiple.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_DISTRICTS,
      title: 'Districts',
      icon: 'assets/images/district.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_REGION,
      title: 'Region',
      icon: 'assets/images/region.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_ZONE,
      title: 'Zone',
      icon: 'assets/images/zone.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_CLUBS,
      title: 'Clubs',
      icon: 'assets/images/clubs.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_DG_TEAM,
      title: 'DG Team',
      icon: 'assets/images/dg-team.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_PAST_GOVERNERS,
      title: 'Past Governers',
      icon: 'assets/images/past-governers.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_CABINET,
      title: 'Cabinet',
      icon: 'assets/images/cabinet.png'),
  /*const LionsCategory(
      id: LionsCategory.CATEGORY_CITY,
      title: 'City',
      icon: 'assets/images/city.png'),*/
  const LionsCategory(
      id: LionsCategory.CATEGORY_DOWNLOADABLE,
      title: 'Download',
      icon: 'assets/images/city.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_MJF_MEMBERS,
      title: 'MJF Members',
      icon: 'assets/images/mjf-members.png'),
  const LionsCategory(
      id: LionsCategory.CATEGORY_NEWSLETTER,
      title: 'Newsletter',
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
