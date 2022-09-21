import 'package:flutter/material.dart';
import 'dart:math';

class Avatar extends StatelessWidget {
  Avatar({
    Key key,
    @required this.name,
    @required this.imageUrl,
    this.radius,
  }) : super(key: key);

  final _random = Random();

  final String name;
  final String imageUrl;
  final double radius;

  /*
  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(2.0),
        child: Image.network(
            "https://media.threatpost.com/wp-content/uploads/sites/103/2019/09/26105755/fish-1.jpg",
            //height: 124.0,
            width: 40.0,
            fit: BoxFit.fitWidth),
      );
    } else {
      return ClipRect(
        child: CircleAvatar(
          radius: radius ?? 24.0,
          backgroundColor:
              Colors.primaries[_random.nextInt(Colors.primaries.length)]
                  [_random.nextInt(9) * 100],
          child: Text(_getAvatarText(name)),
        ),
      );
    }
  }
  */

  @override
  Widget build(BuildContext context) {
    if (imageUrl != null) {
      return CircleAvatar(
        radius: radius ?? 32.0,
        backgroundImage: NetworkImage(imageUrl),
      );
    } else {
      return CircleAvatar(
        radius: radius ?? 32.0,
        backgroundColor:
            Colors.primaries[_random.nextInt(Colors.primaries.length)]
                [_random.nextInt(9) * 100],
        child: Text(_getAvatarText(name)),
      );
    }
  }

  String _getAvatarText(String name) {
    if (name == null) {
      return '';
    }
    List<String> nameList = name.split(' ');

    String avatarText = '';
    if (nameList.elementAt(0).characters.length > 0) {
      avatarText =
          avatarText + nameList.elementAt(0).characters.characterAt(0).string;
    }
    if (nameList.length > 1 && nameList.elementAt(1).characters.length > 0) {
      avatarText =
          avatarText + nameList.elementAt(1).characters.characterAt(0).string;
    }
    return avatarText;
  }
}
