import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:lions/src/constants.dart';

class CustomPopup extends StatefulWidget {
  final String title;
  final String image;

  const CustomPopup({Key key, this.title, this.image}) : super(key: key);

  @override
  _CustomPopupState createState() => _CustomPopupState();
}

class _CustomPopupState extends State<CustomPopup> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.padding),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Stack(
      children: <Widget>[
        Container(
          //height: 512,
          //width: 256,
          padding: EdgeInsets.only(
              left: Constants.padding,
              top: Constants.padding,
              right: Constants.padding,
              bottom: Constants.padding),
          //margin: EdgeInsets.only(top: Constants.avatarRadius),
          /*decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(Constants.padding),
            boxShadow: [
              BoxShadow(
                  color: Colors.black, offset: Offset(0, 10), blurRadius: 10),
            ],
          ),*/
          child: Image(
            image: NetworkImage(widget.image),
            fit: BoxFit.fitHeight,
          ),
          /*Align(
                alignment: Alignment.bottomRight,
                child: FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      widget.title,
                      style: TextStyle(fontSize: 18),
                    )),
              ),*/
        ),
        Positioned(
          top: -16.0,
          right: -16.0,
          child: InkWell(
            child: CircleAvatar(
              backgroundColor: Colors.transparent,
              radius: Constants.avatarRadius,
              child: ClipRRect(
                borderRadius:
                    BorderRadius.all(Radius.circular(Constants.avatarRadius)),
                child: Image.asset(
                  "assets/images/close.png",
                  height: 32.0,
                  width: 32.0,
                  color: Colors.white,
                ),
              ),
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          ),
        ),
      ],
    );
  }
}
