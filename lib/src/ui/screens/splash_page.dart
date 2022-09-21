import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lions/src/ui/screens/authentication_page.dart';
import 'package:lions/src/ui/screens/dashboard_screen.dart';
import 'package:lions/src/ui/widget/splash_backgroud_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<SplashPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  void initState() {
    super.initState();
    startTime();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Color.fromRGBO(18, 46, 86, 1),
        //child: footerInfo(),
        child: CustomPaint(
          painter: SplashBackgroundWidget(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(child: logoContainer()),
              footerInfo(),
            ],
          ),
        ),
      ),
    );
  }

  Widget logoContainer() {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(
          'assets/images/international_logo2.png',
          fit: BoxFit.cover,
          width: 185,
          height: 185,
          //width: MediaQuery.of(context).size.width,
        ),
        Text(
          "District 321-A2",
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 20,
              //fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        Text(
          "2022-23",
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 20,
              //fontWeight: FontWeight.bold,
              color: Colors.amber),
        ),
      ],
    );
  }

  Widget footerInfo() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Li",
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
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
              "ns Almanac",
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ],
        ),
        Text(
          "For District 321-A2 Every Lion",
          style: TextStyle(
              fontStyle: FontStyle.normal,
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
        SizedBox(
          height: 40,
        ),
      ],
    );
  }

  startTime() async {
    var duration = new Duration(seconds: 3);
    return new Timer(duration, route);
  }

  route() {
    _prefs.then((SharedPreferences prefs) {
      bool isAuthenticated = prefs.getBool("is_authenticated") ?? false;
      if (isAuthenticated) {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DashboardScreen()));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => AuthenticationPage()));
      }
    });
  }
}
