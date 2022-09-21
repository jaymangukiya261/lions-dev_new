import 'package:flutter/material.dart';
import 'package:lions/src/models/downloadable.dart';
import 'package:url_launcher/url_launcher.dart';

class DownladableListItem extends StatelessWidget {
  Downloadable downloadable;

  DownladableListItem({Key key, @required this.downloadable}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(16.0, 2.0, 16.0, 2.0),
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(downloadable.name),
              IconButton(
                icon: Icon(Icons.open_in_browser),
                onPressed: () {
                  downloadFile(downloadable.file);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void downloadFile(String remotePath) async {
    await canLaunch(remotePath) ? await launch(remotePath) : throw 'Could not launch $remotePath';
  }
}
