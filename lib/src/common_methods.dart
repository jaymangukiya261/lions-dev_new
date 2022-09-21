import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lions/src/ui/screens/authentication_page.dart';

class CommonMethods {
  static void displayAlert(
      BuildContext context, String message, Function function) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: "OK",
        textColor: Colors.white,
        onPressed: () => function,
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }

  static void displayAlertToAuthenticate(BuildContext context, String message) {
    final snackbar = SnackBar(
      content: Text(message),
      backgroundColor: Colors.red,
      action: SnackBarAction(
        label: "OK",
        textColor: Colors.white,
        onPressed: () {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => AuthenticationPage()));
        },
      ),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackbar);
  }
}
