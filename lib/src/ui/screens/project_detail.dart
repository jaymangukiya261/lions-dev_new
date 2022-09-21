import 'package:flutter/material.dart';
import 'package:lions/src/models/cabinet_member.dart';
import 'package:lions/src/models/project.dart';
import 'package:lions/src/ui/widget/avatar.dart';
import 'package:lions/src/ui/widget/member_profile_item.dart';
import 'package:lions/src/utils/utils.dart';

class ProjectDetail extends StatelessWidget {
  Project project;

  ProjectDetail({
    Key key,
    @required this.project,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      //resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image(
              image: NetworkImage(
                project.image,
              ),
              fit: BoxFit.fitWidth,
            ),
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    project.name,
                    textAlign: TextAlign.start,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                      //color: Color.fromRGBO(19, 34, 144, 1),
                    ),
                  ),
                  SizedBox(
                    height: 8.0,
                  ),
                  Text(
                    project.description,
                    textAlign: TextAlign.start,
                    style: TextStyle(
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                      //color: Color.fromRGBO(19, 34, 144, 1),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    //throw UnimplementedError();
  }
}
