import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lions/src/models/auth_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:lions/src/ui/screens/dashboard_screen.dart';
import 'package:lions/src/ui/screens/otp_verification_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthenticationPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SplashState();
  }
}

class SplashState extends State<AuthenticationPage> {
  final TextEditingController _membershipController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
      GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(18, 46, 86, 1),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Welcome to",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text(
                  "Li",
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                Image.asset(
                  'assets/images/lions_logo.png',
                  fit: BoxFit.cover,
                  width: 25,
                  height: 25,
                  //width: MediaQuery.of(context).size.width,
                ),
                Text(
                  "ns Almanac",
                  style: TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              ],
            ),
            SizedBox(
              height: 32.0,
            ),
            Container(
              decoration: BoxDecoration(
                  color: Color.fromRGBO(34, 28, 52, 0.5),
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Text(
                    "SIGN IN",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 24,
                        fontWeight: FontWeight.normal,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Divider(
                    color: Color.fromRGBO(250, 92, 51, 1),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: 'Membership No',
                      //labelText: 'Registration No',
                      prefixIcon: Icon(Icons.verified_user),
                      //prefixText: '+91',
                    ),
                    style: TextStyle(color: Colors.black87),
                    keyboardType: TextInputType.number,
                    controller: _membershipController,
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  TextField(
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10.0)),
                          borderSide: BorderSide(color: Colors.teal)),
                      hintText: 'Mobile No',
                      //labelText: 'Mobile Number',
                      prefixIcon: Icon(Icons.phone_android),
                      //prefixText: '+91',
                      //suffixText: 'USD',
                      //suffixStyle: const TextStyle(color: Colors.green)
                    ),
                    style: TextStyle(color: Colors.black87),
                    keyboardType: TextInputType.phone,
                    controller: _phoneController,
                  ),
                  SizedBox(height: 8.0),
                  /*ButtonTheme(
                    minWidth: 150.0,
                    child: ElevatedButton(
                      onPressed: () => navigateToHome(),
                      child: Text(
                        "SIGN IN",
                        style: TextStyle(
                          fontStyle: FontStyle.normal,
                          color: Colors.white,
                          backgroundColor: Color.fromRGBO(250, 92, 51, 1),
                        ),
                      ),
                    ),
                  ),*/
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          child: Text(
                            "SIGN IN",
                            style: TextStyle(fontSize: 14),
                          ),
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4.0),
                                ),
                                side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),
                          onPressed: () {
                            if (_membershipController.text.isEmpty) {
                              displayAlert(
                                  "Membership number can not be blank.");
                            } else if (_phoneController.text.isEmpty) {
                              displayAlert("Phone number can not be blank.");
                            } else {
                              authenticate(_membershipController.text,
                                  _phoneController.text);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                            child: Text(
                              "Guest",
                              style: TextStyle(fontSize: 14),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.red,
                              //minimumSize: Size.fromWidth(150),
                              textStyle: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                              ),
                            ),
                            /*style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.red),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(4.0),
                                ),
                                side: BorderSide(color: Colors.red),
                              ),
                            ),
                          ),*/
                            onPressed: () => guestNavigateToHome()),
                      )
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      ),
    );
  }

  guestNavigateToHome() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("is_authenticated", false);
    /*_prefs.then((SharedPreferences prefs) {
      return prefs.setBool("is_authenticated", true);
    });*/

    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => DashboardScreen()));
  }

  void displayAlert(String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: "OK",
        textColor: Colors.white,
        onPressed: () => {},
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  void authenticate(String membershipNumber, String phone) async {
    final AuthResponse response =
        await Repository().authenticate(membershipNumber, phone);

    if (response.status.toLowerCase() == "success") {
      var router = new MaterialPageRoute(builder: (BuildContext context) {
        return OtpVerificationPage(
          membershipNumber: membershipNumber,
          phoneNumber: phone,
          otp: response.otp,
        );
      });
      Navigator.of(context).push(router);
    } else if (response.status.toLowerCase() == "fail") {
      displayAlert(response.message);
    }
  }
}
