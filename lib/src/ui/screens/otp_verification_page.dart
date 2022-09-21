import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:lions/src/common_methods.dart';
import 'package:lions/src/models/auth_response.dart';
import 'package:lions/src/resources/repository.dart';
import 'package:lions/src/ui/screens/dashboard_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpVerificationPage extends StatefulWidget {
  String membershipNumber;
  String phoneNumber;
  String otp;

  OtpVerificationPage({
    Key key,
    @required this.membershipNumber,
    @required this.phoneNumber,
    @required this.otp,
  }) : super(key: key);
  @override
  State<StatefulWidget> createState() {
    return _OtpVerificationState();
  }
}

class _OtpVerificationState extends State<OtpVerificationPage> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        color: Color.fromRGBO(18, 46, 86, 1),
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Text(
              "Verification",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "Enter a 6 Digit Number That Was Sent To +(91) ${widget.phoneNumber} ",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 17,
                  fontWeight: FontWeight.normal,
                  color: Colors.white),
            ),
            SizedBox(
              height: 32.0,
            ),
            Container(
              height: 150,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              padding: EdgeInsets.all(16.0),
              child: PinCodeTextField(
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.green.shade600,
                  fontWeight: FontWeight.bold,
                ),
                length: 6,
                keyboardType: TextInputType.number,
                pinTheme: PinTheme(
                  shape: PinCodeFieldShape.box,
                  borderRadius: BorderRadius.circular(5),
                  fieldHeight: 50,
                  fieldWidth: 40,
                  /*activeFillColor:
                      hasError ? Colors.blue.shade100 : Colors.white,*/
                ),
                blinkWhenObscuring: true,
                animationType: AnimationType.fade,
                cursorColor: Colors.black,
                boxShadows: [
                  BoxShadow(
                    offset: Offset(0, 1),
                    color: Colors.black12,
                    blurRadius: 10,
                  )
                ],
                onCompleted: (value) {
                  if (value == widget.otp) {
                    navigateToHome();
                  } else {
                    CommonMethods.displayAlert(
                        context, "Invalid OTP entered.", () => {});
                  }
                },
                onChanged: (value) {
                  // handle verification here
                },
              ),

              /*OtpTextField(
                numberOfFields: 6,
                textStyle: TextStyle(color: Colors.black, fontSize: 21),
                cursorColor: Color.fromRGBO(34, 28, 52, 0.5),
                enabledBorderColor: Color.fromRGBO(34, 28, 52, 0.5),
                disabledBorderColor: Color.fromRGBO(34, 28, 52, 0.5),
                //borderColor: Color(0xFF512DA8),
                showFieldAsBox:
                    false, //set to true to show as box or false to show as dash
                onCodeChanged: (String code) {
                  //handle validation or checks here
                },
                onSubmit: (String verificationCode) {
                  / *showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text("Verification Code"),
                        content: Text('Code entered is $verificationCode'),
                      );
                    },
                  );* /
                  if (verificationCode == widget.otp) {
                    navigateToHome();
                  } else {
                    CommonMethods.displayAlert(context, "Invalid OTP entered.", () => {});
                  }
                }, // end onSubmit
              ),*/
            ),
            SizedBox(
              height: 32.0,
            ),
            ElevatedButton(
              child: Text(
                "Resend Code",
                style: TextStyle(fontSize: 14),
              ),
              style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(4.0),
                    ),
                    side: BorderSide(color: Colors.red),
                  ),
                ),
              ),
              onPressed: () {
                authenticate(widget.membershipNumber, widget.phoneNumber);
              },
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  void navigateToHome() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool("is_authenticated", true);
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => DashboardScreen()),
      (Route<dynamic> route) => false,
    );
  }

  void authenticate(String membershipNumber, String phone) async {
    final AuthResponse response =
        await Repository().authenticate(membershipNumber, phone);

    if (response.status.toLowerCase() != "success") {}
  }
}
